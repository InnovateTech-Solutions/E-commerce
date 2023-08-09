import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/src/constant/color.dart';
import 'package:ecommerce/src/model/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) {
    _db
        .collection("User")
        .add(user.tojason())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been created",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConstants.mainScaffoldBackgroundColor,
            backgroundColor: ColorConstants.snakbarColorsuccessful))
        .catchError((error, stackTrace) {
      Get.snackbar(error.toString(), "Something went wrong , try agin",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("User").where("Email", isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userdata;
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("User").doc(user.id).update(user.tojason());
  }
}
