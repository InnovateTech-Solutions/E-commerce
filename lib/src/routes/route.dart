import 'package:ecommerce/src/View/Forms/login_page.dart';
import 'package:ecommerce/src/View/Forms/register_page.dart';
import 'package:ecommerce/src/View/setting/edit_page.dart';
import 'package:ecommerce/src/View/setting/profile_page.dart';
import 'package:get/get.dart';

class Routes {
  static String LoginPage = '/LoginPage';
  static String RegisterPage = '/RegisterPage';
  static String ProfilePage = '/ProfilePage';
  static String screen4 = '/screen4';
  static String screen5 = '/screen5';
}

appRoutes() => [
      GetPage(
        name: Routes.LoginPage,
        page: () => const LoginPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routes.RegisterPage,
        page: () => const RegisterPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routes.ProfilePage,
        page: () => const ProfilePage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/EditProfilePage',
        page: () => const EditProfilePage(),
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