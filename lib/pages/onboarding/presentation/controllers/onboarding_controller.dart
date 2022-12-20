import 'package:swift_care/pages/authentication/presentation/views/signup_screen.dart';

import '../../../../export.dart';

class OnboardingController extends GetxController {
  var introKey = GlobalKey<IntroductionScreenState>();

  var page = pages;
  int currentIndex = 0;

  onSkip() {
    storage.write(LOCALKEY_onboarding, true);
    // Get.off(() => LoginScreen());
    Get.off(() => SignUpScreen());
  }

  onSlide(index) {
    currentIndex = index;
    update();
  }
}
