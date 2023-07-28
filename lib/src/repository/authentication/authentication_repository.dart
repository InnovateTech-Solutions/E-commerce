// ignore_for_file: invalid_return_type_for_catch_error

import 'package:ecommerce/src/View/Forms/login_page.dart';
import 'package:ecommerce/src/View/Forms/main_page.dart';
import 'package:ecommerce/src/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  GoogleSignIn googleSign = GoogleSignIn();

  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    firebaseUser.bindStream(auth.userChanges());
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
        await auth
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

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  Future<void> logout() async => await auth.signOut();
}
