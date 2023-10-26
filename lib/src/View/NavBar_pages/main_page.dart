import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:profile_part/src/View/NavBar_pages/categories_page.dart';
import 'package:profile_part/src/View/NavBar_pages/dashborad_page.dart';
import 'package:profile_part/src/View/NavBar_pages/map_page.dart';
import 'package:profile_part/src/View/setting/profile_page.dart';
import 'package:profile_part/src/View/test/test.dart';
import 'package:profile_part/src/constant/color.dart';

import '../../repository/service_repository/service_data.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final firebaseservice = Get.put(FirebaseService());

  int _selectedIndex = 0;
  static final List<Widget> _widgetsOptions = [
    const DashBoard(),
    const CategoriesPage(),
    const MapPage(),
    UserInfoPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
      body: Center(
        child: _widgetsOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorConstants.mainScaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 5,
              activeColor: ColorConstants.mainTextColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: ColorConstants.mainTextColor,
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                ),
                GButton(
                  icon: Icons.category_outlined,
                ),
                GButton(
                  icon: Icons.location_on_outlined,
                ),
                GButton(
                  icon: Icons.access_time_outlined,
                ),
                GButton(
                  icon: Icons.account_circle_outlined,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
