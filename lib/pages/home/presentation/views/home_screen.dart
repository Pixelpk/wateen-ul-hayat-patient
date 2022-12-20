import 'package:swift_care/model/responseModal/myaccount_model.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/loginController.dart';
import 'package:swift_care/pages/authentication/presentation/views/profile_screen.dart';
import 'package:swift_care/pages/home/presentation/controllers/home_controller.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';
import 'package:swift_care/pages/staticPages/presentation/views/static_page_screen.dart';

import '../../../../export.dart';

class HomeScreen extends StatelessWidget {
  final StaticPageController staticPageController =
      Get.put(StaticPageController());
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
  final MyAccountModel? myAccountModel = MyAccountModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          homeController.onWillPop();
          return Future.value(true);
        },
        child: SafeArea(
            child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: titleNDrawerAppBar(
              title: 'My Base'.tr,
              icon: ICON_menu,
              onPressed: () {
                scaffoldKey!.currentState!.openEndDrawer();
              }),
          endDrawer: customDrawer(),
          body: GetBuilder<HomeController>(
            builder: (controller) {
              return Padding(
                  padding: EdgeInsets.only(
                      left: DIMENS_24, right: DIMENS_24, top: DIMENS_16),
                  child: Column(
                    children: [
                      Card(
                        shadowColor: Colors.grey.withOpacity(0.4),
                        elevation: 3,
                        child: ctextFormFieldwithPrefix(
                            hintText: 'search'.tr,
                            onChange: (val) {
                              controller.search(val);
                              return null;
                            },
                            textInputAction: TextInputAction.search,
                            prefix: Container(
                              child:
                                  imageAsset(ICON_search, height: 8, width: 8),
                              padding: EdgeInsets.only(
                                  left: DIMENS_15, right: DIMENS_15),
                            ),
                            focusNode: controller.searchFocusNode,
                            controller: controller.searchController),
                      ),
                      vGap(DIMENS_24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: cbtnOutlinedButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.onMyBookTap();
                                  controller.hitMyBookAPI();
                                  controller.searchController.clear();
                                },
                                label: 'My Books'.tr,
                                textColor: controller.isMyBook.value
                                    ? Colors.white
                                    : COLOR_lightGray,
                                backgroundColor: controller.isMyBook.value
                                    ? COLOR_voiletM
                                    : Colors.transparent),
                          ),
                          hGap(DIMENS_16),
                          Expanded(
                            child: cbtnOutlinedButton(
                                onPressed: () {
                                  controller.hitMyBookAPI();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.onLentBookTap();
                                  controller.searchController.clear();
                                },
                                label: 'Books I lent'.tr,
                                textColor: !controller.isMyBook.value
                                    ? Colors.white
                                    : COLOR_lightGray,
                                backgroundColor: !controller.isMyBook.value
                                    ? COLOR_voiletM
                                    : Colors.transparent),
                          ),
                        ],
                      ),
                      vGap(DIMENS_16),
                      controller.homeLoader.value
                          ? Expanded(
                              child: Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          primaryColor))))
                          : Expanded(
                              child: Container(
                                color: Colors.blue,
                              ),
                            )
                    ],
                  ));
            },
          ),
        )));
  }

  customDrawer() => Drawer(
        child: Column(
          children: [
            vGap(32),
            profileHeader(loginController, homeController),
            Divider(),
            listTile(
                icon: ICON_account_info,
                text: 'Account Information'.tr,
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  scaffoldKey!.currentState!.openDrawer();
                  Get.to(() => ProfileScreen());
                }),
            listTile(
                icon: ICON_language,
                text:
                    '${Get.locale?.countryCode?.camelCase == 'sa' ? 'English' : 'Arabic'}',
                onTap: () {
                  scaffoldKey!.currentState!.openDrawer();
                  if (Get.locale?.countryCode?.camelCase == 'sa') {
                    Get.updateLocale(Locale('en', 'US'));
                    storage.write(LOCALKEY_currentLang, 'en');
                  } else {
                    Get.updateLocale(Locale('ar', 'SA'));
                    storage.write(LOCALKEY_currentLang, 'ar');
                  }
                  log.e(storage.read(LOCALKEY_currentLang));
                }),
            listTile(
                icon: ICON_faq,
                text: 'FAQs'.tr,
                onTap: () {
                  homeController.isfaq.value = true;
                  // staticPageController.faqListHitApi();
                  scaffoldKey!.currentState!.openDrawer();
                  Get.to(() => StaticPageScreen(type: 'FAQs'));
                }),
            listTile(
                icon: ICON_about,
                text: 'About Us'.tr,
                onTap: () {
                  homeController.isfaq.value = false;
                  scaffoldKey!.currentState!.openDrawer();
                  Get.to(() => StaticPageScreen(type: 'About Us'));
                }),
            listTile(
                icon: ICON_logout,
                text: 'Logout'.tr,
                onTap: () {
                  storage.remove(LOCALKEY_token);
                  scaffoldKey!.currentState!.openDrawer();
                  loginController.mobileController.clear();
                  loginController.passwordController.clear();
                  log.e(storage.read(LOCALKEY_token));
                  log.e(storage.read(LOCALKEY_myAccount));
                  Get.offAll(() => LoginScreen());
                  snackBar('Logout Successfully');
                }),
          ],
        ),
      );
}

Future<void> readBook({path, id, bookController}) async {
  var data;
  data = {
    "bookId": "",
    "href": "",
    "created": 0,
    "locations": {"cfi": ""}
  };
  var datax = storage.read('$id');
  if (datax != null) {
    data = json.decode(datax);
  }
  Map locations = data != null ? data['locations'] : Map();
  try {
    if (await File(path).exists())
      await bookController.openBook(
        path,
        // controller
        //     .fullPath.value,
        // 'assets/book/book.epub',
        '$id',
        cfi: locations['cfi'],
        created: data['created'],
        href: data['href'],
      );
  } catch (e) {
    snackBar(e);
  }
}

listTile({text, icon, onTap}) => InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            imageAsset(icon, height: 20, width: 20, fit: BoxFit.contain),
            hGap(12.0),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            )
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );

profileHeader(loginController, homeController) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Column(
            children: [
              text('Username'.tr, isBold: true),
              text(loginController.myAccountModel?.email ?? '')
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
      ),
    );
