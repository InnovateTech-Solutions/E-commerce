import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profile_part/src/getx/dashboard_controller.dart';
import 'package:profile_part/src/getx/notifications_controller.dart';
import 'package:profile_part/src/model/search_model.dart';
import 'package:profile_part/src/repository/authentication/authentication_repository.dart';
import 'package:profile_part/src/repository/service_repository/service_data.dart';
import 'package:profile_part/src/repository/user_repository/user_repository.dart';
import 'package:profile_part/src/transition/dashboard_transition.dart';
import 'package:profile_part/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/container_widget.dart';
import 'package:profile_part/src/widget/partial_widget/dashboard_partial.dart/category_partial.dart';
import 'package:profile_part/src/widget/partial_widget/dashboard_partial.dart/random_container.dart';
import 'package:profile_part/src/widget/partial_widget/dashboard_partial.dart/search_partial.dart';

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
  final notificationsController = Get.put(NotificationsController());

  getUserData() async {
    late final email = _authRepo.firebaseUser.value?.email;
    await notificationsController.updateFCMToken(email);
    // print("fcmToken ${}");
    if (email != null) {
      return await UserRepository.instance.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to get email");
    }
  }

  final controller = Get.put(DashboardController());

  @override
  void initState() {
    getUserData();
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
                    SizedBox(
                      width: 320.w,
                      child: SearchWidget(
                        search: SearchFormEntitiy(
                          hintText: "Search",
                          searchController: null,
                          icon: Icon(Icons.search, color: Colors.grey),
                          type: TextInputType.text,
                          onChange: (String) {},
                        ),
                      ),
                    ),
                    AppSizes.smallHeightSizedBox,
                    SliderWidget(
                      item: convertSnapshotsToWidgets(ads),
                    ),
                    AppSizes.smallHeightSizedBox,
                    TopCategory(),
                    RandomWidget(),
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
          } else if (snpshot.connectionState == ConnectionState.none) {
            return CircularProgressIndicator();
          } else {
            return const Text("somthing went wrong");
          }
        });
  }
}
