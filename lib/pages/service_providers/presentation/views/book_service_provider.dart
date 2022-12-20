import 'package:flutter_svg/svg.dart';
import 'package:swift_care/components/custom_divider.dart';
import 'package:swift_care/components/custom_tab_bar.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/profile_widget.dart';
import 'package:swift_care/components/title_subtitle_widgets.dart';
import 'package:swift_care/model/data_model/category_data_model.dart';
import 'package:swift_care/model/responseModal/slot_data_model.dart';

import 'package:swift_care/pages/cart/presentation/cart_screen.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import 'package:swift_care/service/remote_service/network/endpoint.dart';

import '../../../../export.dart';
import '../../../cart/presentation/controller/cart_controller.dart';
import 'book_now_screen.dart';

class BookServiceProvider extends StatelessWidget {
  int? id;

  BookServiceProvider(this.id);

  BookServiceProviderController bookServiceProviderController =
      Get.put(BookServiceProviderController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceProviderController>(initState: (state) {
      bookServiceProviderController.hitGetUserProfileAPI(id);
      bookServiceProviderController.servicesListHitApi(id ?? 0);
    }, builder: (controller) {
      return SafeArea(
        child: Scaffold(
          appBar: DefaultAppBar(title: STRING_bookServiceProvider.tr, actions: [
            Center(
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      var ctrl = Get.put(CartController());
                      ctrl.queryAll();
                      Get.to(CartScreen(ctrl.providerId));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        'assets/icons/cart.svg',
                        height: DIMENS_22,
                        width: DIMENS_22,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  controller.count == 0
                      ? Container()
                      : Positioned(
                          right: 0,
                          top: 5,
                          child: Container(
                            height: 21.0,
                            width: 21.0,
                            decoration: BoxDecoration(
                                color: buttonColor,
                                border: Border.all(
                                    color: Theme.of(context).cardColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Center(
                              child: Text(
                                controller.count > 9
                                    ? '9+'
                                    : '${controller.count}',
                                style: textStyle(color: Colors.white),
                              ),
                            ),
                          )),
                ],
              ),
            )
          ]),
          body: sliverView(controller),
        ),
      );
    });
  }

  sliverView(BookServiceProviderController controller) {
    // return GetBuilder<LoginController>(builder: (controller) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ProfileWidgetWithRatingCount(
              imageUrl: imageUrl,
              name: controller.model?.detail?.fullName ?? '',
              ratingCount: controller.model?.detail?.providerRating != null
                  ? double.parse(controller.model?.detail?.providerRating)
                  : 0.0,
              reviewsCount:
                  '${controller.model?.detail?.providerRatingCount ?? "0.0"} ${STRING_Reviews.tr}',
            ),
            // Column(
            //   children: [
            //     vGap(16),
            //     userImage(controller),
            //     vGap(DIMENS_10),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       child: text(controller.model?.detail?.fullName ?? "",
            //           fontSize: FONT_18, fontWeight: FontWeight.w600),
            //     ),
            //     vGap(DIMENS_5),
            //     vGap(DIMENS_5),
            //     Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10),
            //         child: RatingBarIndicator(
            //           rating: controller.model?.detail?.providerRating != null
            //               ? double.parse(
            //                   controller.model?.detail?.providerRating)
            //               : 0.0,
            //           itemSize: 20.0,
            //           itemBuilder: (BuildContext context, int index) {
            //             return Icon(
            //               Icons.star,
            //               color: Colors.yellow,
            //             );
            //           },
            //         )),
            //     vGap(DIMENS_10),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       child: text(
            //           '(${controller.model?.detail?.providerRatingCount ?? "0.0"} ${STRING_Reviews.tr})',
            //           color: Colors.blueGrey,
            //           fontSize: FONT_12),
            //     ),
            //     vGap(DIMENS_10),
            //     divider(),
            //   ],
            // ),
            childCount: 1,
          ), //SliverChildBuildDelegate
        ),
        SliverAppBar(
          snap: false,
          pinned: true,
          floating: false,
          elevation: 0,
          leading: Container(),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.zero,
            title: _tabs(controller),
          ),
          backgroundColor: Colors.transparent,
          expandedHeight: 56,
          collapsedHeight: 56,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (controller.currentTabIndex == 0) {
                return _personalInfo(controller, context);
              } else if (controller.currentTabIndex == 1) {
                return _services(controller, context);
              } else {
                return _availability(controller);
              }
            },
            childCount: 1,
          ), //SliverChildBuildDelegate
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
          ),
        )
      ],
    );
    //   }
    // );
  }

  _tabs(BookServiceProviderController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hMargin),
      child: CustomTabBar(
        horizontalPadding: 10,
        titles: [
          STRING_personalInfo.tr,
          STRING_services.tr,
          STRING_availability.tr,
        ],
        onPressed: (val) {
          controller.updateCurrentTabIndex(val);
          if (val == 0) {
          } else if (val == 1) {
            controller.providerId = controller.model?.detail?.id! ?? 0;
            controller.servicesListHitApi(controller.model?.detail?.id! ?? 0);
          } else {
            controller.availabilityListHitApi(id ?? 0);
          }
        },
        selectedIndex: controller.currentTabIndex,
      ),
    );
    // Container(
    //   height: 200,
    //   width: Get.width,
    //   color: Colors.white,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       InkWell(
    //         onTap: () {
    //           controller.updateCurrentTabIndex(0);
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    //           child: text(STRING_personalInfo.tr,
    //               color: controller.currentTabIndex == 0
    //                   ? indigoColor
    //                   : Colors.grey,
    //               fontSize: FONT_18,
    //               fontWeight: FontWeight.w600),
    //         ),
    //       ),
    //       Container(
    //         color: Colors.grey.shade400,
    //         height: DIMENS_20,
    //         width: 2,
    //       ),
    //       InkWell(
    //         onTap: () {
    //           controller.updateCurrentTabIndex(1);
    //           controller.providerId = controller.model?.detail?.id! ?? 0;
    //           controller.servicesListHitApi(controller.model?.detail?.id! ?? 0);
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    //           child: text(STRING_services.tr,
    //               color: controller.currentTabIndex == 1
    //                   ? indigoColor
    //                   : Colors.grey,
    //               fontSize: FONT_18,
    //               fontWeight: FontWeight.w600),
    //         ),
    //       ),
    //       Container(
    //         color: Colors.grey.shade400,
    //         height: DIMENS_20,
    //         width: 2,
    //       ),
    //       InkWell(
    //         onTap: () {
    //           controller.updateCurrentTabIndex(2);
    //           controller.availabilityListHitApi(id ?? 0);
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    //           child: text(STRING_availability.tr,
    //               color: controller.currentTabIndex == 2
    //                   ? indigoColor
    //                   : Colors.grey,
    //               fontSize: FONT_18,
    //               fontWeight: FontWeight.w600),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  userImage(BookServiceProviderController controller) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: imageNetwork('$imageUrl${controller.model?.detail?.profileFile}',
            isMember: true, width: 60.0, height: 60.0, fit: BoxFit.cover),
      ),
    );
  }

  divider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 5,
    );
  }

