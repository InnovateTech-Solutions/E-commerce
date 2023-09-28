import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/page_controller.dart';
import 'package:profile_part/src/getx/search_controller.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';
import 'package:profile_part/src/widget/pages_widget/Vendor/vendors_display.dart';

class VendorListSearchWidget extends GetView<PageController> {
  const VendorListSearchWidget({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller1 = Get.put(SearchControllerr(title));
    final pagecontroller = Get.put(testPageController());

    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryScaffoldBacground,
        leading: Obx(() => pagecontroller.isSearchBarOpen.value
            ? Container()
            : IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: ColorConstants.mainTextColor,
                ))),
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.mainTextColor)),
        ),
        actions: [
          GetXSearchBar(
            title: title,
          ),
        ],
      ),
      body: Obx(() => pagecontroller.isSearchBarOpen.value
          ? SizedBox(
              width: double.infinity,
              height: 690.h,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller1.filteredList.length,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(VendorPage(
                              vendor: controller1.filteredList[index])),
                          child: LocationWidget(
                              imageUrl: controller1.filteredList[index].image,
                              name: controller1.filteredList[index].name,
                              description:
                                  controller1.filteredList[index].description),
                        )
                      ],
                    ));
                  }),
            )
          : VendorDisplayWidget(
              category: title,
            )),
    );
  }
}

class GetXSearchBar extends GetWidget<PageController> {
  const GetXSearchBar({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    Get.put(PageController());
    final controller1 = Get.put(SearchControllerr(title));

    return Obx(() {
      final searchController = Get.find<testPageController>();

      if (searchController.isSearchBarOpen.value) {
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        controller1.filterPlayer(query);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0,
                          color: ColorConstants.mainTextColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    color: ColorConstants.mainTextColor,
                    icon: const Icon(
                      Icons.close,
                    ), // X icon
                    onPressed: () {
                      searchController.toggleSearchBar();
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller1.filteredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {
                          Get.to(VendorPage(
                              vendor: controller1.filteredList[index])),
                          print(controller1.filteredList.length)
                        },
                        child: LocationWidget(
                            imageUrl: controller1.filteredList[index].image,
                            name: controller1.filteredList[index].name,
                            description:
                                controller1.filteredList[index].description),
                      );
                    }),
              )
            ],
          ),
        );
      } else {
        return IconButton(
          color: ColorConstants.mainTextColor,
          icon: const Icon(Icons.search),
          onPressed: () {
            searchController.toggleSearchBar();
          },
        );
      }
    });
  }
}

class PageController extends GetxController {
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
