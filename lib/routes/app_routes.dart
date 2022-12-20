import 'package:get/get.dart';
import 'package:swift_care/export.dart';
import 'package:swift_care/pages/authentication/presentation/views/signup_screen.dart';
import 'package:swift_care/pages/home/binding/binding.dart';
import 'package:swift_care/routes/routes.dart';

import '../pages/authentication/binding/binding.dart';
import '../pages/authentication/presentation/views/forget_screen.dart';
import '../pages/authentication/presentation/views/verification_screen.dart';
import '../pages/home/presentation/views/bottom_navigation_screen.dart';

class AppPages {
  static const initialRoute = Routes.splashRoute;

  static final routes = [
    GetPage(
      name: Routes.splashRoute,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.loginWithScreenRoute,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.signUpScreenRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
        name: Routes.loginScreenRoute,
        page: () => LoginScreen(),
        binding: AuthenticationBinding()),
    GetPage(
        name: Routes.bottomNavigationScreenRoute,
        page: () => BottomNavigationScreen(),
        binding: HomeBinding()),
    GetPage(
      name: Routes.forgetScreenRoute,
      page: () => ForgetScreen(),
    ),
  ];
}
