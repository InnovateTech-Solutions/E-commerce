import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/View/vendor/vendor_display.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:profile_part/src/transition/dashboard_transition.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';
import 'package:profile_part/src/widget/pages_widget/checkout/bookdetail_widget.dart';
import 'package:profile_part/src/widget/partial_widget/dashboard_partial.dart/nail_container.dart';

import '../../custom_Widget.dart/dashboard_title.dart';
import '../../partial_widget/dashboard_partial.dart/category_partial.dart';
import '../../partial_widget/dashboard_partial.dart/search_partial.dart';
import '../../partial_widget/dashboard_partial.dart/slider_widget.dart';
import '../../partial_widget/dashboard_partial.dart/toprated_partial.dart';

class DashBoradWidget extends StatefulWidget {
  const DashBoradWidget({Key? key}) : super(key: key);

  @override
  State<DashBoradWidget> createState() => _DashBoradWidgetState();
}

class _DashBoradWidgetState extends State<DashBoradWidget> {
  final firebaseservice = Get.put(FirebaseService());
  final _authRepo = Get.put(AuthenticationRepository());
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return UserRepository.instance.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to get email");
    }
  }

  @override
  void initState() {
    // getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(
          const Duration(milliseconds: 500),
          () => firebaseservice.fetchAdsAndCategories(),
        ),
        builder: (context, snpshot) {
          if (snpshot.connectionState == ConnectionState.done) {
            if (snpshot.hasData) {
              final ads = snpshot.data!['ads'];
              final categories = snpshot.data!['categories'];

              List<Widget> convertSnapshotsToWidgets(
                  List<DocumentSnapshot<Object?>>? documentSnapshots) {
                List<Widget> widgetsList = [];

                if (documentSnapshots != null) {
                  for (DocumentSnapshot<Object?> snapshot
                      in documentSnapshots) {
                    var data = snapshot.data() as Map<String, dynamic>?;

                    if (data != null) {
                      Widget documentWidget = AppContainer(
                          imgName: data['image'],
                          onTap: () => Get.to(categories,
                              transition: Transition.rightToLeft));

                      widgetsList.add(documentWidget);
                    }
                  }
                }

                return widgetsList;
              }

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    searchDashboard(),
                    SliderWidget(
                      item: convertSnapshotsToWidgets(ads),
                    ),
                    AppSizes.smallHeightSizedBox,
                    DashboardTitle("Trending Categories", () {
                      showBookingInfo(context);
                    }),
                    SizedBox(
                      width: 350.w,
                      height: 200.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categories?.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: 150.w,
                                  height: 150.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14.r))),
                                  child: CategoryContainer(
                                    imgName: categories?[index]['Icon'],
                                    onTap: () => Get.to(
                                        VendorDisplaypage(
                                            title: categories?[index]['Title']),
                                        transition: Transition.rightToLeft),
                                  ),
                                ),
                                Container(
                                  child: Text(categories?[index]['Title'],
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstants
                                                  .mainTextColor))),
                                )
                              ],
                            );
                          })),
                    ),
                    NailWidget(),
                    TopRated()
                  ],
                ),
              );
            } else if (snpshot.hasError) {
              return Text('Erorr${snpshot.error}');
            } else {
              return const Text("somthing went wrong");
            }
          } else if (snpshot.connectionState == ConnectionState.waiting) {
            return const DashboardTransition();
          } else {
            return const Text("somthing went wrong");
          }
        });
  }
}
