import 'package:swift_care/components/custom_flashbar.dart';
import 'package:swift_care/model/responseModal/login_model.dart';
import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/views/change_password.dart';
import 'package:swift_care/pages/authentication/presentation/views/forget_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/set_new_pass_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/verification_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/verifyOtpScreen.dart';
import 'package:swift_care/pages/home/presentation/views/home_screen.dart';
import 'package:swift_care/service/remote_service/entity/request_model/auth_reuest_model.dart';

import '../../../../export.dart';

class ForgotController extends GetxController {
  late TextEditingController mobileController;
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late FocusNode mobileFocusNode;
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode loginFocusNode;
  LoginModel? loginModel;
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;
  RxBool loader = false.obs;

  @override
  void onInit() {
    mobileController = TextEditingController();
    forgetEmailController = TextEditingController();
    passwordController = TextEditingController();
    mobileFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    customLoader = CustomLoader();

    super.onInit();
  }

  @override
  void onClose() {
    customLoader.hide();
    mobileController.dispose();
    forgetEmailController.dispose();
    passwordController.dispose();
    mobileFocusNode.dispose();
    forgetEmailFocusNode.dispose();
    passwordFocusNode.dispose();
    loginFocusNode.dispose();
    super.onClose();
  }

  @override
  void onReady() {}

  SignUpResponseModel? commonModel = SignUpResponseModel();

  String selectedCountryCode = '+966';

  updateSelectedCountryCode(String value) {
    selectedCountryCode = value;
    update();
  }

  int otpCode = 1234;

  hitForgetAPI() {
    Loader.show(Get.context);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.forgetReq(
        countryCode: selectedCountryCode,
        contactNo: mobileController.text.trim().toLowerCase());
    APIRepository.forgetApiCall(dataBody: loginReq).then((value) {
      print('This is res :::: $value');
      Loader.hide();
      if(value != 'User not exists with this number.') {
        otpCode = value;
        snackBar("${STRING_OTPis.tr.toString()} $value");
        Get.to(VerifyOtpScreen(phoneNo: mobileController.text,));
        // Get.to(VerificationScreen(changePswd: true));
      }
      else
        snackBar(value);
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error);
    });
  }

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  hitUpdatePasswordAPI({required String otp, required String password, required BuildContext context}) {
    Loader.show(Get.context);
    FocusManager.instance.primaryFocus!.unfocus();
    debugPrint(selectedCountryCode);
    debugPrint(mobileController.text);
    debugPrint(otpCode.toString());
    debugPrint(password);
    var updateReq = AuthRequestModel.updatePassReq(
        countryCode: selectedCountryCode,
        contactNo: mobileController.text.trim().toLowerCase(),
        otp: otp,
        password: password,
    );
    APIRepository.updatePasswordApiCall(dataBody: updateReq).then((value) {
      print('This is res :::: $value');
      Loader.hide();
      snackBar(value);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
    }).onError((error, stackTrace) {
      Loader.hide();
      if(error == 'User not found.'){
        snackBar('Otp is not correct');
      }else
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
}
