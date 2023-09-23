import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../constant/color.dart';
import '../../getx/reset_pw_controller.dart';
import '../user_repository/user_repository.dart';

class ResetPasswordRepository extends GetxController {
  static ResetPasswordRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final userController = Get.put(UserRepository());
  final resetPwController = Get.put(ResetPasswordController());

  Future<void> reAuth(String oldPassword) async {
    final user = _auth.currentUser;
    // Reauthenticate user for security
    final credential = EmailAuthProvider.credential(
      email: userController.userModel.email,
      password: userController.userModel.password,
    );
    await user?.reauthenticateWithCredential(credential);
  }

  Future<void> updatePasswordFirestore() async {
    _db
        .collection("User")
        .where('Email', isEqualTo: userController.userModel.email)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        userDoc.reference
            .update({'Password': resetPwController.newPassword.text.trim()});
      }
    });
  }

  Future<void> changePassword(
      String newPassword, String confirmPassword) async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        // Check if the new password and confirm password match
        if (newPassword != confirmPassword) {
          Get.snackbar(
              "Failure", "New password and confirm password do not match",
              snackPosition: SnackPosition.BOTTOM,
              colorText: ColorConstants.mainScaffoldBackgroundColor,
              backgroundColor: ColorConstants.snakbarColorError);
        } else {
          // Update the password
          await user.updatePassword(newPassword).whenComplete(() {
            Get.snackbar(
                "Success", "Your Password has been changed succesfullly",
                snackPosition: SnackPosition.BOTTOM,
                colorText: ColorConstants.mainScaffoldBackgroundColor,
                backgroundColor: ColorConstants.snakbarColorsuccessful);

            updatePasswordFirestore();
          }).catchError((error, stackTrace) {
            Get.snackbar(error.toString(), "Something went wrong , try agin",
                snackPosition: SnackPosition.BOTTOM,
                colorText: ColorConstants.mainScaffoldBackgroundColor,
                backgroundColor: ColorConstants.snakbarColorError);
          });
        }

        print("Password updated successfully!");
      } else {
        Get.snackbar("Failure", "User is not logged in.",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConstants.mainScaffoldBackgroundColor,
            backgroundColor: ColorConstants.snakbarColorError);

        print("User is not logged in.");
      }
    } on FirebaseAuthException catch (error) {
      Get.snackbar("Failure", error.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);

      print("Password update error: $error");
    }
  }
}
