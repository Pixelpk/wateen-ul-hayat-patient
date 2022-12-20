import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_care/constants/colors.dart';
import 'package:swift_care/export.dart';

snackBar(message, {int seconds = 1}) {
  if (message.toString().contains("invalid credentials")) {
    Get.offAll(() => LoginScreen());
  }
  return Get.snackbar(
    'Afaak Patient'.tr,
    '$message',
    borderRadius: 0,
    backgroundGradient: bannerGradient,
    animationDuration: Duration(seconds: seconds),
    backgroundColor: primaryColor,
    margin: EdgeInsets.zero,
    colorText: Colors.white,
  );
}