/*  _tabView() {
    return PageView(
      children: [_personalInfo(), _services(), _availability()],
    );
  }*/

  Widget _personalInfo(
      BookServiceProviderController controller, BuildContext context) {
    return Container(
      decoration: cardDecoration.copyWith(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: hMargin,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          // divider(),
          TitleSubtitleVerticalWidget(
            title: STRING_email.tr,
            subtitle: controller.model?.detail?.email ?? "",
            isButtonColor: true,
          ),
          TitleSubtitleVerticalWidget(
            title: STRING_phoneNo.tr,
            subtitle: controller.model?.detail?.contactNo ?? "",
            isButtonColor: true,
          ),
          TitleSubtitleVerticalWidget(
            title: STRING_location.tr,
            subtitle: controller.model?.detail?.userAddress?.houseNo ?? "",
            isButtonColor: true,
          ),
          TitleSubtitleVerticalWidget(
            title: STRING_nationality.tr,
            subtitle:
                controller.model?.detail?.userDetail?.nationalityTitle ?? "",
            isButtonColor: true,
          ),
          ListTile(
            title: Text(
              STRING_certifications.tr,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            subtitle: _certificateFieldLayout(controller),
          ),
        ],
      ),
    );
  }

  _fieldLayout({title, subtitle}) {
    return ListTile(
      title: text(title ?? '', fontWeight: FontWeight.w500),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: text(subtitle ?? '',
            color: indigoColor, fontWeight: FontWeight.w500),
      ),
    );
  }

  _certificateFieldLayout(BookServiceProviderController controller) {
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: controller.model?.detail?.certificates?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(top: 10, right: 10),
            height: DIMENS_80,
            width: DIMENS_80,
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                controller.showImageDailog(
                    url: controller.model?.detail?.certificates![index].key,
                    context: context);
              },
              child: imageNetwork(
                  "$imageUrl${controller.model?.detail?.certificates![index].key} ",
                  fit: BoxFit.contain),
            ),
          );
        },
      ),
    );
  }

  Widget _services(
      BookServiceProviderController controller, BuildContext context) {
    return Container(
      decoration: cardDecoration.copyWith(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: hMargin,
      ),
      child: ListView.separated(
        controller: controller.serviceScrollController,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            _serviceLayout(controller, controller.serviceList[index], context),
        separatorBuilder: (context, index) => Container(
          height: 10,
          color: lLightGreyColor,
        ),
        itemCount: controller.serviceList.length,
      ),
    );
  }

  Widget _availability(BookServiceProviderController controller) {
    return Container(
      decoration: cardDecoration.copyWith(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: hMargin,
      ),
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var item = controller.availabilityList[index];
            return _availabilityLayout(controller, index, context, item);
          },
          separatorBuilder: (context, index) => Container(
                height: 10,
                color: lLightGreyColor,
              ),
          itemCount: controller.availabilityList.length),
    );
  }

  _serviceLayout(BookServiceProviderController controller,
      CategoryData categoryData, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 5,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  (categoryData.subCategoryName ?? ""),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.visible,
                      ),
                ),
                // TitleSubtitleRichText(
                //   title: (categoryData.subCategoryName ?? "") * 3,
                //   fontSize: FONT_14,
                //   subtitle: '',
                //   showSecondText: false,
                // ),
              ),
              // Spacer(),
              TitleSubtitleRichText(
                title: '${STRING_price.tr}: ',
                fontSize: FONT_14,
                subtitle: '${STRING_CURRENCY.tr} ${categoryData.price ?? 0}',
              )
            ],
          ),
        ),
        CustomDivider(),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            top: 7,
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleSubtitleRichText(
                title: '${STRING_gender.tr}: ',
                fontSize: FONT_14,
                subtitle: '${controller.updateGender(categoryData.gender)}',
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    BookNowScreen(
                        id: id ?? 0,
                        serviceList: categoryData,
                        subId: categoryData.id),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: buttonColor,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 2,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/add.svg',
                        height: 11,
                        width: 11,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        STRING_ADD.tr,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).cardColor,
                            ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
    // Container(
    //   height: DIMENS_90,
    //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         flex: 2,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             text(categoryData.subCategoryName ?? "",
    //                 fontSize: FONT_16, maxLines: 2),
    //             vGap(DIMENS_15),
    //             Row(
    //               children: [
    //                 Expanded(
    //                     child: text(
    //                         '${STRING_gender.tr}: ${controller.updateGender(categoryData.gender)}',
    //                         fontSize: FONT_13,
    //                         color: Colors.grey)),
    //                 Expanded(
    //                     child: text(
    //                         '${STRING_price.tr}: ${STRING_CURRENCY.tr} ${categoryData.price ?? 0}',
    //                         fontSize: FONT_13,
    //                         color: Colors.grey)),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: Align(
    //           alignment: Alignment.center,
    //           child: InkWell(
    //             onTap: () {
    //               Get.to(
    //                 BookNowScreen(
    //                     id: id ?? 0,
    //                     serviceList: categoryData,
    //                     subId: categoryData.id),
    //               );
    //             },
    //             child: Container(
    //               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    //               decoration: BoxDecoration(
    //                   color: COLOR_middleblues,
    //                   borderRadius: BorderRadius.circular(10)),
    //               child: text(STRING_ADD.tr, color: Colors.white, fontSize: 14),
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _availabilityLayout(BookServiceProviderController controller,
      int index, BuildContext context, SlotDataModel item) {
    controller.getDayName(item.dayId ?? 0);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 5,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.dayName ?? "",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: buttonColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        CustomDivider(),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            top: 7,
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleSubtitleRichText(
                title: '${STRING_StartTime.tr}: ',
                fontSize: FONT_14,
                subtitle: '${controller.timeFormat(item.startTime)}',
                isLtr: true,
              ),
              TitleSubtitleRichText(
                title: '${STRING_EndTime.tr}: ',
                fontSize: FONT_14,
                subtitle: '${controller.timeFormat(item.endTime)}',
                isLtr: true,
              ),
            ],
          ),
        ),
      ],
    );
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //   child: Container(
    //     height: DIMENS_70,
    //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         Expanded(
    //           child: text(controller.dayName ?? "",
    //               fontSize: FONT_16, maxLines: 2),
    //         ),
    //         Expanded(
    //           child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Directionality(
    //                   textDirection: TextDirection.ltr,
    //                   child: text(
    //                       '${STRING_StartTime.tr}: ${controller.timeFormat(item.startTime)}  ',
    //                       fontSize: FONT_14,
    //                       color: Color(0xff6b8098)),
    //                 ),
    //                 hGap(3),
    //                 Directionality(
    //                     textDirection: TextDirection.ltr,
    //                     child: text(
    //                         '${STRING_EndTime.tr}: ${controller.timeFormat(item.endTime)}',
    //                         fontSize: FONT_14,
    //                         color: Color(0xff6b8098)))
    //               ]),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget doubleText(topText, bottomText) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(topText, maxLines: 1, fontSize: 16),
          vGap(4),
          text(bottomText,
              color: Colors.black, isBold: true, fontSize: 16, maxLines: 1),
        ],
      );
}
