import 'package:swift_care/components/custom_flashbar.dart';
import 'package:swift_care/model/responseModal/family_response_model.dart';
import 'package:swift_care/model/responseModal/login_model.dart';
import 'package:swift_care/model/responseModal/login_response_model.dart';
import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/views/forget_screen.dart';
import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'package:swift_care/pages/home/presentation/views/bottom_navigation_screen.dart';
import 'package:swift_care/pages/home/presentation/views/home_screen.dart';
import 'package:swift_care/service/remote_service/entity/request_model/auth_reuest_model.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../../../export.dart';
import 'complete_profile_screen_controller.dart';

class ProfileController extends GetxController {
  late TextEditingController mobileController;
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late FocusNode mobileFocusNode;
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode loginFocusNode;
  SignUpResponseModel? loginModel = SignUpResponseModel();
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;

  // HomeController homeController = Get.put(HomeController());
  RxBool loader = false.obs;

  late int deviceType;
  late String deviceName, deviceToken;

  String selectedCountryCode = '+966';

  bool hidePswd = true;

  updateHidePswd() {
    hidePswd = !hidePswd;
    update();
  }

  updateSelectedCountryCode(String value) {
    selectedCountryCode = value;
    update();
  }

  setUserProfile() async {
    var value = await storage.read(LOCALKEY_profile);

    if (value != null) {
      loginModel = value;

      hitGetUserProfileAPI();
    }
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
    mobileFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    customLoader = CustomLoader();
    setUserProfile();
    deviceDetails();
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
  void onReady() {
    setUserProfile();
    hitGetFamilyMembersListAPI();
    hitGetUserProfileAPI();
  }

  SignUpResponseModel? model = SignUpResponseModel();

  hitGetUserProfileAPI() async {
    loader.value = true;

    var value = await storage.read(LOCALKEY_profile);
    try {
      model = SignUpResponseModel.fromJson(value);
    } catch (e) {
      model = value;
    }
    APIRepository.getUserProfileApiCall(model?.detail?.id ?? 0)
        .then((value) async {
      loginModel = value;
      await storage.write(LOCALKEY_profile, loginModel);
      customLoader.hide();

      loader.value = false;
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      snackBar(error);
    });
  }

  FamilyMembersListResponseModel? familyMembersListResponseModel =
      FamilyMembersListResponseModel();

  hitGetFamilyMembersListAPI() async {
    loader.value = true;
    // customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.getFamilyMembersListApiCall().then((value) async {
      if (value != null) {
        familyMembersListResponseModel = value;
      }
      customLoader.hide();

      loader.value = false;
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      snackBar(error);
    });
  }

  hitDeleteFamilyMembersAPI(id) async {
    loader.value = true;
    // customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.getDeleteMemberApiCall(id).then((value) async {
      snackBar(value);
      customLoader.hide();

      hitGetFamilyMembersListAPI();
      loader.value = false;
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      snackBar(error);
    });
  }
}
