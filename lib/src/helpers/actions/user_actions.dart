import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

GestureDetector imagepicker() {
  final usercontroller = Get.put(UserRepository());

  return GestureDetector(
    onTap: () async {
      usercontroller.pickUpImage();
    },
    child: Container(
      width: 150.w,
      height: 100.h,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: usercontroller.getUserImageUrl(),
    ),
  );
}

Future<void> launchMap(String? address) async {
  final List<String> coordinates = address!.split(',');
  if (coordinates.length != 2) {
    throw "Invalid address format";
  }

  final String latitude = coordinates[0];
  final String longitude = coordinates[1];

  final String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
  final String appleMapsUrl = "https://map.apple.com/?q=$latitude,$longitude";

  final Uri googleMapsUri = Uri.parse(googleMapsUrl);
  final Uri appleMapsUri = Uri.parse(appleMapsUrl);

  try {
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else if (await canLaunchUrl(appleMapsUri)) {
      await launchUrl(appleMapsUri);
    } else {
      throw "Couldn't launch URL";
    }
  } catch (e) {
    throw "Error launching URL: $e";
  }
}

class PreferencesHelper {
  static const String isLoggedInKey = 'isLoggedIn';

  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }
}
