import 'dart:async';

import 'package:swift_care/export.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/views/signup_screen.dart';
import 'package:swift_care/pages/home/presentation/views/bottom_navigation_screen.dart';
import 'package:swift_care/service/local_service/local_keys.dart';

import '../../../authentication/presentation/controllers/complete_profile_screen_controller.dart';
import '../../../authentication/presentation/views/completer_profile_screen.dart';
import '../../../authentication/presentation/views/verification_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    update();
    _navigateToNextScreen();
    super.onInit();
  }

  _navigateToNextScreen() => Timer(Duration(milliseconds: 3500), () async {
    var value=await storage.read(LOCALKEY_token);
    var value2=await storage.read(LOCALKEY_profile);
    if(value!=null && value2!=null ){
      SignUpResponseModel? signUpResponseModel=SignUpResponseModel();
      signUpResponseModel=SignUpResponseModel.fromJson(value2);

      if(signUpResponseModel.detail?.otpVerified==1){
        if(signUpResponseModel.detail?.fullName == null){
          var ctrl=Get.put(CompleteProfileController());
          ctrl.hitGetNationalitiesListAPI();
          ctrl.setUserProfile();

          Get.to(CompleteProfile(
            title: STRING_CompleteProfilee.tr,
          ));
          snackBar(STRING_CompleteProfile.tr);
        }else{
          Get.offAll(() =>BottomNavigationScreen());
        }

    }
      else{
        Get.offAll(() => SignUpScreen());

      }

    }else{
      Get.offAll(() => SignUpScreen());
    }
        /*if (storage.read(LOCALKEY_onboarding) ?? false) {
          if (storage.read(LOCALKEY_token) != null)
            Get.offAll(() => HomeScreen());
          else
            Get.offAll(() => SignUpScreen());
        } else if (storage.read(LOCALKEY_language) ?? false)
          Get.offAll(() => OnboardingScreen());
        else {
          Get.offAll(() => SignUpScreen());
        }*/
      });
}
