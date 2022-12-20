import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/views/completer_profile_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/forget_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/verification_screen.dart';
import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'package:swift_care/pages/home/presentation/views/bottom_navigation_screen.dart';
import 'package:swift_care/pages/home/presentation/views/home_screen.dart';
import 'package:swift_care/service/remote_service/entity/request_model/auth_reuest_model.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../../../export.dart';
import 'complete_profile_screen_controller.dart';

class LoginController extends SuperController {
  late TextEditingController mobileController;
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  late FocusNode mobileFocusNode;
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode newPasswordFocusNode;
  late FocusNode confirmPasswordFocusNode;
  late FocusNode loginFocusNode;
  SignUpResponseModel? loginModel = SignUpResponseModel();
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;

  String? dropValue = 'English';

  // HomeController homeController = Get.put(HomeController());
  RxBool loader = false.obs;

  late int deviceType;
  late String deviceName;
  late String deviceToken;

  String selectedCountryCode = '+966';

  bool hidePswd = true;

  updateHidePswd() {
    hidePswd = !hidePswd;
    update();
  }

  bool rememberMe = false;

  updateRememberMe() {
    rememberMe = !rememberMe;
    update();
  }

  bool hideNewPswd = true;

  updateHideNewPswd() {
    hideNewPswd = !hideNewPswd;
    update();
  }

  bool hideConfirmPswd = true;

  updateHideConfirmPswd() {
    hideConfirmPswd = !hideConfirmPswd;
    update();
  }

  updateSelectedCountryCode(String value) {
    selectedCountryCode = value;
    update();
  }

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
    mobileController = TextEditingController();
    forgetEmailController = TextEditingController();
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    mobileFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    newPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    customLoader = CustomLoader();
    setRemmeber();
    deviceDetails();
    getLanguageData();
    super.onInit();
  }

  getLanguageData() {
    if (storage.read(LOCALKEY_english) == null ||
        storage.read(LOCALKEY_english) == true) {
      dropValue = 'English';
    } else {
      dropValue = STRING_arabic.tr;
    }
    update();
  }

  @override
  void onClose() {
    customLoader.hide();
    // mobileController.dispose();
    // forgetEmailController.dispose();
    // passwordController.dispose();
    // newPasswordController.dispose();
    // confirmPasswordController.dispose();
    // mobileFocusNode.dispose();
    // forgetEmailFocusNode.dispose();
    // passwordFocusNode.dispose();
    // newPasswordFocusNode.dispose();
    // confirmPasswordFocusNode.dispose();
    // loginFocusNode.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    setRemmeber();

    update();
  }

  setRemmeber() async {
    var value = await storage.read(LOCALKEY_remember);
    if (value != null) {
      UserRememberData userRememberData = UserRememberData();
      userRememberData = UserRememberData.fromJson(value);
      selectedCountryCode = userRememberData.countryCode!;
      mobileController.text = userRememberData.contactNo!;
      passwordController.text = userRememberData.password!;
    }

    update();
  }

  hitLoginAPI() async {
    loader.value = true;
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();

    var loginReq = AuthRequestModel.loginReq(
      lang: dropValue,
      contactNo: mobileController.text.trim(),
      countryCode: selectedCountryCode,
      password: passwordController.text.trim(),
      deviceName: deviceName,
      deviceType: deviceType,
      deviceToken: await FirebaseMessaging.instance.getToken(),
    );
    APIRepository.loginApiCall(dataBody: loginReq).then((value) async {
      loginModel = value;
      customLoader.hide();
      if (rememberMe == true) {
        var val = UserRememberData(
            countryCode: selectedCountryCode,
            contactNo: mobileController.text,
            password: passwordController.text);
        await storage.write(LOCALKEY_remember, val);
      } else {
        try {
          await storage.remove(LOCALKEY_remember);
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      if (loginModel?.detail?.roleId == ROLE_USER) {
        clearFields();

        await storage.write(LOCALKEY_token, loginModel?.accessToken);
        await storage.write(LOCALKEY_profile, loginModel);

        var ctrl = Get.put(BottomNavigationController());
        if (loginModel?.detail?.otpVerified == 1) {
          if (loginModel?.detail?.fullName == null) {
            var ctrl = Get.put(CompleteProfileController());
            ctrl.hitGetNationalitiesListAPI();
            ctrl.setUserProfile();

            Get.to(CompleteProfile(
              title: STRING_CompleteProfilee.tr,
            ));
            snackBar(STRING_CompleteProfile.tr);
          } else {
            ctrl.updateBottomIndex(0);
            Get.to(BottomNavigationScreen());
            snackBar(STRING_LoginSuccess.tr);
          }
        } else {
          Get.to(VerificationScreen(changePswd: false));
          snackBar(loginModel?.detail?.otp ?? "");
        }
      } else {
        snackBar(STRING_notUser.tr);
      }

      loader.value = false;
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      snackBar(error);
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
    mobileController.clear();
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
    mobileController.clear();
    passwordController.clear();
    update();
  }
}

class UserRememberData {
  String? countryCode = '', contactNo = '', password = '';

  UserRememberData({this.countryCode, this.contactNo, this.password});

  UserRememberData.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    contactNo = json['contactNo'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['countryCode'] = this.countryCode;
    data['contactNo'] = this.contactNo;
    data['password'] = this.password;
    return data;
  }
}
