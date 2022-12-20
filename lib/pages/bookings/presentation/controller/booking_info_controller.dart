import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:intl/intl.dart';
import 'package:swift_care/export.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';

import '../../../../model/data_model/booking_detail_model.dart';
import '../../../../model/data_model/booking_model.dart';
import '../../../../service/remote_service/entity/request_model/auth_reuest_model.dart';
import '../../../../service/remote_service/network/endpoint.dart';
import '../booking_info_screen.dart';

class BookInfoController extends GetxController {
  List<BookingModelData> bookingList = [];
  bool viewCurrentBooking = true;
  BookingListModel? model = BookingListModel();
  BookingDetailModel? dataModel = BookingDetailModel();
  BookingModel? bookingModel;
  SignUpResponseModel logInResponseModel = SignUpResponseModel();

  @override
  Future<void> onInit() async {
    bookingListHitApi(BOOKING_CURRENT);

    var value = await storage.read(LOCALKEY_profile);
    logInResponseModel = value;
    print(logInResponseModel.detail?.fullName);
    super.onInit();
  }

  timeFormat(date) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("hh:mm aaa").format(tempEndDate.toLocal());
      return endDate;
    }
    return "00:00";
  }

  dateFormat(date) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("yyyy-MM-dd").format(tempEndDate.toLocal());
      return endDate;
    }
    return "";
  }

  updateViewCurrentBooking(value) {
    viewCurrentBooking = value;
    update();
  }

  bookingListHitApi(int type) {
    Loader.show(Get.context);
    APIRepository.bookingListAPiCall(type: type).then((value) {
      bookingList = value.list ?? [];
      Loader.hide();
      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error);
    });
  }

  hitGetUserProfileAPI(int? id) async {
    Loader.show(Get.context);
    APIRepository.getBookingDetailApiCall(id ?? 0).then((value) async {
      dataModel = value;
      Loader.hide();
      Get.to(BookingInfoScreen());
      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error);
    });
  }

  hitPaymentAPI(id, transactionDetails) async {
    Loader.show(Get.context);

    var loginReq = AuthRequestModel.paymentReq(
      id: transactionDetails['transactionReference'] ?? '123',
      value: transactionDetails,
    );

    await APIRepository.getBookingApiCall(id: id.toString(), dataBody: loginReq)
        .then((value) {
      Get.back();
      Loader.hide();

      snackBar(value.toString());
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error.toString());
    });
  }

  dialog(context, id, finalPrice) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(STRING_PayNow.tr),
        content: Text(
          '${STRING_PayAbout.tr}${STRING_CURRENCY.tr} $finalPrice ${STRING_ForServices.tr}',
          style: TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              payPressed(finalPrice, id);
              Get.back();
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

  PaymentSdkConfigurationDetails generateConfig(finalPrice) {
    var billingDetails = BillingDetails(
        logInResponseModel.detail?.fullName ?? '',
        logInResponseModel.detail?.email ?? '',
        logInResponseModel.detail?.contactNo ?? '',
        logInResponseModel.detail?.userAddress?.street ?? '',
        "SA",
        logInResponseModel.detail?.userAddress?.otherInfo,
        "",
        "");

    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.STC_PAY);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: ProfileId,
        serverKey: ServerKey,
        clientKey: ClientKey,
        cartId: model?.detail?.uniqueId.toString() ?? '0',
        cartDescription: "Service Payment",
        merchantName: "Store",
        screentTitle: "Pay with Card",
        amount: double.parse(finalPrice),
        showBillingInfo: true,
        showShippingInfo: false,
        locale: storage.read(LOCALKEY_english) == null ||
                storage.read(LOCALKEY_english) == true
            ? PaymentSdkLocale.EN
            : PaymentSdkLocale.AR,
        forceShippingInfo: false,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        billingDetails: billingDetails,
        alternativePaymentMethods: apms,
        merchantApplePayIndentifier: 'merchant.com.shct.swift.care.provider',
        simplifyApplePayValidation: true,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();
    configuration.iOSThemeConfigurations = theme;
    configuration.simplifyApplePayValidation = true;

    return configuration;
  }

  appleDialog(context, id, finalPrice) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(STRING_PayNow.tr),
        content: Text(
          '${STRING_PayAbout.tr}${STRING_CURRENCY.tr} $finalPrice ${STRING_ForServices.tr}',
          style: TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              applePayPressed(finalPrice, id);
              Get.back();
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

  Future<void> payPressed(finalPrice, id) async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(finalPrice), (event) {
      if (event["status"] == "success") {
        var transactionDetails = event["data"];
        print(transactionDetails);
        Get.back();
        switch (transactionDetails['paymentResult']['responseStatus']) {
          case 'A':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);

              break;
            }
          case 'H':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'P':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'E':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'D':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'V':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
        }

        // if (transactionDetails['paymentResult']['responseStatus'] != 'E' ||
        //     transactionDetails['paymentResult']['responseStatus'] != 'D' ||
        //     transactionDetails['paymentResult']['responseStatus'] != 'V') {
        //   hitPaymentAPI(id, transactionDetails);
        // } else {
        //   snackBar(transactionDetails['paymentResult']['responseMessage']);
        //   hitPaymentAPI(id, transactionDetails);
        // }
      } else if (event["status"] == "error") {
        var transactionDetails = event;
        snackBar(transactionDetails);
        hitPaymentAPI(id, transactionDetails);
      } else if (event["status"] == "event") {
        var transactionDetails = event['message'];
        snackBar(transactionDetails);
      }
      update();
    });
  }

  Future<void> applePayPressed(finalPrice, id) async {
    FlutterPaytabsBridge.startApplePayPayment(generateConfig(finalPrice),
        (event) {
      if (event["status"] == "success") {
        var transactionDetails = event["data"];
        print(transactionDetails);

        switch (transactionDetails['paymentResult']['responseStatus']) {
          case 'A':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'H':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'P':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'E':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'D':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
          case 'V':
            {
              snackBar(transactionDetails['paymentResult']['responseMessage']);
              hitPaymentAPI(id, transactionDetails);
              break;
            }
        }
      } else if (event["status"] == "error") {
        var transactionDetails = event;
        snackBar(transactionDetails);
        hitPaymentAPI(id, transactionDetails);
      } else if (event["status"] == "event") {
        var transactionDetails = event['message'];
        snackBar(transactionDetails);
      }
      update();
    });
  }
}
