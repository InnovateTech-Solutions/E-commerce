import 'package:get/get.dart';

class testPageController extends GetxController {
  final RxBool isSearchBarOpen = false.obs;
  final RxString searchQuery = ''.obs;

  void toggleSearchBar() {
    isSearchBarOpen.value = !isSearchBarOpen.value;
    if (!isSearchBarOpen.value) {
      searchQuery.value =
          ''; // Clear the search query when closing the search bar
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}
