// ignore_for_file: unnecessary_null_comparison, body_might_complete_normally_catch_error

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/user_controller.dart';
import 'package:profile_part/src/model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final userController = Get.put(UserController());

  final _db = FirebaseFirestore.instance;

  late UserModel userModel;

  void setUserModel(UserModel userModel) {
    this.userModel = userModel;
  }

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

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("User").doc(user.id).update(user.tojason());
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("User").where("Email", isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    userModel = userdata;
    userController.saveUserInfo(userdata);
    return userdata;
  }

// to see if user is Exits to make google , Apple Authentication
  Future<bool> userExist(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot userSnapshot =
          await users.where('Email', isEqualTo: email).get();

      return userSnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking user existence: $e');
      return false;
    }
  }

  Widget getUserImageUrl() {
    if (userModel.imageUrl != null) {
      return CircleAvatar(
          radius: 70, // Adjust the radius as needed
          backgroundImage: NetworkImage(userModel.imageUrl!));
    } else {
      return SvgPicture.asset(
        "assets/Profilepic.svg",
        width: 100.w,
        height: 100.h,
      );
    }
  }

  void addImage() {
    _db
        .collection("User")
        .where('Email', isEqualTo: userModel.email)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        userDoc.reference.update({'imageUrl': userModel.imageUrl});
      }
    });
  }

  void pickUpImage() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 500.h,
      maxWidth: 500.w,
      imageQuality: 75,
    );
    if (file == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child("images");

    Reference referenceImageToUpload = referenceDirImage.child(file.path);
    try {
      await referenceImageToUpload.putFile(File(file.path));

      userModel.imageUrl = await referenceImageToUpload.getDownloadURL();

      addImage();
    } catch (error) {
      Text(error.toString());
    }
  }
}
