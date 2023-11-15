import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/Searchpage_controller.dart';
import 'package:profile_part/src/getx/search_controller.dart';
import 'package:profile_part/src/widget/constant_widget/search_bar/vendor_search.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';
import 'package:profile_part/src/widget/pages_widget/Vendor/vendors_display.dart';

class VendorListSearchWidget extends GetView {
  const VendorListSearchWidget({required this.title, super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    final pagecontroller = Get.put(SearchPageController());

    final searchController = Get.put(SearchControllerr(title));

    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryScaffoldBacground,
        leading: Obx(() => pagecontroller.isSearchBarOpen.value
            ? Container()
            : IconButton(
                onPressed: () => {
                      Get.back(),
                    },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: ColorConstants.mainTextColor,
                ))),
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.mainTextColor)),
        ),
        actions: [VendorSearchBar(title: title)],
      ),
      body: Obx(() => pagecontroller.isSearchBarOpen.value
          ? SizedBox(
              width: double.infinity,
              height: 690.h,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: searchController.filteredList.length,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(VendorPage(
                              vendor: searchController.filteredList[index])),
                          child: LocationWidget(
                              imageUrl:
                                  searchController.filteredList[index].image,
                              name: searchController.filteredList[index].name,
                              description: searchController
                                  .filteredList[index].description),
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
