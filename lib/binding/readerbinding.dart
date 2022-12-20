import 'package:swift_care/pages/authentication/presentation/controllers/complete_profile_screen_controller.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/forgot_controller.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/loginController.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/signup_controller.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';

import '../export.dart';
import '../pages/bookings/presentation/controller/book_tab_controller.dart';

class ReaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(OnboardingController());
    Get.put(SignUpController());
    Get.put(LoginController());
    Get.put(ForgotController());
    Get.put(BottomNavigationController());
    // Get.put(BookServiceProviderController());
  }
}
