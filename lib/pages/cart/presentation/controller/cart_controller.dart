import 'package:swift_care/export.dart';
import 'package:swift_care/model/data_model/category_data_model.dart';
import 'package:swift_care/model/responseModal/family_response_model.dart';
import 'package:swift_care/pages/home/presentation/views/bottom_navigation_screen.dart';
import 'package:intl/intl.dart';
import '../../../../model/responseModal/service_db_response_model.dart';
import '../../../../model/responseModal/signup_response_model.dart';
import '../../../../model/responseModal/slot_data_model.dart';
import '../../../../service/remote_service/entity/request_model/auth_reuest_model.dart';
import '../../../service_providers/presentation/views/avaiable_calendar_screen.dart';
import '../../cart_data_model.dart';
import '../../cart_db.dart';
import '../cart_screen.dart';

class CartController extends GetxController {
  ServiceDbResponseModel? serviceDbResponseModel;
  List<ServiceDB> cartServiceList = [];
  List<ServiceDB> slotServiceList = [];
  TextEditingController startDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController endDate = TextEditingController();

  var cartTotal;
  double total = 0;
  double subtotal = 0;
  int? providerId;
  bool isEmpty = false;
  bool isMemberSelected = true;
  final dbHelper = DatabaseHelper.instance;
  SlotDataModel? slotDataModel;
  List<FamilyMember> familyList = [];
  int? typeId = 0;
  int? val = 1;
  String? dropValue = 'en';
  String? familyAddress;
  int? addressID;
  String? countryCode;
  String? lat;
  String? lng;
  bool isSubscribed = false;
  bool isStartDate = false;
  int? bookingType = 0;

  bool? isListEmpty = false;

  var selectedEndDate;
  String? dbEndDate;
  String? newDbEndDate;
  var newSelectedEndDate;

  var difference;
  var days;

  clearSlotData() {
    slotDataModel = null;
    update();
  }

  FamilyMember? itemSelectedFamily;
  late List<DropdownMenuItem<FamilyMember>> dropdownMenuItemsServiceType;

