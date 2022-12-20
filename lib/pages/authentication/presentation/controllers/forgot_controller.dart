import 'package:swift_care/components/custom_flashbar.dart';
import 'package:swift_care/model/responseModal/login_model.dart';
import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/views/forget_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/verification_screen.dart';
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

  hitForgetAPI() {
    Loader.show(Get.context);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.forgetReq(
        countryCode: selectedCountryCode,
        contactNo: mobileController.text.trim().toLowerCase());
    APIRepository.forgetApiCall(dataBody: loginReq).then((value) {
      Loader.hide();
      Get.back();

    }).onError((error, stackTrace) {
      Loader.hide();
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
