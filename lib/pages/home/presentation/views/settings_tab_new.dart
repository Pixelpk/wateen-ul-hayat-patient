import 'package:flutter/cupertino.dart';
import 'package:swift_care/components/confirm_dialog.dart';
import 'package:swift_care/export.dart';

import '../../../../components/cutsom_lang_sheet.dart';
import '../../../../components/default_app_bar.dart';
import '../../../authentication/presentation/views/change_password.dart';
import '../../../staticPages/presentation/controllers/static_page_controller.dart';
import '../../../staticPages/presentation/views/contact_us.dart';
import '../../../staticPages/presentation/views/faq_screen.dart';
import '../../../staticPages/presentation/views/static_page.dart';
import '../controllers/bottom_navigation_controller.dart';

class SettingsTabNew extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();
  BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(builder: (controller) {
      return Scaffold(
          appBar: DefaultAppBar(
            title: STRING_Settings.tr,
            showBackButton: false,
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: DIMENS_20),
                  child: _mainBuild(controller, context)),
              _logoutButton(),
              vGap(DIMENS_80)
            ]),
          ));
    });
  }

  _mainBuild(BottomNavigationController controller, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: DIMENS_15),
      elevation: 3,
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: DIMENS_10),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            titleRow(
                context: context,
                title: STRING_Notifications.tr,
                onTap: () {},
                onTrailing: notificationSwitchButton(controller)),
            vDivider(context),
            titleRow(
              context: context,
              title: STRING_ChangePassword.tr,
              onTrailing: leftArrowIconWidget(controller),
              onTap: () {
                Get.to(ChangePassword());
              },
            ),
            divider(context),
            titleRow(
              context: context,
              title: STRING_ChangeLanguage.tr,
              onTrailing: leftArrowIconWidget(controller),
              onTap: () {
                BottomNavigationController controllers =
                    Get.put(BottomNavigationController());

                openCustomLanguageDialogue(
                    customText: STRING_ChangeLanguage.tr,
                    onNo: () {
                      Loader.show(context);
                      controller.langVal = 1;
                      storage.write(LOCALKEY_english, true);
                      Get.updateLocale(Locale('en', 'US'));
                      controller.setLangHitApi('en');
                      Future.delayed(Duration(seconds: 1), () {
                        Loader.hide();
                      });
                      Get.back();
                      controllers.updateAppBarTitle();
                      controller.update();
                    },
                    onYes: () {
                      Loader.show(context);
                      controller.langVal = 2;
                      storage.write(LOCALKEY_english, false);
                      controller.setLangHitApi('ar');
                      Get.updateLocale(Locale('ar', 'DZ'));
                      Future.delayed(Duration(seconds: 1), () {
                        Loader.hide();
                      });
                      Get.back();
                      controllers.updateAppBarTitle();
                      controller.update();
                    },
                    controller: controller);
              },
            ),
            divider(context),
            titleRow(
              context: context,
              title: STRING_PrivacyPolicy.tr,
              onTrailing: leftArrowIconWidget(controller),
              onTap: () {
                var ctrl = Get.put(StaticPageController());
                ctrl.hitStaticPageAPI(0);
                Get.to(StaticPageScreen(title: STRING_PrivacyPolicy.tr));
              },
            ),
            divider(context),
            titleRow(
              context: context,
              title: STRING_TC.tr,
              onTrailing: leftArrowIconWidget(controller),
              onTap: () {
                var ctrl = Get.put(StaticPageController());
                ctrl.hitStaticPageAPI(0);
                Get.to(StaticPageScreen(title: STRING_TC.tr));
              },
            ),
            vDivider(context),
            titleRow(
              context: context,
              title: STRING_AboutUs.tr,
              onTrailing: leftArrowIconWidget(controller),
              onTap: () {
                var ctrl = Get.put(StaticPageController());
                ctrl.hitStaticPageAPI(2);
                Get.to(StaticPageScreen(title: STRING_AboutUs.tr));
              },
            ),
            divider(context),
            titleRow(
              context: context,
              title: STRING_ContactUs.tr,
              onTrailing: leftArrowIconWidget(controller),
              onTap: () {
                Get.to(ContactUs());
              },
            ),
            divider(context),
            titleRow(
              context: context,
              title: STRING_Help.tr,
              onTrailing: leftArrowIconWidget(controller),
              onTap: () {
                var ctrl = Get.put(StaticPageController());
                ctrl.hitStaticPageAPI(1);

                Get.to(StaticPageScreen(title: STRING_Help.tr));
              },
            ),
            divider(context),
            titleRow(
              context: context,
              title: STRING_FAQ.tr,
              onTrailing: leftArrowIconWidget(controller),
              onTap: () {
                Get.to(FaqScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  titleRow(
      {required BuildContext context,
      required String title,
      required onTap,
      required Widget onTrailing}) {
    return getInkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text(title,
                color: Theme.of(context).primaryColorDark,
                fontSize: FONT_14,
                isBold: false),
            onTrailing
          ],
        ),
      ),
    );
  }

  Widget notificationSwitchButton(BottomNavigationController controller) {
    return Transform.scale(
      scale: 0.95,
      child: CupertinoSwitch(
        activeColor: primaryColor,
        trackColor: primaryColorLight,
        value: controller.toggleNotification,
        onChanged: (bool value) {
          controller.toggleNotification = value;
          print("===================$value");
          controller.update();
          controller.notificationToggleHitApi(value);
          storage.write(LOCALKEY_notification, value);
        },
      ),
    );
  }

/*  Widget themeSwitchButton(BottomNavigationController controller) {
    return CupertinoSwitch(
      activeColor: appColor,
      value: storage.read(LOCALKEY_darkTheme) ?? false,
      onChanged: (bool value) {
        controller.toggleDarkTheme = value;
        print("===================${value}");
        storage.write(LOCALKEY_darkTheme, value);
        controller.update();
        changeTheme();
      },
    );
  }*/

  Widget leftArrowIconWidget(BottomNavigationController controller) {
    return controller.langVal == 1
        ? Icon(
            Icons.keyboard_arrow_right_rounded,
            color: primaryColor,
            size: 30,
          )
        : Icon(
            Icons.keyboard_arrow_left_rounded,
            color: primaryColor,
            size: 30,
          );
  }

  divider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Divider(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget vDivider(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      margin: EdgeInsets.symmetric(vertical: DIMENS_10),
      color: Theme.of(context).dividerColor,
    );
  }

  _logoutButton() {
    return cbtnElevatedButton(
        onPressed: () async {
          bool isConfirmed = await confirmDialog(
            Get.context!,
            content: STRING_Logout.tr,
            cancelText: STRING_No.tr,
            confirmText: STRING_yes.tr,
          );
          if (isConfirmed) {
            controller.hitLogoutAPI();
          }
        },
        label: STRING_Logoutt.tr,
        backgroundColor: appColor);
  }
}