  timeFormat(date) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("hh:mm aaa").format(tempEndDate.toLocal());
      return endDate;
    }
    return STRING_Reset;
  }

  cartTimeFormat(date) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("hh:mm a").format(tempEndDate.toLocal());
      return endDate;
    }
    return STRING_Reset;
  }

  dateFormat(date, {bool = false}) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("yyyy-MM-dd").format(tempEndDate.toLocal());
      return endDate;
    }
    if (bool) {
      return STRING_EndDate.tr;
    } else {
      return STRING_StartDate.tr;
    }
  }

  selectDate(BuildContext context, int? id, int? subId) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: newSelectedEndDate == null
          ? DateTime.now()
          : DateTime.parse(newSelectedEndDate.toString().toString()),
      firstDate: newSelectedEndDate == null
          ? DateTime.now()
          : DateTime.parse(newSelectedEndDate.toString().toString()),
      lastDate: DateTime(2100),
    );
    if (selected != null && selected != selectedEndDate) {
      selectedEndDate = selected;

      dbEndDate = selectedEndDate
          .toString()
          .replaceAll("00:00:00.000", cartTimeFormat(slotDataModel?.endTime));

      newDbEndDate = DateFormat("yyyy-MM-dd HH:mm:ss")
          .format(DateFormat("yyyy-MM-dd hh:mm a").parse(dbEndDate!));

      hitGetSlotAvailabilityApi(id ?? 0, slotDataModel?.startTime ?? '',
          newDbEndDate ?? '', subId, context);
    }

    difference = selectedEndDate
            .difference(DateTime.parse(dateFormat(slotDataModel?.startTime)))
            .inDays +
        1;

    update();
  }

  queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    cartServiceList.clear();
    allRows.forEach((row) => {
          cartServiceList.add(ServiceDB.fromMap(row)),
        });

    if (cartServiceList.isNotEmpty) {
      providerId = cartServiceList[0].providerId;
    }

    _calcTotal();

    final allSlot = await dbHelper.queryAllSlots();
    slotServiceList.clear();
    List slotsLIst = [];
    allSlot.forEach((row) => {
          slotServiceList.add(ServiceDB.fromSlotMap(row)),
          slotsLIst.add(row),
        });

    SignUpResponseModel data = await storage.read(LOCALKEY_profile);

    countryCode = data.detail?.countryCode;

    familyAddress =
        '${data.detail?.userAddress?.houseNo},${data.detail?.userAddress?.street}';

    lat = data.detail?.userAddress?.latitude;
    lng = data.detail?.userAddress?.longitude;

    addressID = data.detail?.userAddress?.id ?? 0;
    update();
  }

  querySlotData(int? id) async {
    final allRows = await dbHelper.queryAllSlots();
    slotServiceList.clear();
    List slotsLIst = [];
    allRows.forEach((row) => {
          slotServiceList.add(ServiceDB.fromSlotMap(row)),
          slotsLIst.add(row),
        });

    hitGetBookingApiApi(providerId ?? 0, addressID ?? 0, "cardId", total,
        cartTotal, subtotal, slotsLIst);
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

  queryProviderTap(int id, BuildContext context, CategoryData serviceList,
      SlotDataModel slotDataModel, String familyName,
      {endDate, price, difference, bookingType}) async {
    await dbHelper.queryProvider(id).then((value) {
      if (value != null && value.length > 0) {
        providerId = value.first['providerId'];

        if (providerId != id) {
          _dialog(context, id, serviceList, slotDataModel, familyName,
              endDate: endDate, bookingType: bookingType, price: price);
        } else {
          insert(
              id,
              serviceList.subCategoryName,
              updateGender(serviceList.gender),
              price == null
                  ? double.parse(serviceList.price ?? "0")
                  : double.parse(price.toString()),
              slotDataModel.startTime,
              endDate == null ? slotDataModel.endTime : endDate.toString(),
              familyName,
              serviceList.id ?? 0,
              difference,
              bookingType);
          Get.to(CartScreen(id));
        }
      } else {
        insert(
            id,
            serviceList.subCategoryName,
            updateGender(serviceList.gender),
            price == null
                ? double.parse(serviceList.price ?? "0")
                : double.parse(price.toString()),
            slotDataModel.startTime,
            endDate == null ? slotDataModel.endTime : endDate.toString(),
            familyName,
            serviceList.id ?? 0,
            difference,
            bookingType);
        Get.to(CartScreen(id));
      }
    });

    queryAll();
    update();
  }

  queryProviderSlot(BuildContext context, SlotDataModel serviceList,
      CategoryData serviceData, int? typeId, FamilyMember? familyData, int? id,
      {endDate, price, difference, bookingType}) async {
    insertSlot(
        serviceData.id,
        price == null
            ? double.parse(serviceData.price ?? "0")
            : double.parse(price.toString()),
        serviceList.startTime,
        endDate == null ? serviceList.endTime : endDate.toString(),
        typeId,
        serviceData.categoryName,
        serviceData.gender,
        familyData?.id ?? 0,
        familyData?.name ?? "",
        id ?? 0,
        difference,
        bookingType);

    update();
  }

  _dialog(BuildContext context, int id, CategoryData serviceList,
      SlotDataModel slotDataModel, String familyName,
      {endDate, price, bookingType}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(STRING_ItemsInCart.tr),
        content: Text(STRING_ClearCart.tr),
        actions: <Widget>[
          InkWell(
            onTap: () {
              deleteCart();
              deleteSlot();
              insert(
                  id,
                  serviceList.subCategoryName,
                  updateGender(serviceList.gender),
                  price == null
                      ? double.parse(serviceList.price ?? "0")
                      : double.parse(price.toString()),
                  slotDataModel.startTime,
                  endDate == null ? slotDataModel.endTime : endDate,
                  familyName,
                  serviceList.id ?? 0,
                  difference ?? 1,
                  bookingType);
              Navigator.of(ctx).pop();
              Get.to(CartScreen(id));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(10)),
              child: text(STRING_yes.tr, color: Colors.white, fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(10)),
              child: text(STRING_No.tr, color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  _availabilityDialog(BuildContext context, dates) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Attention!'),
        content: InkWell(
          onTap: () {
            Get.to(AvailableCalendarScreen(dates));
          },
          child: RichText(
            text: TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: '${STRING_ProviderIsUnavailable.tr} '),
                TextSpan(
                    text: '${STRING_forTheseDates.tr}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    )),
                TextSpan(text: '${STRING_DoYouStill.tr} '),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: COLOR_middleblues,
                  borderRadius: BorderRadius.circular(10)),
              child: text(STRING_yes.tr, color: Colors.white, fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () {
              difference = null;
              selectedEndDate = null;
              dbEndDate = null;
              newSelectedEndDate = null;
              slotDataModel = null;
              isStartDate = false;
              update();
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: COLOR_middleblues,
                  borderRadius: BorderRadius.circular(10)),
              child: text(STRING_No.tr, color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  hitGetBookingApiApi(int providerId, int addressId, String cardId,
      double finalPrice, var price, double taxPrice, var serviceJson) {
    Loader.show(Get.context);
    var slotReq = AuthRequestModel.getBookingReq(
      addressId: addressId.toString(),
      cardId: cardId,
      finalPrice: finalPrice.toString(),
      price: price.toString(),
      providerId: providerId.toString(),
      serviceJson: jsonEncode(serviceJson),
      taxPrice: taxPrice.toString(),
    );
    APIRepository.bookingApiCall(dataBody: slotReq).then((value) async {
      Loader.hide();
      deleteCart();
      deleteSlot();
      hitPostCartApi();
      Get.deleteAll();
      Get.offAll(BottomNavigationScreen(),
          binding: ReaderBinding(), arguments: {'tab': 2});
      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error.toString());
    });
  }

  hitGetSlotAvailabilityApi(int id, String selectedDate, String endDate,
      int? subId, BuildContext context) {
    Loader.show(Get.context);
    var slotReq = AuthRequestModel.getSlotAvailabilityReq(
        endDay: endDate.toString(),
        subscribedEndTime: endDate,
        startDay: selectedDate.toString(),
        subscribedStartTime: selectedDate);
    APIRepository.getAvailabilitySlotApiCall(
            dataBody: slotReq, id: id, subId: subId ?? 0)
        .then((value) async {
      Loader.hide();

      if (value.totalDays != null) {
        difference = value.totalDays;
      }

      if (value.unavailableDays != null) {
        days = value.unavailableDays;
      }

      var list = days?.toString().split(',');

      if (days != null) {
        _availabilityDialog(context, list);
      }

      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error.toString());
    });
  }

  hitPostCartApi() async {
    final allRows = await dbHelper.queryAllSlots();
    slotServiceList.clear();
    List slotsLIst = [];
    allRows.forEach((row) => {
          slotServiceList.add(ServiceDB.fromSlotMap(row)),
          slotsLIst.add(row),
        });

    var slotReq = AuthRequestModel.getCartReq(
      serviceJson: jsonEncode(slotsLIst),
    );
    APIRepository.postCartApiCall(dataBody: slotReq).then((value) async {
      update();
    }).onError((error, stackTrace) {
      if (error.toString() != STRING_unexpectedException) {}
    });
  }

  hitAddAddressApi(
    String? address,
    String? city,
    String? country,
    String? fullName,
    String? latitude,
    String? longitude,
    String? phoneNumber,
    String? state,
    String? zipcode,
  ) {
    var slotReq = AuthRequestModel.addAddressReq(
        address: address,
        city: city,
        country: country,
        fullName: fullName,
        latitude: latitude,
        longitude: longitude,
        phoneNumber: phoneNumber,
        state: state,
        zipcode: zipcode);
    APIRepository.addAddressApiCall(dataBody: slotReq).then((value) async {
      snackBar(value);
      Get.deleteAll();
      Get.offAll(BottomNavigationScreen(),
          binding: ReaderBinding(), arguments: 1);
      update();
    }).onError((error, stackTrace) {
      if (error.toString() != STRING_unexpectedException) {
        snackBar(error);
      }
    });
  }

  insert(providerId, name, gender, price, String? startTime, String? endTime,
      String familyName, int serviceID, int difference, int bookingType) async {
    Map<String, dynamic> row = {
      DatabaseHelper.providerId: providerId,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnGender: gender,
      DatabaseHelper.columnPrice: price,
      DatabaseHelper.startTime: startTime,
      DatabaseHelper.endTime: endTime,
      DatabaseHelper.serviceId: serviceID,
      DatabaseHelper.familyName: familyName,
      DatabaseHelper.address: familyAddress,
      DatabaseHelper.difference: difference,
      DatabaseHelper.slotBookingType: bookingType,
    };
    ServiceDB serviceDB = ServiceDB.fromMap(row);
    await dbHelper.insert(serviceDB);

    update();
  }

  insertSlot(
      serviceId,
      price,
      startTime,
      endTime,
      int? typeId,
      String? categoryName,
      int? gender,
      int? id,
      String familyName,
      int providerId,
      int difference,
      int slotBookingType) async {
    ServiceDB serviceDB = ServiceDB.fromSlotMap({
      DatabaseHelper.serviceId: serviceId,
      DatabaseHelper.providerId: providerId,
      DatabaseHelper.price: price,
      DatabaseHelper.startTime: startTime,
      DatabaseHelper.endTime: endTime,
      DatabaseHelper.typeId: typeId,
      DatabaseHelper.familyId: id,
      DatabaseHelper.address: familyAddress,
      DatabaseHelper.latitude: lat,
      DatabaseHelper.longitude: lng,
      DatabaseHelper.familyName: familyName,
      DatabaseHelper.columnName: categoryName,
      DatabaseHelper.columnGender:
          gender != 1 ? STRING_Female.tr : STRING_Male.tr,
      DatabaseHelper.slotStartTime: startTime,
      DatabaseHelper.slotEndTime: endTime,
      DatabaseHelper.difference: difference,
      DatabaseHelper.slotBookingType: slotBookingType,
      DatabaseHelper.unavailableDate: days ?? '',
    });

    await dbHelper.insertSlot(serviceDB);

    update();
  }

  @override
  Future<void> onInit() async {
    if (storage.read(LOCALKEY_cardList) == null) {
      isListEmpty = false;
    } else {
      isListEmpty = storage.read(LOCALKEY_cardList);
    }

    final count = await dbHelper.queryRowCount();
    if (count == 0) {
      hitGetCartAPI();
    }
    queryAll();
    hitGetFamilyMembersListAPI();
    super.onInit();
  }

  deleteItem(int id) async {
    await dbHelper.delete(id);
    queryAll();
    update();
  }

  deleteSlotItem(int id) async {
    await dbHelper.deleteSlot(id);
    queryAll();
    update();
  }

  deleteCart() async {
    await dbHelper.deleteAll();
    queryAll();
    update();
  }

  deleteSlot() async {
    await dbHelper.deleteAllSlots();
    update();
  }

  void _calcTotal() async {
    var total = (await dbHelper.calculateTotal());
    if (cartServiceList.length > 0) {
      cartTotal = total;
    }
    update();
  }

  hitGetFamilyMembersListAPI() async {
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.getFamilyMembersListApiCall().then((value) async {
      if (value != null) {
        familyList = value.list ?? [];

        dropdownMenuItemsServiceType = buildDropDownMenuItemsFamily(familyList);
      }

      update();
    }).onError((error, stackTrace) {
      snackBar(error);
    });
  }

  hitGetCartAPI() async {
    FocusManager.instance.primaryFocus!.unfocus();

    APIRepository.getCartAPiCall().then((value) async {
      serviceDbResponseModel = value;
      cartServiceList = value.detail ?? [];
      for (int i = 0; i < cartServiceList.length; i++) {
        insert(
            cartServiceList[i].providerId,
            cartServiceList[i].name,
            cartServiceList[i].gender,
            cartServiceList[i].price,
            cartServiceList[i].startTime,
            cartServiceList[i].endTime,
            cartServiceList[i].familyName ?? "",
            cartServiceList[i].serviceId ?? 0,
            cartServiceList[i].difference ?? 0,
            cartServiceList[i].slotBookingType ?? 0);

        insertSlot(
            cartServiceList[i].serviceId,
            cartServiceList[i].price,
            cartServiceList[i].startTime,
            cartServiceList[i].endTime,
            cartServiceList[i].typeId,
            cartServiceList[i].name,
            cartServiceList[i].gender != null ? 0 : 1,
            cartServiceList[i].id ?? 0,
            cartServiceList[i].familyName ?? "",
            cartServiceList[i].providerId ?? 0,
            cartServiceList[i].difference ?? 0,
            cartServiceList[i].slotBookingType ?? 0);

        providerId = cartServiceList[i].providerId ?? 0;
      }

      _calcTotal();
      queryAll();

      update();
    }).onError((error, stackTrace) {
      snackBar(error);
    });
  }

  List<DropdownMenuItem<FamilyMember>> buildDropDownMenuItemsFamily(
      List listItems) {
    List<DropdownMenuItem<FamilyMember>> items = [];
    for (FamilyMember listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name ?? "",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              )),
          value: listItem,
        ),
      );
    }
    return items;
  }

  onChangeMemberType(type) {
    itemSelectedFamily = type;
    familyAddress =
        '${itemSelectedFamily?.city}, ${itemSelectedFamily?.address}';
    lat = itemSelectedFamily?.latitude;
    lng = itemSelectedFamily?.longitude;
    addressID = itemSelectedFamily?.id ?? 0;
    typeId = 1;
    update();
  }
}
