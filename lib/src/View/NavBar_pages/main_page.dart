import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../constant/color.dart';
import '../map.dart';
import '../setting/profile_page.dart';
import 'dashborad_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetsOptions = [
    const DashBoard(),
    const DashBoard(),
    const MapWidget(),
    const DashBoard(),
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
          color: Colors.white,
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
              rippleColor: ColorConstants.mainTextColor,
              gap: 5,
              activeColor: ColorConstants.mainTextColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              color: ColorConstants.buttonColor,
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  iconColor: ColorConstants.mainTextColor,
                ),
                GButton(
                  icon: Icons.category_outlined,
                  iconColor: ColorConstants.mainTextColor,
                ),
                GButton(
                  icon: Icons.location_on_outlined,
                  iconColor: ColorConstants.mainTextColor,
                ),
                GButton(
                  icon: Icons.access_time_outlined,
                  iconColor: ColorConstants.mainTextColor,
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  iconColor: ColorConstants.mainTextColor,
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
