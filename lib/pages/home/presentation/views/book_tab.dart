import 'package:swift_care/components/custom_divider.dart';
import 'package:swift_care/components/custom_tab_bar.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/title_subtitle_widgets.dart';
import 'package:swift_care/model/data_model/booking_model.dart';
import 'package:swift_care/pages/bookings/presentation/controller/book_tab_controller.dart';

import '../../../../components/custom_tabbar_indicator.dart';
import '../../../../export.dart';
import '../../../../service/remote_service/network/endpoint.dart';
import '../../../bookings/presentation/controller/booking_info_controller.dart';

class BookTab extends StatefulWidget {
  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> with SingleTickerProviderStateMixin {
  final formGlobalKey = GlobalKey<FormState>();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookTabController>(
      init: BookTabController(),
      builder: (controller) {
        return Scaffold(
          appBar: DefaultAppBar(
            title: STRING_MyBookings.tr,
            showBackButton: false,
          ),
          body: Column(
            children: [
              vGap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: hMargin),
                child: CustomTabBar(
                    titles: [
                      STRING_Current.tr,
                      STRING_Past.tr,
                    ],
                    onPressed: (index) {
                      _tabController.index = index;
                      controller.updateViewCurrentBooking(index == 0);
                      controller.bookingListHitApi(
                          index == 0 ? BOOKING_CURRENT : BOOKING_PAST);
                    },
                    selectedIndex: _tabController.index),
              ),
              // CustomAppBarBottomWidget(
              //   child: BottomTabBarWidget(
              //     tabController: _tabController,
              //   ),
              // ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      height: Get.height,
                      child: Column(
                        children: [
                          // vGap(30),
                          // _currentPastBtns(controller),
                          // vGap(30),
                          _servicesListView(controller),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height,
                      child: Column(
                        children: [
                          // vGap(30),
                          // _currentPastBtns(controller),
                          // vGap(30),
                          _servicesListView(controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _servicesListView(BookTabController controller) {
    return Expanded(
      child: controller.bookingList!.isNotEmpty
          ? ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.bookingList!.length,
              itemBuilder: (context, index) {
                // var data = dummyBookingModelData;
                var data = controller.bookingList?[index];

                return _serviceLayout(index, controller, data);
              },
            )
          : Center(child: text(STRING_NoBookings.tr)),
    );
  }

  _serviceLayout(
      int index, BookTabController controller, BookingModelData? bookingList) {
    return InkWell(
      onTap: () {
        var ctrl = Get.put(BookInfoController());
        ctrl.hitGetUserProfileAPI(bookingList?.id ?? 0);
      },
      child: Container(
        // height: DIMENS_140,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ]),
        child: Column(
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(8),
            //       topRight: Radius.circular(8),
            //     ),
            //     color: primaryColor,
            //   ),
            //   padding: EdgeInsets.symmetric(
            //     vertical: 10,
            //     horizontal: 19,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         '${STRING_BookingId.tr}',
            //         style: Theme.of(context).textTheme.headline5!.copyWith(
            //               color: COLOR_white,
            //               fontWeight: FontWeight.w500,
            //             ),
            //       ),
            //       Text(
            //         '${bookingList?.uniqueId ?? 0}',
            //         style: Theme.of(context).textTheme.headline5!.copyWith(
            //               color: COLOR_white,
            //               fontWeight: FontWeight.w500,
            //             ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 10,
                top: 10,
                // right: 15,
                // bottom: 7,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: DIMENS_80,
                        width: DIMENS_80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageNetwork(
                                (bookingList?.services?.length ?? 0) <= 0
                                    ? ''
                                    : '$imageUrl${bookingList?.services?[0].providerImage}',
                                fit: BoxFit.fill)),
                      ),
                      hGap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vGap(10),
                            Text(
                              ((bookingList?.services?.length ?? 0) <= 0
                                  ? ''
                                  : bookingList?.services?[0].providerName ??
                                      ""),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            CustomDivider(),
                            SizedBox(
                              height: 6,
                            ),
                            TitleSubtitleRichText(
                              title: '${STRING_BookingId.tr} ',
                              subtitle: '${bookingList?.uniqueId ?? 0}',
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            CustomDivider(),
                            SizedBox(
                              height: 6,
                            ),
                            TitleSubtitleRichText(
                              title: '${STRING_price.tr}: ',
                              subtitle:
                                  '${STRING_CURRENCY.tr} ${bookingList?.price ?? 0}',
                              isPrimaryColor: true,
                            ),
                            // RatingBar(
                            //   itemSize: 16,
                            //   initialRating:
                            //       (bookingList?.services?.length ?? 0) <= 0
                            //           ? 0.0
                            //           : double.tryParse(bookingList
                            //                       ?.services?[0].providerRating ??
                            //                   '0') ??
                            //               0.0,
                            //   onRatingUpdate: (val) {},
                            //   ratingWidget: RatingWidget(
                            //     full: Icon(
                            //       Icons.star_rounded,
                            //       color: primaryColor,
                            //       size: 8,
                            //     ),
                            //     half: Icon(
                            //       Icons.star_rounded,
                            //       color: primaryColor,
                            //       size: 8,
                            //     ),
                            //     empty: Icon(
                            //       Icons.star_rounded,
                            //       color: COLOR_lightGray,
                            //       size: 8,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 9,
                            // ),
                            // Text(
                            //   (bookingList?.services?.length ?? 0) <= 0
                            //       ? '0.0 ${STRING_Reviews.tr}'
                            //       : '${bookingList?.services?[0].providerRating ?? 0.0} ${STRING_Reviews.tr}',
                            //   style: Theme.of(context).textTheme.bodyText1,
                            // ),
                            // text(
                            //     '${STRING_ItemPrice.tr} ${STRING_CURRENCY.tr} ${bookingList?.finalPrice ?? 0}',
                            //     isBold: true,
                            //     color: Colors.grey.shade600,
                            //     fontSize: FONT_13),
                            // vGap(40),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          var ctrl = Get.put(BookInfoController());
                          ctrl.hitGetUserProfileAPI(bookingList?.id ?? 0);
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            bottom: 10,
                            end: 15,
                          ),
                          child: Text(
                            controller.viewCurrentBooking == true
                                ? STRING_ViewDetail.tr
                                : '',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 7,
                  // ),
                  // Container(
                  //   height: 1,
                  //   width: double.infinity,
                  //   color: primaryColor,
                  // ),
                  // const SizedBox(
                  //   height: 7,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       '${STRING_ItemPrice.tr} ${STRING_CURRENCY.tr} ${bookingList?.finalPrice ?? 0}',
                  //       style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  //             color: primaryColor,
                  //             fontWeight: FontWeight.w700,
                  //           ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _currentPastBtns(BookTabController controller) {
    return GetBuilder<BookTabController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.updateViewCurrentBooking(true);
                  controller.bookingListHitApi(BOOKING_CURRENT);
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: controller.viewCurrentBooking == true
                          ? appColor
                          : fadeBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: text(STRING_Current.tr,
                      color: controller.viewCurrentBooking == true
                          ? Colors.white
                          : Colors.grey,
                      isBold: true,
                      fontSize: FONT_16),
                ),
              ),
            ),
            hGap(20),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.updateViewCurrentBooking(false);
                  controller.bookingListHitApi(BOOKING_PAST);
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: controller.viewCurrentBooking == true
                          ? fadeBlue
                          : appColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: text(STRING_Past.tr,
                      color: controller.viewCurrentBooking == true
                          ? Colors.grey
                          : Colors.white,
                      isBold: true,
                      fontSize: FONT_16),
                ),
              ),
            ),
          ],
        ),
      );
    });
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
}

class BottomTabBarWidget extends StatelessWidget {
  const BottomTabBarWidget({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicator:
              CustomTabIndicator(color: primaryColor, indicatorHeight: 6),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: [
            Tab(
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  STRING_Current.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: _tabController.index == 0
                          ? primaryColor
                          : Theme.of(context).primaryColorDark),
                ),
              ),
            ),
            Tab(
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  STRING_Past.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: _tabController.index == 1
                          ? primaryColor
                          : Theme.of(context).primaryColorDark),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          width: Get.width,
          color: primaryColor,
        )
      ],
    );
  }
}
