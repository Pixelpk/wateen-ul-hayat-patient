import 'package:package_info_plus/package_info_plus.dart';
import 'package:swift_care/model/data_model/categorylist_item_data_modal.dart';
import 'package:swift_care/model/data_model/service_provider_model.dart';
import 'package:swift_care/model/responseModal/login_model.dart';
import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/complete_profile_screen_controller.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/profile_controller.dart';
import 'package:swift_care/pages/authentication/presentation/views/forget_screen.dart';
import 'package:swift_care/pages/cart/cart_db.dart';
import 'package:swift_care/pages/home/presentation/controllers/home_tab_controller.dart';
import 'package:swift_care/pages/home/presentation/views/home_screen.dart';
import 'package:translator/translator.dart';

import '../../../../export.dart';
import '../../../../service/remote_service/entity/request_model/auth_reuest_model.dart';

class BottomNavigationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TextEditingController emailController;
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode loginFocusNode;
  LoginModel? loginModel;
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;
  bool toggleNotification = true;
  List<ServiceProvider> notificationList = [];
  List<BookingModel> bookingList = [];

  final translator = GoogleTranslator();
  int? priceType;
  int? genderType;
  int? ratingType;
  int? serviceType;

  int langVal = 1;
  final dbHelper = DatabaseHelper.instance;

  // HomeController homeController = Get.put(HomeController());
  RxBool loader = false.obs;
  late TabController tabController;

  String appBarTitle = STRING_Home;

  List<CategoryListItem> allServiceIssueList = [];

  late List<DropdownMenuItem<CategoryListItem>> dropdownMenuItemsServiceType;

  CategoryListItem? itemSelectedSubServiceType;
  List<DropdownMenuItem<CategoryListItem>>? dropdownMenuItemsSubServiceType;
  List<CategoryListItem> allSubServiceIssueList = [];

  var allRows;

  var count;

  updateAppBarTitle() {
    if (tabController.index == 0) {
      appBarTitle = STRING_Home.tr;
      var ctrl2 = Get.put(HomeTabController());
      ctrl2.serviceTypeHitApi("");
    } else if (tabController.index == 1) {
      hitGetUserProfileAPI();
      var ctrl2 = Get.put(CompleteProfileController());
      ctrl2.hitGetNationalitiesListAPI();
      var ctrl3 = Get.put(ProfileController());
      ctrl3.setUserProfile();
      appBarTitle = STRING_MyProfile.tr;
    } else if (tabController.index == 2) {
      appBarTitle = STRING_MyBookings.tr;
    } else if (tabController.index == 3) {
    } else if (tabController.index == 4) {
      appBarTitle = STRING_Settings.tr;
    }
    update();
  }

  // updateAppBarTitle() {
  //   if (tabController.index == 0) {
  //     appBarTitle = STRING_Home.tr;
  //     var ctrl2 = Get.put(HomeTabController());
  //     ctrl2.serviceTypeHitApi("");
  //   } else if (tabController.index == 1) {
  //     appBarTitle = STRING_MyBookings.tr;
  //   } else if (tabController.index == 2) {
  //     hitGetUserProfileAPI();
  //     var ctrl2 = Get.put(CompleteProfileController());
  //     ctrl2.hitGetNationalitiesListAPI();
  //     var ctrl3 = Get.put(ProfileController());
  //     ctrl3.setUserProfile();
  //     appBarTitle = STRING_MyProfile.tr;
  //   } else if (tabController.index == 3) {
  //     appBarTitle = STRING_Settings.tr;
  //   }
  //   update();
  // }

  bool viewServiceDialog = false;

  updateViewServiceDialog(value) {
    viewServiceDialog = value;
    update();
  }

  updateBottomIndex(value) {
    tabController.animateTo(value);
    update();
  }

  int tap = 0;
  late DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();

    if (tap == 0) {
      tap++;
      Get.snackbar(STRING_ExitApp.tr, STRING_Tapagain.tr,
          duration: Duration(seconds: 1, milliseconds: 500),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.black,
          dismissDirection: DismissDirection.horizontal);
      update();
      return Future.value(false);
    } else {
      tap = 0;
      update();
      SystemNavigator.pop();
    }

    return Future.value(true);
  }

  getCount() async {
    dbHelper.queryRowCount().then((value) => {count = value});
    update();
  }

  String infoVersion = '';

  @override
  void onInit() {
    getCount();
    getInfoVersion();
    tabController = TabController(length: 5, initialIndex: 0, vsync: this);
    emailController = TextEditingController();
    forgetEmailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    customLoader = CustomLoader();

    if (Get.arguments != null) {
      print("index set to 2");
      tabController.index = Get.arguments['tab'];
      updateAppBarTitle();
      tabController.animateTo(Get.arguments['tab']);
      update();
    }

    if (storage.read(LOCALKEY_notification) == true ||
        storage.read(LOCALKEY_notification) == null) {
      toggleNotification = true;
    } else {
      toggleNotification = false;
    }

    if (storage.read(LOCALKEY_english) == true ||
        storage.read(LOCALKEY_english) == null) {
      langVal = 1;
      update();
    } else {
      langVal = 2;
      update();
    }

    clearFilters();

    super.onInit();
  }

  getInfoVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    infoVersion = info.version;
  }

  @override
  void onClose() {
    customLoader.hide();
    emailController.dispose();
    forgetEmailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    forgetEmailFocusNode.dispose();
    passwordFocusNode.dispose();
    loginFocusNode.dispose();
    super.onClose();
  }

  clearFilters() {
    priceType = null;
    genderType = null;
    ratingType = null;
    serviceType = null;
    update();
  }

  hitLogoutAPI() {
    Loader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.logoutApiCall().then((value) async {
      customLoader.hide();
      storage.remove(LOCALKEY_profile);
      storage.remove(LOCALKEY_token);
      Get.offAll(LoginScreen());
      Get.deleteAll();
      snackBar(STRING_LoggedOutSuccessfully.tr);
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error.toString());
    });
  }

  serviceTypeHitApi(String searchTxt) {
    APIRepository.serviceTypeListAPiCall(search: searchTxt).then((value) {
      allServiceIssueList = value.categories?.list ?? [];
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();

      snackBar(error);
    });
  }

  notificationToggleHitApi(bool? value) {
    var notifyReq = AuthRequestModel.notifyReq(
      lang: value == true ? 0 : 1,
    );
    APIRepository.notificationToggleAPiCall(dataBody: notifyReq).then((value) {
      snackBar(value);
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      snackBar(error);
    });
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
      model = value;
      await storage.write(LOCALKEY_profile, model);
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
    emailController.clear();
    passwordController.clear();
    forgetEmailController.clear();
    Get.focusScope!.unfocus();
    Get.to(() => ForgetScreen());
  }

  setLangHitApi(String? id) {
    Loader.show(Get.context);

    var langReq = AuthRequestModel.langReq(
      lang: id,
    );

    APIRepository.langApiCall(dataBody: langReq).then((value) {
      Loader.hide();
      update();
    }).onError((error, stackTrace) {
      Loader.hide();

      snackBar(error);
    });
  }
}
