/*
import 'package:get/get.dart';
import 'package:profile_part/src/View/NavBar_pages/categories_page.dart';
import 'package:profile_part/src/View/NavBar_pages/dashborad_page.dart';
import 'package:profile_part/src/View/NavBar_pages/map_page.dart';
import 'package:profile_part/src/View/setting/profile_page.dart';
import 'package:profile_part/src/View/setting/setting_page.dart';
import 'package:profile_part/src/View/setting/update_profile.dart';
import 'package:profile_part/src/View/start_pages/intro_page.dart';


appRoutes() => [
      GetPage(
        name: '/home',
        page: () => IntroPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/DashBoard',
        page: () => DashBoard(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/CategoriesPage',
        page: () => CategoriesPage(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/MapPage',
        page: () => MapPage(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/ProfilePage',
        page: () => ProfilePage(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/UpdateProfile',
        page: () => UpdateProfile(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/CategoriesPage',
        page: () => SettingPage(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}*/