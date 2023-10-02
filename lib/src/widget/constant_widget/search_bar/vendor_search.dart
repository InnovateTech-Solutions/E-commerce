import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/vendor/vendor_page.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/Searchpage_controller.dart';
import 'package:profile_part/src/getx/search_controller.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/location_widget.dart';

class VendorSearchBar extends GetWidget<SearchPageController> {
  const VendorSearchBar({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    Get.put(PageController());
    final searchcontroller = Get.put(SearchControllerr(title));

    return Obx(() {
      final searchController = Get.find<SearchPageController>();

      if (searchController.isSearchBarOpen.value) {
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        searchcontroller.filterPlayer(query);
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
                    itemCount: searchcontroller.filteredList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {
                          Get.to(VendorPage(
                              vendor: searchcontroller.filteredList[index])),
                          print(searchcontroller.filteredList.length)
                        },
                        child: LocationWidget(
                            imageUrl:
                                searchcontroller.filteredList[index].image,
                            name: searchcontroller.filteredList[index].name,
                            description: searchcontroller
                                .filteredList[index].description),
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
