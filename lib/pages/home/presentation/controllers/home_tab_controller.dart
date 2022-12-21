import 'package:swift_care/components/custom_flashbar.dart';
import 'package:swift_care/export.dart';
import 'package:swift_care/model/data_model/categorylist_item_data_modal.dart';
import 'package:swift_care/model/data_model/service_provider_model.dart';
import 'package:swift_care/model/responseModal/booking_list_model.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';

import '../../../../export.dart';
import '../../../../model/responseModal/categorylist_response_modal.dart';
import '../../../../model/responseModal/subcategory_response_model.dart';

class HomeTabController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode searchFocusNode;
  late FocusNode loginFocusNode;
  int index1 = 0;
  late CustomLoader customLoader;
  bool toggleNotification = false;
  List<ServiceProvider> notificationList = [];
  List<BookingModel> bookingList = [];
  List<ServiceProvider> providerList = [];

  ScrollController? scrollController;
  ScrollController? subServiceScrollController;
  int _currentPage = 0;
  bool isLoading = false;
  var description;

  int _currentSubPage = 0;
  bool isSubLoading = false;

  // HomeController homeController = Get.put(HomeController());
  RxBool loader = false.obs;
  late TabController tabController;

  List<CategoryListItem> allServiceIssueList = [];
  List<TopRatedSubCatgories> topRatedSubCategories = [];

  CategoryListResponseModal serviceModel = CategoryListResponseModal();
  SubCategoryListResponseModal subServiceModel = SubCategoryListResponseModal();

  late List<DropdownMenuItem<CategoryListItem>> dropdownMenuItemsServiceType;

  CategoryListItem? itemSelectedSubServiceType;
  List<DropdownMenuItem<CategoryListItem>>? dropdownMenuItemsSubServiceType;
  List<CategoryListItem> allSubServiceIssueList = [];

  bool viewServiceDialog = false;

  updateViewServiceDialog(value) {
    viewServiceDialog = value;
    update();
  }

  bool viewCurrentBooking = false;

  updateViewCurrentBooking(value) {
    viewCurrentBooking = value;
    update();
  }

  updateBottomIndex(value) {
    tabController.animateTo(value);
    update();
  }

  providerListHitApi(int? catId, int? catSubId) {
    APIRepository.providerListAPiCall(
            subCategoryId: catSubId, categoryId: catId)
        .then((value) {
      providerList = value.list ?? [];

      update();
    }).onError((error, stackTrace) {
      Loader.hide();

      snackBar(error);
    });
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

  @override
  void onInit() {
    scrollController = ScrollController();
    subServiceScrollController = ScrollController();
    emailController = TextEditingController();
    forgetEmailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    searchFocusNode = FocusNode();
    customLoader = CustomLoader();

    serviceTypeHitApi("");

    if (viewCurrentBooking = false) {
      // bookingListHitApi(0);
    } else {
      // bookingListHitApi(1);
    }

    if (storage.read(LOCALKEY_notification) == true) {
      toggleNotification = true;
    } else {
      toggleNotification = false;
    }

    super.onInit();
  }

  serviceTypeHitApi(String searchTxt) {
    _currentPage = 0;
    APIRepository.serviceTypeListAPiCall(search: searchTxt, page: _currentPage)
        .then((value) {
      if (value != null) {
        serviceModel = value;
        allServiceIssueList = serviceModel.categories?.list ?? [];
        topRatedSubCategories = serviceModel.topRatedSubCatgories ?? [];
        for (int i = 0; i < topRatedSubCategories.length; i++) {
          CategoryListItem? parentCat = allServiceIssueList.firstWhereOrNull((element) {
            return element.id == topRatedSubCategories[i].categoryId;
          });
          if (parentCat != null) {
            topRatedSubCategories[i].image = parentCat.imageFile!;
          }
        }
        update();
      }
      paginatedData('');
    }).onError((error, stackTrace) {
      snackBar(error);
    });
  }

  void paginatedData(String searchTxt) {
    scrollController?.addListener(() {
      if (scrollController?.position.pixels ==
          scrollController?.position.maxScrollExtent) {
        if (isLoading == false) {
          _currentPage++;
          if (_currentPage < serviceModel.categories!.mMeta!.pageCount!) {
            isLoading = true;

            Timer.periodic(Duration(milliseconds: 500), (timer) async {
              timer.cancel();
              await APIRepository.serviceTypeListAPiCall(
                      search: searchTxt, page: _currentPage)
                  .then((value) {
                if (value != null) {
                  serviceModel = value;
                  allServiceIssueList
                      .addAll(serviceModel.categories?.list ?? []);
                  isLoading = false;
                  update();
                }
              }).onError((error, stackTrace) {
                snackBar(error);
              });
            });
            update();
          } else {
            isLoading = false;
            update();
          }
        }
      }
    });
  }

  void paginatedSubServiceData(int id) {
    subServiceScrollController?.addListener(() {
      if (subServiceScrollController?.position.pixels ==
          subServiceScrollController?.position.maxScrollExtent) {
        if (isSubLoading == false) {
          _currentSubPage++;
          if (_currentSubPage < serviceModel.categories!.mMeta!.pageCount!) {
            isSubLoading = true;

            Timer.periodic(Duration(milliseconds: 500), (timer) async {
              Loader.show(Get.context);
              timer.cancel();
              await APIRepository.SubserviceTypeListAPiCall(
                      categoryId: id, page: _currentSubPage)
                  .then((value) {
                if (value != null) {
                  subServiceModel = value;

                  allSubServiceIssueList.addAll(subServiceModel.list ?? []);
                  Loader.hide();
                  isSubLoading = false;
                  update();
                }
              }).onError((error, stackTrace) {
                Loader.hide();
                snackBar(error);
              });
            });
            update();
          } else {
            isSubLoading = false;
            update();
          }
        }
      }
    });
  }

  @override
  void onClose() {
    Loader.hide();
    emailController.dispose();
    forgetEmailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    forgetEmailFocusNode.dispose();
    passwordFocusNode.dispose();
    loginFocusNode.dispose();
    super.onClose();
  }

  serviceSubTypeHitApi(int id) {
    Loader.show(Get.context);
    allSubServiceIssueList = [];
    APIRepository.SubserviceTypeListAPiCall(categoryId: id, page: 0)
        .then((value) {
      subServiceModel = value;
      value.list?.forEach((element) {print('subServiceModel ${element.title}');});
      allSubServiceIssueList = subServiceModel.list ?? [];
      paginatedSubServiceData(id);
      Loader.hide();
      update();
    }).onError((error, stackTrace) {
      Loader.hide();

      snackBar(error);
    });
  }

  SignUpResponseModel? model = SignUpResponseModel();
}
