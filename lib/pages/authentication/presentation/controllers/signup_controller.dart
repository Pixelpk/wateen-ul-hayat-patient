import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/otp_verification_response_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/complete_profile_screen_controller.dart';
import 'package:swift_care/pages/authentication/presentation/views/change_password.dart';
import 'package:swift_care/pages/authentication/presentation/views/completer_profile_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/forget_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/verification_screen.dart';
import 'package:swift_care/pages/home/presentation/views/home_screen.dart';
import 'package:swift_care/service/remote_service/entity/request_model/auth_reuest_model.dart';

import '../../../../export.dart';

class SignUpController extends SuperController {
  late TextEditingController contactController;
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late TextEditingController otpController;
  late FocusNode contactFocusNode;
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode otpFocusNode;
  late FocusNode loginFocusNode;
  SignUpResponseModel? loginModel = SignUpResponseModel();
  OtpVerificationResponseModel? otpVerificationResponseModel =
      OtpVerificationResponseModel();
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;
  RxBool loader = false.obs;
  String? dropValue = 'English';
  bool agreeTerms = false;
  String selectedCountryCode = '+966';

  bool hidePswd = true;

  updateHidePswd() {
    hidePswd = !hidePswd;
    update();
  }

  updateAgreeTerms() {
    agreeTerms = !agreeTerms;
    update();
  }

  updateSelectedCountryCode(String value) {
    selectedCountryCode = value;
    update();
  }

  late int deviceType;
  late String deviceName, deviceToken;

  deviceDetails() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      deviceType = 1;
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = androidDeviceInfo.device!;
      deviceToken = '';
    } else if (Platform.isIOS) {
      deviceType = 2;
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.localizedModel!;
      deviceToken = '';
    }
    update();
  }

  @override
  void onInit() {
    contactController = TextEditingController();
    forgetEmailController = TextEditingController();
    passwordController = TextEditingController();
    otpController = TextEditingController();
    contactFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    otpFocusNode = FocusNode();
    customLoader = CustomLoader();

    deviceDetails();
    getLanguageData();
    super.onInit();
  }

  getLanguageData() {
    if (storage.read(LOCALKEY_english) == null ||
        storage.read(LOCALKEY_english) == true) {
      dropValue = STRING_english;
    } else {
      dropValue = STRING_arabic.tr;
    }
    update();
  }

  @override
  void onClose() {
    customLoader.hide();

    super.onClose();
  }

  @override
  void onReady() {
    update();
  }

  //API's
  hitSignupApi() async {
    clearOtpFields();
    loader.value = true;
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    var signUpReq = AuthRequestModel.signUpReq(
        contactNo: contactController.text.trim().toLowerCase(),
        countryCode: selectedCountryCode,
        password: passwordController.text,
        deviceName: deviceName,
        deviceType: deviceType,
        deviceToken: await FirebaseMessaging.instance.getToken(),
        roleId: ROLE_USER);
    APIRepository.signUpApiCall(dataBody: signUpReq).then((value) async {
      loginModel = value;
      customLoader.hide();
      storage.write(LOCALKEY_token, loginModel?.accessToken);
      storage.write(LOCALKEY_profile, loginModel);
      loader.value = false;
      Get.put(SignUpController());
      Get.to(VerificationScreen(
        changePswd: false,
        phoneNo:
            selectedCountryCode + contactController.text.trim().toLowerCase(),
      ));
      clearFields();
      snackBar(STRING_OTPis.tr.toString() + ' ${loginModel?.otp}');
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;

      snackBar(error);
    });
  }

  SignUpResponseModel model = SignUpResponseModel();

  hitVerifyOTPApi(bool changePswd) async {
    loader.value = true;
    customLoader.show(Get.overlayContext);
    var valuemodel = await storage.read(LOCALKEY_profile);

    if (valuemodel != null) {
      try {
        model = valuemodel;
      } catch (e) {
        model = SignUpResponseModel.fromJson(valuemodel);
      }
    }

    FocusManager.instance.primaryFocus!.unfocus();
    var signUpReq = AuthRequestModel.verifyOTPReq(
      contactNo: '${model.detail?.contactNo}',
      countryCode: '${model.detail?.countryCode}',
      otp: otpController.text,
      deviceName: 'deviceName',
      deviceType: 1,
      deviceToken: await FirebaseMessaging.instance.getToken(),
    );
    APIRepository.verifyOtpApiCall(dataBody: signUpReq).then((value) async {
      otpVerificationResponseModel = value;
      customLoader.hide();
      clearOtpFields();
      storage.write(LOCALKEY_profile, model);

      loader.value = false;
      var ctrl = Get.put(CompleteProfileController());
      ctrl.hitGetNationalitiesListAPI();
      ctrl.setUserProfile(signingUp: true);
      if (changePswd == true) {
        Get.to(ChangePassword());
      } else {
        var ctrl = Get.put(CompleteProfileController());
        ctrl.setUserProfile();

        Get.to(CompleteProfile(
          title: STRING_CompleteProfilee.tr,
        ));
      }
      snackBar(STRING_OTPVerified.tr);
    }).onError((error, stackTrace) async {
      customLoader.hide();
      loader.value = false;

      var val = error;
      snackBar(val.toString());
    });
  }

  hitResendOTPApi() async {
    clearOtpFields();
    loader.value = true;
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    model = await storage.read(LOCALKEY_profile);
    var signUpReq = AuthRequestModel.verifyOTPReq(
      contactNo: '${model.detail?.contactNo}',
      countryCode: '${model.detail?.countryCode}',
    );

    APIRepository.resendOTPApiCall(dataBody: signUpReq).then((value) async {
      loginModel = value;
      customLoader.hide();

      loader.value = false;
      snackBar('OTP is ${loginModel!.otp}');
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      if (error.toString() == STRING_unexpectedException) {
        snackBar(STRING_IncorrectEmailPassword.tr);
      } else {
        snackBar(error);
      }
    });
  }

  hitForgetAPI(context) {
    customLoader.show(context);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.loginReq(
        email: forgetEmailController.text.trim().toLowerCase());
    APIRepository.forgetApiCall(dataBody: loginReq).then((value) {
      // commonModel = value;
      // customLoader.hide();
      // toast(commonModel?.message, seconds: 1);
      Future.delayed(Duration(seconds: 2), () {
        Get.offAll(() => LoginScreen());
        forgetEmailController.clear();
      });
    }).onError((error, stackTrace) {
      customLoader.hide();
      snackBar(error);
    });
  }

  hitMyAccountAPI() {
    APIRepository.myAccountApiCall().then((value) {
      myAccountModel = value;
      storage.write(LOCALKEY_myAccount, myAccountModel);
    }).onError((error, stackTrace) {
      snackBar(error);
    });
  }

  onLogin() {
    Get.off(() => HomeScreen());
  }

  onSend() {
    Get.offAll(() => LoginScreen());
  }

  onForget() {
    contactController.clear();
    passwordController.clear();
    forgetEmailController.clear();
    Get.focusScope!.unfocus();
    Get.to(() => ForgetScreen());
  }

  onManage() {}

  void gotoSingup() {}

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {}

  clearFields() {
    contactController.clear();
    passwordController.clear();
    update();
  }

  clearOtpFields() {
    otpController.clear();
    update();
  }
}
