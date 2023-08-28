import 'package:ecommerce/src/View/Forms/login_page.dart';
import 'package:ecommerce/src/View/Forms/register_page.dart';
import 'package:ecommerce/src/View/setting/profile_page.dart';
import 'package:ecommerce/src/View/setting/update_profile.dart';
import 'package:get/get.dart';

class Routes {
  static String loginPage = '/LoginPage';
  static String registerPage = '/RegisterPage';
  static String profilePage = '/ProfilePage';
  static String screen4 = '/screen4';
  static String screen5 = '/screen5';
}

appRoutes() => [
      GetPage(
        name: Routes.loginPage,
        page: () => const LoginPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routes.registerPage,
        page: () => const RegisterPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routes.profilePage,
        page: () => const ProfilePage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/UpdateProfile',
        page: () => const UpdateProfile(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
