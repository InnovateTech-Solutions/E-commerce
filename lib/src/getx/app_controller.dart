import 'package:get/get.dart';

class Appcontroller extends GetxController {
  var tabstatus = false.obs;
  final RxInt selectedIndex = 0.obs; // Declare selectedIndex outside the class
  var currentIndex = 0.obs;

  void toggleTabs() {
    tabstatus.value = !tabstatus.value;
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
