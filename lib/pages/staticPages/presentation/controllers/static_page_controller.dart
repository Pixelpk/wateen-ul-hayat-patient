import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:swift_care/components/custom_flashbar.dart';
import 'package:swift_care/model/data_model/card_details.dart';
import 'package:swift_care/model/responseModal/faq_response_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/profile_controller.dart';
import 'package:swift_care/service/remote_service/entity/request_model/auth_reuest_model.dart';

import '../../../../components/custom_loader.dart';
import '../../../../components/time_ago.dart';
import '../../../../export.dart';
import '../../../../model/responseModal/family_response_model.dart';
import '../../../../model/responseModal/notification_data_model.dart';

class StaticPageController extends GetxController {
  RxBool isLoading = false.obs;
  late TextEditingController nameController;
  late TextEditingController relationController;
  late TextEditingController emailController;
  late TextEditingController subjectController;
  late TextEditingController messageController;
  late TextEditingController mobileController;

  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  late FocusNode oldPasswordFocusNode;
  late FocusNode newPasswordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  late FocusNode nameFocusNode;
  late FocusNode relationFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode subjectFocusNode;
  late FocusNode messageFocusNode;
  late FocusNode mobileFocusNode;

  late TextEditingController houseNoController;
  late TextEditingController streetController;
  late TextEditingController additionalInfoController;

  late FocusNode houseNoFocusNode;
  late FocusNode streetFocusNode;
  late FocusNode additionalInfoFocusNode;

  List<NotificationData> notificationList = [];
  NotificationDataModel notificationModel = NotificationDataModel();

  FaqResponseModel? faqResponseModel;
  CardDetailsModel? cardResponseModel;
  FamilyMember? familyMember;
  List<FaqList>? faqList;
  var desc;
  LocationPermission? permission;
  ScrollController? scrollController;
  int _currentPage = 0;
  bool isLoadingg = false;

  var familyLat;
  var familyLang;

  StaticPageController({this.familyMember});
  @override

  void onInit() {
    // if (Get.arguments != null) {
    //   familyMember = Get.arguments;
    // }

    newPasswordController = TextEditingController();
    oldPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    newPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();

    nameController = TextEditingController(text: familyMember?.name ?? "");
    relationController =
        TextEditingController(text: familyMember?.relation ?? "");
    emailController = TextEditingController();
    subjectController = TextEditingController();
    messageController = TextEditingController();

    mobileController =
        TextEditingController(text: familyMember?.contactNo ?? "");

    nameFocusNode = FocusNode();
    oldPasswordFocusNode = FocusNode();
    relationFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    subjectFocusNode = FocusNode();
    messageFocusNode = FocusNode();
    mobileFocusNode = FocusNode();

    houseNoFocusNode = FocusNode();
    streetFocusNode = FocusNode();
    additionalInfoFocusNode = FocusNode();

    houseNoController = TextEditingController(text: familyMember?.city ?? "");
    streetController = TextEditingController(text: familyMember?.country ?? "");
    additionalInfoController =
        TextEditingController(text: familyMember?.address ?? "");

    if (storage.read(LOCALKEY_token) != null) {
      faqListHitApi();
      notificationListHitApi();
    } else {
      hitStaticPageAPI(1);
    }

    super.onInit();
  }

  String timeAgo(testIndex) {
    var time = TimeAgo.timeAgoSinceDate(testIndex);
    return time;
  }

  convertTimeToLocal({dateString}) {
    if (dateString != null && dateString != "") {
      var strToDateTime = DateTime.parse(dateString.toString() + 'Z');
      final convertLocal = strToDateTime.toLocal();
      DateFormat newFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      return newFormat.add_jm().format(convertLocal);
    }
  }

  bool hideNewPswd = true;
  bool hideOldPswd = true;

  updateHideNewPswd() {
    hideNewPswd = !hideNewPswd;
    update();
  }

  updateHideOldPswd() {
    hideOldPswd = !hideOldPswd;
    update();
  }

  bool hideConfirmPswd = true;

  updateHideConfirmPswd() {
    hideConfirmPswd = !hideConfirmPswd;
    update();
  }

  hitChangePasswordAPI() {
    loader.value = true;
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();

    var loginReq = AuthRequestModel.changePasswordReq(
      oldPassword: oldPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );
    APIRepository.changePasswordApiCall(dataBody: loginReq).then((value) async {
      customLoader.hide();
      clearFields();
      confirmPasswordController.clear();
      oldPasswordController.clear();
      newPasswordController.clear();

      await storage.erase();
      Get.offAll(LoginScreen());

      loader.value = false;
      snackBar(STRING_PassChange.tr);
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      snackBar(error.toString());
    });
  }

