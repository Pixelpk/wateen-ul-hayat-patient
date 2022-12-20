import 'package:flutter/cupertino.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/loginController.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/signup_controller.dart';

import '../../../../export.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
            appBar: backAppBar2(
              context:context,
            ),
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vGap(DIMENS_60),
                    imageAsset(ICON_success, height: DIMENS_90),
                    vGap(DIMENS_30),
                    text(
                      STRING_pswdResetSuccessFully.tr,
                      maxLines: 2,
                      fontSize: FONT_22,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                    vGap(DIMENS_10),
                    text(
                      STRING_pswdResetSuccessFullyDesc.tr,
                      maxLines: 5,
                      fontSize: FONT_16,
                      color: Colors.black54,
                      textAlign: TextAlign.start,
                    ),
                    vGap(DIMENS_50),
                    cbtnElevatedButton(
                        onPressed: () {
                          Get.offAll(LoginScreen());
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(DIMENS_8)),
                        height: DIMENS_50,
                        label: STRING_signIn.tr,
                        backgroundColor: appColor),
                    vGap(DIMENS_20),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
