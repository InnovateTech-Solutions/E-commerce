// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/View/Forms/login_page.dart';
import 'package:ecommerce/src/View/setting/sitting_page.dart';
import 'package:ecommerce/src/getx/register_controller.dart';
import 'package:ecommerce/src/model/user_model.dart';
import 'package:ecommerce/src/repository/exceptions/signup_email_password_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final controller = Get.put(RegisterController());

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  GoogleSignIn googleSign = GoogleSignIn();

  late Rx<GoogleSignInAccount?> googleSignInAccount;

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
    user == null
        ? Get.offAll(const LoginPage())
        : Get.offAll(const SittingPage());
  }

  _setScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    googleSignInAccount == null
        ? Get.offAll(const LoginPage())
        : Get.offAll(const SittingPage());
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
        final List<String> signInMethods =
            await _auth.fetchSignInMethodsForEmail(googleSignInAccount.email);
        if (signInMethods.isEmpty) {
          controller.createUser(UserModel(
              email: googleSignInAccount.email,
              name: googleSignInAccount.displayName.toString(),
              password: "",
              phone: ""));
        }
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

      // Delete the user document with the given email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User')
          .where("Email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        await user.delete();
        print('User account deleted successfully.');
        Get.offAll(LoginPage());
        Get.snackbar("User account Deleted", "Success");
      } else {
        Get.snackbar("Error", "User with the provided email not found.");
      }
    } catch (error) {
      print('Error deleting user account: $error');
      Get.snackbar("Error", "Failed to delete user account.");
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
