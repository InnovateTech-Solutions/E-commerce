// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profile_part/src/View/Forms/login_page.dart';
import 'package:profile_part/src/View/NavBar_pages/main_page.dart';
import 'package:profile_part/src/View/start_pages/intro_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/model/user_model.dart';
import 'package:profile_part/src/repository/exceptions/signup_email_password_failure.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  GoogleSignIn googleSign = GoogleSignIn();

  late Rx<GoogleSignInAccount?> googleSignInAccount;
  var verificationID = ''.obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);

    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setScreenGoogle);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(const IntroPage()) : Get.offAll(const MainPage());
  }

  _setScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    googleSignInAccount == null
        ? Get.offAll(const IntroPage())
        : Get.offAll(const MainPage());
  }

  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      Get.snackbar("ERROR ", "${e.message}",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
      return false;
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth
            .signInWithCredential(credential)
            .catchError((onError) => print(onError));

        bool userExists =
            await userRepository.userExist(googleSignInAccount.email);

        if (userExists) {
          userRepository.createUser(UserModel(
              email: googleSignInAccount.email,
              name: googleSignInAccount.displayName!.trim(),
              password: '',
              phone: '',
              imageUrl: googleSignInAccount.photoUrl ?? ''));
        } else {
          print('welcame back');
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (firebaseAuthException) {
      print(firebaseAuthException);
    }
  }

  Future<bool> login(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(LogInWithEmailAndPasswordFailure.code(e.code).message);
      return false;
    }
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid');
          } else {
            Get.snackbar('Error', 'The provided phone number is not valid');
          }
        },
        codeSent: ((verificationId, forceResendingToken) {
          verificationID.value = verificationId;
        }),
        codeAutoRetrievalTimeout: ((verificationId) {
          verificationID.value = verificationId;
        }));
  }

  Future<bool> verifyOTP(String otp) async {
    var credentails = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationID.value, smsCode: otp));

    return credentails.user != null ? true : false;
  }

  void deleteUserAccount(String email, String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar("Error", "No user is currently signed in.");
        return;
      }

      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await user.reauthenticateWithCredential(credential);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User')
          .where("Email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        await user.delete();
        print('User account deleted successfully.');
        Get.offAll(const LoginPage());
        Get.snackbar("User account Deleted", "Success");
      } else {
        Get.snackbar("Error", "User with the provided email not found.");
      }
    } catch (error) {
      print('Error deleting user account: $error');
      Get.snackbar("Error", "Failed to delete user account.");
    }
  }

  Future<void> logout() async => {await _auth.signOut(), googleSign.signOut()};
}
