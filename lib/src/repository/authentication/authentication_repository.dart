// ignore_for_file: invalid_return_type_for_catch_error

import 'package:ecommerce/src/View/Forms/login_page.dart';
import 'package:ecommerce/src/View/Forms/main_page.dart';
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
        : Get.offAll(const IntroPage());
  }

  _setScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    googleSignInAccount == null
        ? Get.offAll(const LoginPage())
        : Get.offAll(const IntroPage());
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

  Future<void> logout() async => await _auth.signOut();
}
