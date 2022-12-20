import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:swift_care/components/custom_flashbar.dart';

import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/nationalities_response_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/profile_controller.dart';
import 'package:swift_care/pages/authentication/presentation/views/forget_screen.dart';
import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'package:swift_care/pages/home/presentation/views/bottom_navigation_screen.dart';
import 'package:swift_care/pages/home/presentation/views/home_screen.dart';
import 'package:swift_care/service/remote_service/entity/request_model/auth_reuest_model.dart';

import '../../../../components/image_picker_custom.dart';
import '../../../../export.dart';
import '../../../../model/responseModal/family_response_model.dart';

class CompleteProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController genderController;
  int? genderID;
  late TextEditingController nationalityController;
  late TextEditingController houseNoController;
  late TextEditingController streetController;
  late TextEditingController additionalInfoController;
  late TextEditingController familyNameController;
  late TextEditingController relationshipInfoController;
  late TextEditingController familyMobileController;
  late TextEditingController passwordController;
  LocationPermission? permission;
  late FocusNode nameFocusNode;
  late FocusNode mobileFocusNode;
  late FocusNode genderFocusNode;
  late FocusNode nationalityFocusNode;
  late FocusNode houseNoFocusNode;
  late FocusNode streetFocusNode;
  late FocusNode additionalInfoFocusNode;
  late FocusNode familyNameFocusNode;
  late FocusNode relationshipInfoFocusNode;
  late FocusNode familyMobileFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode loginFocusNode;

  NationalitiesResponseModel? nationalitiesResponseModel =
      NationalitiesResponseModel();
  SignUpResponseModel? loginModel = SignUpResponseModel();
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;

  // HomeController homeController = Get.put(HomeController());
  RxBool loader = false.obs;

  SignUpResponseModel? model;

  bool? isUpdate;

  var userLat;
  var userLang;

  FamilyMembersListResponseModel? familyMembersListResponseModel =
      FamilyMembersListResponseModel();

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    genderController = TextEditingController();
    nationalityController = TextEditingController();
    houseNoController = TextEditingController();
    streetController = TextEditingController();
    additionalInfoController = TextEditingController();
    familyNameController = TextEditingController();
    relationshipInfoController = TextEditingController();
    familyMobileController = TextEditingController();

    passwordController = TextEditingController();

    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    nationalityFocusNode = FocusNode();
    houseNoFocusNode = FocusNode();
    streetFocusNode = FocusNode();
    additionalInfoFocusNode = FocusNode();
    familyNameFocusNode = FocusNode();
    relationshipInfoFocusNode = FocusNode();
    familyMobileFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    customLoader = CustomLoader();
    setUserProfile(signingUp: true);
    super.onInit();
  }

  @override
  void onClose() {
    customLoader.hide();

    hitGetNationalitiesListAPI();

    super.onClose();
  }

  String? selectedCountryCodeRelation = '+966';

  updateSelectedCountryCodeRelation(String value) {
    selectedCountryCodeRelation = value;
    update();
  }

  String? selectedCountryCode = '+966';

  updateSelectedCountryCode(String value) {
    selectedCountryCode = value;
    update();
  }

  SignUpResponseModel logInResponseModel = SignUpResponseModel();

  setUserProfile({bool? signingUp}) async {
    var value = await storage.read(LOCALKEY_profile);

    if (value != null) {
      try {
        logInResponseModel = SignUpResponseModel.fromJson(value);
      } catch (e) {
        logInResponseModel = value;
      }
      networkImage = logInResponseModel.detail!.profileFile ?? '';
      nameController.text = logInResponseModel.detail!.fullName ?? '';
      mobileController.text = logInResponseModel.detail!.contactNo ?? '';
      selectedCountryCode = logInResponseModel.detail!.countryCode ?? '+966';
      if ((logInResponseModel.detail!.fullName ?? '') != '') {
        genderController.text =
            (logInResponseModel.detail!.gender.toString() == '0'
                ? STRING_Male.tr
                : ((logInResponseModel.detail!.gender.toString() == '1'
                    ? STRING_Female.tr
                    : '')));
      }

      emailController.text = (logInResponseModel.detail?.email != null
          ? logInResponseModel.detail?.email.toString().toLowerCase()
          : '')!;

      nationalityController.text =
          logInResponseModel.detail?.userDetail?.nationality ?? '';
      houseNoController.text =
          logInResponseModel.detail?.userAddress?.houseNo ?? '';
      streetController.text =
          logInResponseModel.detail?.userAddress?.street ?? '';
      additionalInfoController.text =
          logInResponseModel.detail?.userAddress?.otherInfo ?? '';
    }
    update();
  }

  updateGender(String value) {
    genderController.text = value;

    switch (value) {
      case 'Male':
        {
          genderID = 0;
          break;
        }
      case 'Female':
        {
          genderID = 1;
          break;
        }
      case 'Other':
        {
          genderID = 2;
          break;
        }
    }

    update();
  }

  updateNationalities(String value) {
    nationalityController.text = value;
    update();
  }

  String profileFile = '';
  String networkImage = '';

  updateProfilePhoto() async {
    openCameraDialog(onGallary: () {
      imagePickFromGallery(cropImageFunction: (croppedImage) {
        profileFile = croppedImage.path;
        update();
      });
    }, onCamera: () {
      imagePickFromCamera(cropImageFunction: (croppedImage) {
        profileFile = croppedImage.path;
        update();
      });
    });
  }

  @override
  void onReady() {
    /* if (storage.read(LOCALKEY_token) != null &&
        storage.read(LOCALKEY_myAccount) == null) {
      hitMyAccountAPI();
    } else {
      if (storage.read(LOCALKEY_myAccount) != null) {
        myAccountModel =
            MyAccountModel.fromJson(storage.read(LOCALKEY_myAccount));
      }
    }
    update();*/
    setUserProfile();
  }

  MultipartFile? multipartFile = null;
  late String image = '';

  hitUpdateProfileAPI() async {
    loader.value = true;
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    if (profileFile != null && profileFile != '') {
      multipartFile = await MultipartFile.fromFile(new File(profileFile).path,
          filename: new File(profileFile).path);
    }

    var profileReq = AuthRequestModel.updateProfileReq(
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        countryCode: selectedCountryCode,
        contactNo: mobileController.text.trim(),
        gender: genderID,
        nationality: nationalityController.text,
        houseNo: houseNoController.text.trim(),
        street: streetController.text.trim(),
        otherInfo: additionalInfoController.text.trim(),
        profileFile: multipartFile,
        latitude: userLat.toString(),
        longitude: userLang.toString());

    debugPrint(profileReq.toString());

    APIRepository.profileUpdateApiCall(dataBody: profileReq)
        .then((value) async {
      loginModel = value;
      customLoader.hide();
      // await storage.write(LOCALKEY_profile, loginModel);
      loader.value = false;

      var ctrl2 = Get.put(ProfileController());
      ctrl2.setUserProfile();
      var ctrl = Get.put(BottomNavigationController());

      if (isUpdate == true) {
        snackBar(STRING_ProfileUpdatedSuccessfully.tr);
        ctrl.updateBottomIndex(2);
        ctrl.updateAppBarTitle();
        Get.to(BottomNavigationScreen());
      } else {
        snackBar(STRING_SignupSuccessfully.tr);
        ctrl.updateBottomIndex(0);
        ctrl.updateAppBarTitle();
        Get.to(BottomNavigationScreen());
      }
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      if (error.toString() == STRING_unexpectedException) {
      } else {
        snackBar(error);
      }
    });
  }

  hitAddFamilyMemberApi() {
    loader.value = true;
    // customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    var signUpReq = AuthRequestModel.addFamilyMemberReq(
      name: familyNameController.text,
      relation: relationshipInfoController.text,
      contactNo: familyMobileController.text.trim(),
      countryCode: selectedCountryCodeRelation,
    );
    APIRepository.addFamilyMemberApiCall(dataBody: signUpReq)
        .then((value) async {
      loginModel = value;
      customLoader.hide();
      var ctrl = Get.put(ProfileController());
      ctrl.hitGetFamilyMembersListAPI();
      loader.value = false;
      snackBar(STRING_FAMILY_ADDED.tr);
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
      customLoader.hide();

      loader.value = false;
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      snackBar(error);
    });
  }

  hitGetNationalitiesListAPI() async {
    loader.value = true;
    // customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.nationalitiesListApiCall().then((value) async {
      nationalitiesResponseModel = value;
      customLoader.hide();

      loader.value = false;
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
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
    // emailController.clear();
    passwordController.clear();
    // forgetEmailController.clear();
    Get.focusScope!.unfocus();
    Get.to(() => ForgetScreen());
  }

  void showPlacePicker() async {
    permission = await Geolocator.requestPermission();

    LocationResult result = await Get.to(PlacePicker(
      google_map_key,
    ));

    userLat = result.latLng?.latitude;
    userLang = result.latLng?.longitude;
    houseNoController.text = result.name ?? '';
    streetController.text = result.subLocalityLevel1?.name ?? '';
    additionalInfoController.text = result.locality ?? '';

    update();
  }
}
