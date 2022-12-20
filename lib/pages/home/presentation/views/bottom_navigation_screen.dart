import 'package:swift_care/pages/authentication/presentation/views/profile_screen.dart';
import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'package:swift_care/pages/home/presentation/views/book_tab.dart';
import 'package:swift_care/pages/home/presentation/views/home_tab.dart';
import 'package:swift_care/pages/home/presentation/views/settings_tab_new.dart';
import 'package:swift_care/pages/staticPages/presentation/views/notification_screen.dart';
import '../../../../components/bottom_bar_item.dart';
import '../../../../components/circle_nav_bar.dart';
import '../../../../export.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  var ctrl = Get.put(BottomNavigationController());
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(
      init: BottomNavigationController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            return controller.onWillPop();
          },
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              extendBody: true,
              body: Container(
                height: Get.height,
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: controller.tabController,
                          children: [
                            HomeTab(),
                            ProfileScreen(),
                            BookTab(),
                            NotificationScreen(),
                            SettingsTabNew(),
                          ]),
                    ),
                    // _tabBar2(controller),
                  ],
                ),
              ),
              bottomNavigationBar: Directionality(
                textDirection: TextDirection.ltr,
                child: CircleNavBar(
                  activeIcons: [
                    BottomBarItemWidget(
                      title: STRING_Home.tr,
                      imagePath: "assets/images/home_icon.svg",
                      isSelected: true,
                    ),
                    BottomBarItemWidget(
                      title: STRING_Profile.tr,
                      imagePath: "assets/images/profile_icon.svg",
                      isSelected: true,
                    ),
                    BottomBarItemWidget(
                      title: STRING_Book.tr,
                      imagePath: "assets/images/book_icon.svg",
                      isSelected: true,
                    ),
                    BottomBarItemWidget(
                      title: STRING_Notifications.tr, //'Alert',
                      imagePath: "assets/images/alert_icon.svg",
                      isSelected: true,
                    ),
                    BottomBarItemWidget(
                      title: STRING_Settings.tr,
                      imagePath: "assets/images/setting_icon.svg",
                      isSelected: true,
                    ),
                  ],
                  inactiveIcons: [
                    BottomBarItemWidget(
                      title: STRING_Home.tr,
                      imagePath: "assets/images/home_icon.svg",
                    ),
                    BottomBarItemWidget(
                      title: STRING_Profile.tr,
                      imagePath: "assets/images/profile_icon.svg",
                    ),
                    BottomBarItemWidget(
                      title: STRING_Book.tr,
                      imagePath: "assets/images/book_icon.svg",
                    ),
                    BottomBarItemWidget(
                      title: STRING_Notifications.tr, //'Alert',
                      imagePath: "assets/images/alert_icon.svg",
                    ),
                    BottomBarItemWidget(
                      title: STRING_Settings.tr,
                      imagePath: "assets/images/setting_icon.svg",
                    ),
                  ],
                  color: primaryColor,
                  height: Platform.isIOS
                      ? (62 + MediaQuery.of(context).padding.bottom)
                      : 62,
                  circleWidth: 62,
                  iconCurve: Curves.fastOutSlowIn,

                  initIndex: controller.tabController.index,
                  onChanged: (v) {
                    controller.tabController.index = v;
                    controller.updateAppBarTitle();
                  },
                  cornerRadius: BorderRadius.only(
                    topLeft: controller.tabController.index == 0
                        ? Radius.circular(0)
                        : Radius.circular(8),
                    topRight: controller.tabController.index == 4
                        ? Radius.circular(0)
                        : Radius.circular(8),
                  ),
                  // elevation: 10,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _tabBar2(BottomNavigationController controller) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5)
            ],
            color: Colors.white),
        child: TabBar(
          indicatorColor: appColor,
          indicatorWeight: 4,
          labelColor: appColor,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: controller.tabController,
          onTap: (index) {
            controller.updateAppBarTitle();
          },
          tabs: [
            Tab(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    controller.tabController.index == 0
                        ? ICON_homeSelected
                        : ICON_homeNotSelected,
                    height: 25,
                    width: 25,
                  ),
                  vGap(DIMENS_3),
                  text(
                    STRING_Home.tr,
                    fontSize: FONT_9,
                    color: controller.tabController.index == 0
                        ? appColor
                        : Colors.black,
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    ICON_book,
                    height: 25,
                    width: 25,
                    color: controller.tabController.index == 1
                        ? appColor
                        : Colors.black,
                  ),
                  vGap(DIMENS_3),
                  text(
                    STRING_Book.tr,
                    fontSize: FONT_9,
                    color: controller.tabController.index == 1
                        ? appColor
                        : Colors.black,
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    ICON_profileBottom,
                    height: 25,
                    width: 25,
                    color: controller.tabController.index == 2
                        ? appColor
                        : Colors.black,
                  ),
                  vGap(DIMENS_3),
                  text(
                    STRING_Profile.tr,
                    fontSize: FONT_9,
                    color: controller.tabController.index == 2
                        ? appColor
                        : Colors.black,
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    ICON_settingsBottom,
                    height: 25,
                    width: 25,
                    color: controller.tabController.index == 3
                        ? appColor
                        : Colors.black,
                  ),
                  vGap(DIMENS_3),
                  text(
                    STRING_Settings.tr,
                    fontSize: FONT_9,
                    color: controller.tabController.index == 3
                        ? appColor
                        : Colors.black,
                  ),
                ],
              ),
            ),
          ],
          // currentIndex: pageIndex,
        ),
      ),
    );
  }

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottombarItems() {
    return [
      bottomBarItemss(STRING_Home.tr, ICON_smalllogo,
          currentIndex == 0 ? appColor : Colors.grey),
      bottomBarItemss(STRING_Book.tr, ICON_smalllogo,
          currentIndex == 1 ? appColor : Colors.grey),
      bottomBarItemss(STRING_Profile.tr, ICON_smalllogo,
          currentIndex == 2 ? appColor : Colors.grey),
      bottomBarItemss(STRING_Settings.tr, ICON_smalllogo,
          currentIndex == 3 ? appColor : Colors.grey),
    ];
  }

  bottomBarItemss(name, iconData, Color color, {widget}) {
    return BottomNavigationBarItem(
        label: name,
        activeIcon: widget ??
            Padding(
              padding: EdgeInsets.all(2),
              child: Image.asset(
                iconData,
                height: 20,
                color: color,
              ),
            ),
        icon: widget ??
            Padding(
                padding: EdgeInsets.all(2),
                child: Image.asset(
                  iconData,
                  color: color,
                  height: 20,
                )));
  }

  _skip() {
    return Center(
      child: SizedBox(
        width: DIMENS_80,
        child: cbtnElevatedButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DIMENS_20)),
            height: DIMENS_30,
            label: STRING_skip.tr,
            backgroundColor: indigoColor),
      ),
    );
  }

  Widget _languageDrpDown() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: DIMENS_110,
        height: DIMENS_32,
        padding: EdgeInsets.only(left: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DIMENS_20),
            color: indigoColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  offset: Offset(0, 5))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            text(STRING_english.tr,
                color: Colors.white, fontWeight: FontWeight.bold),
            Icon(
              Icons.arrow_drop_down_sharp,
              color: Colors.white,
              size: DIMENS_32,
            )
          ],
        ),
      ),
    );
  }

  servicesListView() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          vGap(30),
          searchField(),
          vGap(20),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: List.generate(
                  dummyServicesList.length, (index) => serviceLayout(index)),
            ),
          ),
        ],
      ),
    );
  }

  serviceLayout(int index) {
    return Container(
      height: DIMENS_80,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: fadeBlue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
            )
          ]),
      child: Row(
        children: [
          Container(
              height: DIMENS_80,
              width: DIMENS_60,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageAsset(dummyServicesList[index].images,
                      fit: BoxFit.cover))),
          hGap(20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(dummyServicesList[index].title, isBold: true),
                vGap(10),
                text(dummyServicesList[index].desc,
                    maxLines: 2, fontSize: FONT_12, color: Colors.black54)
              ],
            ),
          )
        ],
      ),
    );
  }

  searchField() {
    return Container(
        height: DIMENS_45,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
              )
            ]),
        child: TextFormField(
          cursorColor: appColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 18),
            hintText: STRING_Search.tr,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ));
  }

  List<DummyServcies> dummyServicesList = [
    DummyServcies(
        title: 'Ambulance Transportation',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Nurse Hiring',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Home Care Services',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Ambulance Transportation',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Nurse Hiring',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Home Care Services',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Ambulance Transportation',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Nurse Hiring',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Home Care Services',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Ambulance Transportation',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Nurse Hiring',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
    DummyServcies(
        title: 'Home Care Services',
        images: ICON_smalllogo,
        desc:
            'Prepare patients for examinations and perform routine diagnostic checks....'),
  ];
}

class DummyServcies {
  String images, title, desc;

  DummyServcies(
      {required this.title, required this.images, required this.desc});
}
