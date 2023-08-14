// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:ecommerce/src/View/Forms/main_page.dart';
import 'package:ecommerce/src/View/start_pages/intro_page.dart';
import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/repository/exceptions/signup_email_password_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  GoogleSignIn googleSign = GoogleSignIn();

  late Rx<GoogleSignInAccount?> googleSignInAccount;
  var verificationID = ''.obs;
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
    user == null ? Get.offAll(const IntroPage()) : Get.offAll(const Testpage());
  }

  _setScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    googleSignInAccount == null
        ? Get.offAll(const IntroPage())
        : Get.offAll(const Testpage());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const IntroPage())
          : Get.to(() => const Testpage());
    } on FirebaseException catch (e) {
      final ex = SignUpWithEmailAndPasswordfailure.code(e.code);
      Get.snackbar("FILED", ex.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);

      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordfailure();
      Get.snackbar("EXCEPTION", ex.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
      throw ex;
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
        // ignore: duplicate_ignore
        await _auth
            .signInWithCredential(credential)
            .catchError((onError) => print(onError));
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

  Future<void> logout() async => await _auth.signOut();
}
