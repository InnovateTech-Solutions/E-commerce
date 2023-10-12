import 'package:get/get.dart';
import 'package:profile_part/src/View/NavBar_pages/main_page.dart';
import 'package:profile_part/src/View/start_pages/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefess extends GetxController {
  static Prefess get instance => Get.find();
  void upDateSharedPreferences(String email, String name, String phone) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('name', name);
    _prefs.setString('email', email);
    _prefs.setString('phone', phone);
  }

  void saveImgeUrl(String imgUrl) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("imageUrl", imgUrl);
  }

  void login() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("showHome", true);
  }

  void logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("showHome", false);
  }
}