  clearFields() {
    nameController.clear();
    messageController.clear();
    emailController.clear();
    mobileController.clear();
    subjectController.clear();
  }

  notificationListHitApi() {
    Loader.show(Get.context);
    APIRepository.notificationListAPiCall().then((value) {
      Loader.hide();
      notificationModel = value;
      notificationList = notificationModel.list ?? [];
      paginatedData();
      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error.toString());
    });
  }

  void paginatedData() {
    scrollController?.addListener(() {
      if (scrollController?.position.pixels ==
          scrollController?.position.maxScrollExtent) {
        if (isLoadingg == false) {
          _currentPage++;
          if (_currentPage < notificationModel.mMeta!.pageCount!) {
            isLoadingg = true;
            Timer.periodic(Duration(milliseconds: 500), (timer) async {
              timer.cancel();
              await APIRepository.notificationListAPiCall().then((value) {
                notificationModel = value;
                notificationList = notificationModel.list ?? [];
                update();
              }).onError((error, stackTrace) {
                snackBar(error);
              });
            });
            update();
          } else {
            isLoadingg = false;
            update();
          }
        }
      }
    });
  }

  faqListHitApi() {
    APIRepository.faqListAPiCall().then((value) {
      faqResponseModel = value;
      faqList = faqResponseModel?.list ?? [];
      update();
      isLoading.value = false;
    }).onError((error, stackTrace) {
      customLoader.hide();
      isLoading.value = false;
      snackBar(error);
    });
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    relationController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    mobileController.dispose();
    nameFocusNode.dispose();
    relationFocusNode.dispose();
    emailFocusNode.dispose();
    subjectFocusNode.dispose();
    messageFocusNode.dispose();
    mobileFocusNode.dispose();
  }

  RxBool loader = false.obs;
  CustomLoader customLoader = CustomLoader();

  hitStaticPageAPI(int type) async {
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.staticPagesApiCall(type).then((value) async {
      desc = value.detail?.title;
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      snackBar(error);
    });
  }

  hitContactUsApi() {
    Loader.show(Get.context);
    FocusManager.instance.primaryFocus!.unfocus();
    var contactUsReq = AuthRequestModel.contactUsReq(
        fullName: nameController.text,
        description: messageController.text,
        email: emailController.text,
        mobile: mobileController.text,
        subject: subjectController.text);
    APIRepository.contactUsApiCall(dataBody: contactUsReq).then((value) async {
      if (value != null) {
        Loader.hide();
        Get.back();
        snackBar(value.message);
        clearFields();
        update();
      }
    }).onError((error, stackTrace) {
      Loader.hide();
      if (error.toString() == STRING_unexpectedException) {
      } else {
        snackBar(error);
      }
    });
  }

  SignUpResponseModel loginModel = SignUpResponseModel();

  String? selectedCountryCode = '+966';

  updateSelectedCountryCode(String value) {
    selectedCountryCode = value;
    update();
  }

  hitAddFamilyMemberApi({int? id}) {
    loader.value = true;
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    var signUpReq = AuthRequestModel.addFamilyMemberReq(
      name: nameController.text,
      relation: relationController.text,
      contactNo: mobileController.text.trim(),
      countryCode: selectedCountryCode,
      zipcode: "0",
      state: "",
      longitude: familyLang.toString(),
      latitude: familyLat.toString(),
      country: additionalInfoController.text.trim(),
      city: houseNoController.text.trim(),
      address: streetController.text.trim(),
    );
    APIRepository.addFamilyMemberApiCall(dataBody: signUpReq, id: id)
        .then((value) async {
      loginModel = value;
      customLoader.hide();
      nameController.clear();
      mobileController.clear();
      relationController.clear();
      Get.back(result: 1);
      var ctrl = Get.put(ProfileController());
      ctrl.hitGetFamilyMembersListAPI();
      loader.value = false;
      if (id != 0) {
        snackBar('$STRING_FAMILY_UPDATED'.tr);
      } else {
        snackBar('$STRING_FAMILY_ADDED'.tr);
      }
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      if (error.toString() != STRING_unexpectedException) {
        snackBar(error);
      } else {
        snackBar(error);
      }
    });
  }

  hitGetFamilyMembersListAPI() async {
    loader.value = true;
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.getFamilyMembersListApiCall().then((value) async {
      customLoader.hide();

      loader.value = false;
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      snackBar(error);
    });
  }

  void showPlacePicker() async {
    permission = await Geolocator.requestPermission();

    LocationResult result = await Get.to(PlacePicker(
      google_map_key,
    ));

    familyLat = result.latLng?.latitude;
    familyLang = result.latLng?.longitude;
    houseNoController.text = result.name ?? '';
    streetController.text = result.subLocalityLevel1?.name ?? '';
    additionalInfoController.text = result.locality ?? '';

    update();
  }
}
