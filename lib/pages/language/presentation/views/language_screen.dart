import '../../../../export.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LanguageController>(builder: (controller) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                imageAsset(ICON_smalllogo, height: 100, width: 200),
                Column(
                  children: [
                    Container(
                      height: 50,
                      child: text('select language'.tr,
                          fontSize: 18,
                          isBold: true,
                          color: COLOR_russianVoilet),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: cbtnOutlinedButton(
                                height: 45,
                                onPressed: () {
                                  controller.isLangSelected = true;
                                  Get.updateLocale(Locale('en', 'US'));
                                },
                                label: "English",
                                backgroundColor:
                                    Get.locale?.countryCode?.camelCase == 'us'
                                        ? COLOR_middleBlueM
                                        : COLOR_whiteM,
                                textColor:
                                    Get.locale?.countryCode?.camelCase == 'us'
                                        ? Colors.white
                                        : COLOR_lightGray),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: cbtnOutlinedButton(
                                height: 45,
                                onPressed: () {
                                  controller.isLangSelected = true;
                                  Get.updateLocale(Locale('ar', 'SA'));
                                },
                                label: "Arabic".tr,
                                backgroundColor:
                                    Get.locale?.countryCode?.camelCase == 'sa'
                                        ? COLOR_middleBlueM
                                        : COLOR_whiteM,
                                textColor:
                                    Get.locale?.countryCode?.camelCase == 'sa'
                                        ? Colors.white
                                        : COLOR_lightGray),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: cbtnElevatedButton(
                    onPressed: () {
                      if (controller.isLangSelected == true)
                        controller.onContinue();
                    },
                    label: 'continue'.tr,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
