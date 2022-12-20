import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:swift_care/model/data_model/service_provider_detail_model.dart';
import 'package:swift_care/model/data_model/service_provider_model.dart';
import 'package:swift_care/model/responseModal/login_model.dart';
import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/model/responseModal/slot_data_model.dart';
import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'package:swift_care/pages/home/presentation/views/bottom_navigation_screen.dart';
import 'package:swift_care/service/remote_service/entity/request_model/auth_reuest_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../export.dart';
import '../../../../model/data_model/category_data_model.dart';
import '../../../../service/remote_service/network/endpoint.dart';
import '../../../../utils/projectutils/AlertDialogs.dart';
import '../../../cart/cart_db.dart';
import '../../../service_providers/presentation/views/filter_screen.dart';
import '../../../service_providers/presentation/views/service_providers_screen.dart';
import '../../binding/binding.dart';

class BookServiceProviderController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController forgetEmailController;
  late TextEditingController passwordController;
  late TextEditingController commentController;
  late FocusNode emailFocusNode;
  late FocusNode forgetEmailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode loginFocusNode;
  LoginModel? loginModel;
  MyAccountModel? myAccountModel;
  late CustomLoader customLoader;

  String? newDbEndDate;

  ScrollController? providerScrollController;
  int _currentPage = 0;
  bool isLoading = false;

  ScrollController? serviceScrollController;
  int _currenServicetPage = 0;
  bool isServiceLoading = false;

  int providerId = 0;
  double rating = 0;
  int? nameId;
  String? dayName;
  bool? isSlotVisible;

  String selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  RxBool loader = false.obs;
  late TabController tabController;
  List<ServiceProvider> providerList = [];
  ServiceProviderModel providerModel = ServiceProviderModel();
  List<CategoryData> serviceList = [];
  CategoryDataModel serviceModel = CategoryDataModel();
  List<SlotDataModel> availabilityList = [];

  String appBarTitle = 'Home';

  String? genderTitle;

  int? subId;
  LocationPermission? permission;

  Position? position;
  final dbHelper = DatabaseHelper.instance;
  var count;

  getCount() async {
    dbHelper.queryRowCount().then((value) => {
      count = value
    });
    update();
  }

  updateGender(int? val) {
    switch (val) {
      case 0:
        {
          return STRING_Male.tr;
        }
      case 1:
        {
          return STRING_Female.tr;
        }
      case 2:
        {
          return STRING_Other.tr;
        }
    }
    update();
  }

  updateProviderId(int id) {
    providerId = id;
    print(providerId);
    update();
  }

  timeFormat(date) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("hh:mm aaa").format(tempEndDate.toLocal());
      return endDate;
    }
    return STRING_Reset;
  }

  dateFormat(date) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("yyyy-MM-dd").format(tempEndDate.toLocal());
      return endDate;
    }
    return STRING_StartDate.tr;
  }

  updateAppBarTitle() {
    if (tabController.index == 0) {
      appBarTitle = STRING_Home.tr;
    } else if (tabController.index == 1) {
      appBarTitle = STRING_MyBookings.tr;
    } else if (tabController.index == 2) {
      appBarTitle = STRING_MyProfile.tr;
    } else if (tabController.index == 3) {
      appBarTitle = STRING_Settings.tr;
    }
    update();
  }

  int currentTabIndex = 0;

  updateCurrentTabIndex(value) {
    currentTabIndex = value;
    update();
  }

  @override
  void onInit() {
    getCount();
    providerScrollController = ScrollController();
    serviceScrollController = ScrollController();
    emailController = TextEditingController();
    commentController = TextEditingController();
    forgetEmailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    forgetEmailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    loginFocusNode = FocusNode();
    customLoader = CustomLoader();

    // if (Get.arguments != null) providerId = Get.arguments;

    if (Get.arguments != null) {
      subId = Get.arguments['subId'];
      storage.write('subId', subId);
    }

    // getLocation();

    super.onInit();
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

  datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        selectableDayPredicate: (DateTime val) {
          return val.weekday == 4 || val.weekday == 6 ? false : true;
        },
        lastDate: DateTime(2101));
    if (picked != null) {}
  }

  getDayId(String dayId) {
    switch (dayId) {
      case 'Sunday':
        nameId = 0;
        return 0;
      case 'Monday':
        nameId = 1;
        return 1;
      case 'Tuesday':
        nameId = 2;
        return 2;
      case 'Wednesday':
        nameId = 3;
        return 3;
      case 'Thursday':
        nameId = 4;
        return 4;
      case 'Friday':
        nameId = 5;
        return 5;
      case 'Saturday':
        nameId = 6;
        return 6;
      default:
        nameId = -1;
        return -1;
    }
  }

  getDayName(int dayId) {
    switch (dayId) {
      case DAY_SUNDAY:
        {
          dayName = STRING_Sunday.tr;
        }
        break;
      case DAY_MONDAY:
        {
          dayName = STRING_Monday.tr;
        }
        break;
      case DAY_TUESDAY:
        {
          dayName = STRING_Tuesday.tr;
        }
        break;
      case DAY_WEDNESDAY:
        {
          dayName = STRING_Wednesday.tr;
        }
        break;
      case DAY_THURSDAY:
        {
          dayName = STRING_Thursday.tr;
        }
        break;
      case DAY_FRIDAY:
        {
          dayName = STRING_Friday.tr;
        }
        break;
      case DAY_SATURDAY:
        {
          dayName = STRING_Saturday.tr;
        }
        break;
      default:
        {
          dayName = "";
        }
    }
  }

  hitGetSlotApiApi(
      int id, String selectedDate, String endDate, int? nameId, int? subId) {
    Loader.show(Get.context);
    var slotReq = AuthRequestModel.getSlotReq(
        endDay: nameId.toString(),
        endTime: endDate,
        startDay: nameId.toString(),
        startTime: selectedDate);
    APIRepository.getSlotApiCall(dataBody: slotReq, id: id, subId: subId ?? 0)
        .then((value) async {
      Loader.hide();
      availabilityList = value.list ?? [];
      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      if (error.toString() != STRING_unexpectedException) {
        snackBar(error);
      }
    });
  }

  hitGiveRatingApi(int id, int? providerId, staffId, typeId) {
    Loader.show(Get.context);
    var slotReq = AuthRequestModel.giveRatingReq(
        typeId: id.toString(),
        providerId: providerId.toString(),
        comment: commentController.text.trim(),
        rating: rating.toString(),
        staffId: staffId.toString(),
        bookingId: typeId.toString());
    APIRepository.giveRatingApiCall(id: id, dataBody: slotReq)
        .then((value) async {
      Loader.hide();
      commentController.clear();
      rating = 0;

      var navCtrl = Get.put(BottomNavigationController());
      Get.offAll(BottomNavigationScreen());
      navCtrl.updateBottomIndex(1);
      navCtrl.updateAppBarTitle();

      snackBar(value.toString());
      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      if (error.toString() != STRING_unexpectedException) {
        snackBar(error);
        Loader.hide();
      }
    });
  }
  getLocation({int? categoryId, int? id, FilterModel? model}) async {
    CustomLoader().show(Get.context);
    Geolocator.checkPermission().then((value) async {
      if (value == LocationPermission.denied) {
        permission = await Geolocator.requestPermission().then((value) async {
          if (value != LocationPermission.denied) {
            position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            providerListHitApi(categoryId, id,
                gender: model?.gender,
                rating: model?.rating,
                sort: model?.sortType);
          }
        });
      } else {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        providerListHitApi(categoryId, id,
            gender: model?.gender,
            rating: model?.rating,
            sort: model?.sortType);
      }
      update();
    });
  }

  providerListHitApi(int? catId, int? catSubId, {gender, rating, sort}) {
    _currentPage = 0;


    var filterReq = AuthRequestModel.filtersReq(
        gender: gender ?? '', rating: rating ?? '', sort: sort ?? '');

    APIRepository.providerListAPiCall(
        dataBody: filterReq,
        subCategoryId: catSubId,
        categoryId: catId,
         lat: position?.latitude,
         lng: position?.longitude,
        page: _currentPage)
        .then((value) {
      if (value != null) {
        providerModel = value;
        providerList = providerModel.list ?? [];
        Get.to(
            ServiceProviders(
                categoryId:
                catId,
                id:  catSubId),
            binding: HomeBinding());
        CustomLoader().hide();
        paginatedSubServiceData(catId, catSubId, gender, rating, sort);
        update();
      }
    }).onError((error, stackTrace) {
      CustomLoader().hide();
      snackBar(error.toString());
    });
    update();
  }

  void paginatedSubServiceData(
      int? catId, int? catSubId, gender, rating, sort) {
    providerScrollController?.addListener(() {
      if (providerScrollController?.position.pixels ==
          providerScrollController?.position.maxScrollExtent) {
        if (isLoading == false) {
          _currentPage++;
          if (_currentPage < providerModel.mMeta!.pageCount!) {
            isLoading = true;
            var filterReq = AuthRequestModel.filtersReq(
                gender: gender ?? '', rating: rating ?? '', sort: sort ?? '');
            Timer.periodic(Duration(milliseconds: 500), (timer) async {
              timer.cancel();
              await APIRepository.providerListAPiCall(
                      dataBody: filterReq,
                      subCategoryId: catSubId,
                      categoryId: catId,
                      page: _currentPage)
                  .then((value) {
                if (value != null) {
                  providerModel = value;
                  providerList.addAll(providerModel.list ?? []);

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

  void paginatedServiceData(int? id) {
    serviceScrollController?.addListener(() {
      if (serviceScrollController?.position.pixels ==
          serviceScrollController?.position.maxScrollExtent) {
        if (isServiceLoading == false) {
          _currenServicetPage++;
          if (_currenServicetPage < serviceModel.mMeta!.pageCount!) {
            isServiceLoading = true;

            Timer.periodic(Duration(milliseconds: 500), (timer) async {
              Loader.show(Get.context);
              timer.cancel();
              await APIRepository.serviceListAPiCall(
                      id ?? 0, _currenServicetPage)
                  .then((value) {
                if (value != null) {
                  serviceModel = value;
                  serviceList.addAll(serviceModel.list ?? []);
                  Loader.hide();
                  isServiceLoading = false;
                  update();
                }
              }).onError((error, stackTrace) {
                Loader.hide();
                snackBar(error);
              });
            });
            update();
          } else {
            isServiceLoading = false;
            update();
          }
        }
      }
    });
  }

  servicesListHitApi(int id) {
    Loader.show(Get.context);
    APIRepository.serviceListAPiCall(id, 0).then((value) {
      serviceModel = value;
      serviceList = serviceModel.list ?? [];
      paginatedServiceData(id);
      Loader.hide();
      update();
    }).onError((error, stackTrace) {
      Loader.hide();

      snackBar(error);
    });
  }

  availabilityListHitApi(int id) {
    Loader.show(Get.context);
    APIRepository.availabilityListAPiCall(id).then((value) {
      availabilityList = value.list ?? [];
      Loader.hide();
      update();
    }).onError((error, stackTrace) {
      Loader.hide();

      snackBar(error);
    });
  }

  ServiceProviderDetailModel? model = ServiceProviderDetailModel();

  hitGetUserProfileAPI(int? id) async {
    Loader.show(Get.context);
    APIRepository.getServiceProviderProfileApiCall(id ?? 0).then((value) async {
      model = value;
      Loader.hide();

      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      loader.value = false;
      snackBar(error);
    });
  }

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          // ignore: lines_longer_than_80_chars
          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      DateTime date = args.value;
      late DateTime startDate;
      var dayId = DateFormat('EEEE').format(date);

      getDayId(dayId);

      var today = DateFormat("yyyy-MM-dd").parse(DateTime.now().toString());

      var selected = DateFormat("yyyy-MM-dd").parse(date.toString());

      if (today == selected) {
        startDate =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(DateTime.now().toString());
      } else {
        startDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date.toString());
      }

      var endDate =
          DateTime(startDate.year, startDate.month, startDate.day, 23, 59, 59);

      hitGetSlotApiApi(
          providerId,
          startDate.toString().replaceAll('.000Z', ''),
          endDate.toString().replaceAll('.000', ''),
          nameId,
          storage.read('subId'));
    } else if (args.value is List<DateTime>) {
      _dateCount = args.value.length.toString();
    } else {
      _rangeCount = args.value.length.toString();
    }
    update();
  }

  void showImageDailog({url, context}) => AlertDialogs.showDialogNoAnimation(
      context: context,
      barrierDismissible: true,
      widget: Stack(
        children: [
          Container(
              height: Get.height * 0.8,
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl + url),
                disableGestures: false,
              )),
          Positioned(
            right: 5.0,
            child: getInkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ));
}
