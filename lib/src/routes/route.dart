import 'package:ecommerce/src/View/Forms/login_page.dart';
import 'package:ecommerce/src/View/Forms/register_page.dart';
import 'package:ecommerce/src/View/setting/edit_page.dart';
import 'package:ecommerce/src/View/setting/profile_page.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/LoginPage',
        page: () => const LoginPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/RegisterPage',
        page: () => const RegisterPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/Profilepage',
        page: () => const ProfilePage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/EditProfilePage',
        page: () => EditProfilePage(),
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
