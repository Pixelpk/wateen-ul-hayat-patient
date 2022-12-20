import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:swift_care/export.dart';
import 'package:swift_care/model/responseModal/signup_response_model.dart';
import '../../../service/remote_service/entity/request_model/auth_reuest_model.dart';
import '../../../service/remote_service/network/endpoint.dart';

class PayTab extends StatefulWidget {
  SignUpResponseModel logInResponseModel = SignUpResponseModel();
  var finalPrice;
  var id;
  PayTab(this.logInResponseModel, this.finalPrice, this.id);

  @override
  _PayTabState createState() => _PayTabState();
}

class _PayTabState extends State<PayTab> {
  String _instructions = 'Tap on "Pay" Button to try PayTabs plugin';

  PaymentSdkConfigurationDetails generateConfig() {
    var billingDetails = BillingDetails(widget.logInResponseModel.detail?.fullName??'', widget.logInResponseModel.detail?.email??'',
        widget.logInResponseModel.detail?.contactNo??'', "st. 12", "ae", "dubai", "dubai", "12345");
    var shippingDetails = ShippingDetails(widget.logInResponseModel.detail?.fullName??'', widget.logInResponseModel.detail?.email??'',
        widget.logInResponseModel.detail?.contactNo??'', "st. 12", "ae", "dubai", "dubai", "12345");
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.STC_PAY);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "66503",
        serverKey: ServerKey,
        clientKey: ClientKey,
        cartId: "12434",
        cartDescription: "Service Payment",
        merchantName: "Store",
        screentTitle: "Pay with Card",
        amount: double.parse(widget.finalPrice),
        showBillingInfo: true,
        forceShippingInfo: false,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        billingDetails: billingDetails,
        shippingDetails: shippingDetails,
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();

    // theme.logoImage = ICON_app_icon;

    configuration.iOSThemeConfigurations = theme;

    return configuration;
  }

  Future<void> payPressed() async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(), (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          hitPaymentAPI(widget.id);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> apmsPayPressed() async {
    FlutterPaytabsBridge.startAlternativePaymentMethod(await generateConfig(),
        (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
         hitPaymentAPI(widget.id);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  hitPaymentAPI(id) async {
    Loader.show(Get.context);

    var loginReq = AuthRequestModel.paymentReq(
     id: '1',value: 'd',

    );

    APIRepository.getBookingApiCall(dataBody: loginReq,id: id.toString()).then((value) {
      if (value != null) {
        snackBar(value.toString());
        Loader.hide();
        Get.back();

      }
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error.toString());
    });
  }

  Future<void> applePayPressed() async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "*Profile id*",
        serverKey: "*server key*",
        clientKey: "*client key*",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        amount: 20.0,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        merchantApplePayIndentifier: "merchant.com.bunldeId",
        simplifyApplePayValidation: true);
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Widget applePayButton() {
    if (Platform.isIOS) {
      return TextButton(
        onPressed: () {
          applePayPressed();
        },
        child: Text('Pay with Apple Pay'),
      );
    }
    return SizedBox(height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar2(
        context: context,
        title: text('Payment', fontWeight: FontWeight.w600, fontSize: FONT_17),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: cbtnElevatedButton(
                  onPressed: () {
                    payPressed();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DIMENS_8)),
                  height: DIMENS_50,
                  textStyle: textStyle(fontWeight: FontWeight.bold),
                  label: 'Pay with Card',
                  backgroundColor: appColor),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: cbtnElevatedButton(
                  onPressed: () {
                    apmsPayPressed();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DIMENS_8)),
                  height: DIMENS_50,
                  textStyle: textStyle(fontWeight: FontWeight.bold),
                  label: 'Pay with Alternative payment methods',
                  backgroundColor: appColor),
            ),
            SizedBox(height: 16),
            applePayButton()
          ])),
    );
  }
}
