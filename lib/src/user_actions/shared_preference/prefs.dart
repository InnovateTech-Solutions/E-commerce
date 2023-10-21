import 'dart:convert';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Prefess extends GetxController {
  static Prefess get instance => Get.find();
  void upDateSharedPreferences(
      {required String email,
      required String name,
      required String phone}) async {
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

  void getUserDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.getString('email');
    _prefs.getString('name');
    _prefs.getString('phone');
  }

  Future<void> printSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Replace 'your_key' with the actual key you used when saving the data.
    final String? value = prefs.getString('phone');

    if (value != null) {
      print('Value from Shared Preferences: $value');
    } else {
      print('No value found for the specified key.');
    }
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('phone') ?? "";
    return stringValue;
  }
}

class SharedPref extends GetxController {
  static SharedPref get instance => Get.find();

  RxString email = 'null email'.obs;
  RxString name = 'null name'.obs;
  RxString phone = 'null phone'.obs;
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? "null");
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future saveJasonData(jasonData) async {
    final prefes = await SharedPreferences.getInstance();
    var saveData = jsonEncode(jasonData);
    await prefes.setString('key', saveData);
  }

  Future saveUserJasonData(
      {required email, required name, required phone}) async {
    final prefes = await SharedPreferences.getInstance();
    var userEmail = jsonEncode(email);
    var userName = jsonEncode(name);
    var userPhoneNumber = jsonEncode(phone);
    await prefes.setString('email', userEmail);
    await prefes.setString('name', userName);
    await prefes.setString('phone', userPhoneNumber);
    var temp = prefes.getString('email');
    var tempusername = prefes.getString('name');

    print('Data recvied :$temp ');
    print('Data recvied :$tempusername ');
  }

  Future<void> getJason() async {
    final prefes = await SharedPreferences.getInstance();
    var temp = prefes.getString('email');
    var tempusername = prefes.getString('name');
    var tempuserPhone = prefes.getString('phone');

    print('Data recvied :$temp ');
    print('Data recvied :$tempusername ');

    print('Data recvied :$tempuserPhone ');
//    var data = UserModel.fromSnapshot(jsonDecode(temp.toString()));
    //  print(data.email.toString());
    // print(data.name.toString());
  }

  deleteSharedPreferences() async {
    final prefes = await SharedPreferences.getInstance();
    prefes.remove('key');
    print('pref delete');
  }

  deleteSharedPreferencesUserDeatils() async {
    final prefes = await SharedPreferences.getInstance();
    prefes.remove('email');
    prefes.remove('name');
    prefes.remove('phone');
    prefes.clear();
    print('pref delete');
  }

  Future<String?> getUserEmail() async {
    final prefes = await SharedPreferences.getInstance();
    email.value = prefes.getString('email') ?? 'null ';

    update();
    return null;
  }

  Future<String?> getUserName() async {
    final prefes = await SharedPreferences.getInstance();
    name.value = prefes.getString('name') ?? 'null ';
    update();
    return null;
  }

  Future<String?> getUserPhone() async {
    final prefes = await SharedPreferences.getInstance();
    phone.value = prefes.getString('phone') ?? 'null ';
    update();
    return null;
  }

  getuserDetails() async {
    final prefes = await SharedPreferences.getInstance();

    phone.value = prefes.getString('phone') ?? 'null';
    name.value = prefes.getString('name') ?? 'null ';
    name.value = prefes.getString('email') ?? 'null ';
    update();
  }
}
