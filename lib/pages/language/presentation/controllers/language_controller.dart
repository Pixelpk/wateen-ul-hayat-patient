import 'package:swift_care/pages/home/presentation/views/home_screen.dart';
import 'package:swift_care/pages/onboarding/presentation/views/onboarding_screen.dart';

import '../../../../export.dart';

class LanguageController extends GetxController {
  @override
  Future<void> onInit() async {
    log.e(storage.read(LOCALKEY_currentLang));

    Get.updateLocale(await storage.read(LOCALKEY_currentLang) == null
        ? Locale('en', 'US')
        : storage.read(LOCALKEY_currentLang) == 'en'
            ? Locale('en', 'US')
            : Locale('ar', 'SA'));
    return super.onInit();
  }

  changeLocale() => Get.updateLocale(Get.locale?.countryCode!.camelCase! == 'us'
      ? Locale('ar', 'SA')
      : Locale('en', 'US'));

  bool? isLangSelected = true;
  bool? defaultEng = true;
  bool? enSelected = Get.locale?.countryCode?.camelCase! == 'us' ? true : false;
  RxString lang = 'en'.obs;

  changeDefault() {
    defaultEng = false;
    update();
  }

  activeEnBG() => enSelected = true;

  activeArBG() => enSelected = false;

  onContinue() {
    if (storage.read(LOCALKEY_token) == null) {
      storage.write(LOCALKEY_language, true);
      enSelected! ? lang.value = 'en' : lang.value = 'ar';
      if (Get.locale?.countryCode?.camelCase == 'sa') {
        storage.write(LOCALKEY_currentLang, 'ar');
      } else {
        storage.write(LOCALKEY_currentLang, 'en');
      }
      Get.off(() => OnboardingScreen());
    } else
      Get.off(() => HomeScreen());
  }
}
