import 'package:flutter/cupertino.dart';

import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'package:swift_care/pages/home/presentation/views/bottom_navigation_screen.dart';


import '../../../../export.dart';

class BookedSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(builder: (controller) {
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
                      STRING_bookedSuccessFully.tr,
                      maxLines: 2,
                      fontSize: FONT_22,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                    vGap(DIMENS_10),

                    vGap(DIMENS_50),
                    cbtnElevatedButton(
                        onPressed: () {
                          Get.offAll(BottomNavigationScreen());
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(DIMENS_8)),
                        height: DIMENS_50,
                        label: STRING_ok.tr,
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
