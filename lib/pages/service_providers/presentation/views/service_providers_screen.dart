import 'package:swift_care/components/custom_divider.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/primary_buttons.dart';
import 'package:swift_care/components/title_subtitle_widgets.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import 'package:swift_care/pages/service_providers/presentation/views/book_now_screen.dart';
import 'package:swift_care/service/remote_service/network/endpoint.dart';
import 'package:swift_care/utils/projectutils/extensions.dart';

import '../../../../export.dart';
import '../../../../model/data_model/service_provider_model.dart';
import 'book_service_provider.dart';
import 'filter_screen.dart';

class ServiceProviders extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();
  var categoryId;
  var id;

  ServiceProviders({this.categoryId, this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceProviderController>(
        init: BookServiceProviderController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                appBar:
                    DefaultAppBar(title: STRING_serviceProviders.tr, actions: [InkWell(
                    onTap: () async {
                      FilterModel filterModel =
                          await Get.to(FilterScreen(categoryId ?? 0, id ?? 0));

                      controller.getLocation(
                          categoryId: categoryId, id: id, model: filterModel);
                    },
                    child: Padding(
                        padding: const EdgeInsetsDirectional.only(),
                        child: Icon(
                          Icons.filter_alt_rounded,
                          color: buttonColor,
                        )
                        // SvgPicture.asset(
                        //   'assets/icons/sort.svg',
                        //   height: DIMENS_20,
                        //   width: DIMENS_20,
                        //   fit: BoxFit.contain,
                        // ),
                        ),
                  ),
                ]),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: Get.height,
                    child: controller.providerList.isNotEmpty
                        ? _servicesListView(controller)
                        : Center(child: text(STRING_NO_PROVIDER.tr)),
                  ),
                )),
          );
        });
  }

  _servicesListView(BookServiceProviderController controller) {
    return ListView(
      controller: controller.providerScrollController,
      shrinkWrap: true,
      children: List.generate(
        controller.providerList.length,
        (index) => ServiceProviderWidget(
          controller: controller,
          item: controller.providerList[index],
        ),
      ),
    );
  }

  _serviceLayout(int index, BookServiceProviderController controller) {
    var item = controller.providerList[index];
    return InkWell(
      onTap: () {
        var cotroller = Get.put(BookServiceProviderController());
        cotroller.updateCurrentTabIndex(0);
        Get.to(
          BookServiceProvider(item.id),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: fadeBlue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ]),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: DIMENS_80,
                    width: DIMENS_80,
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl +
                              controller.providerList[index].profileFile!,
                          fit: BoxFit.cover,
                          errorBuilder: imageErrorBuilder(false),
                        ))),
                hGap(10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: text(
                                controller.providerList[index].fullName ?? "",
                                fontWeight: FontWeight.w600,
                                fontSize: FONT_16),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                                color: appColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 3,
                                      offset: Offset(0, 2))
                                ]),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                text(
                                    '${controller.providerList[index].providerRating ?? "0.0"}',
                                    color: Colors.white,
                                    fontSize: 12),
                              ],
                            ),
                          )
                        ],
                      ),
                      vGap(5),
                      text(
                          '${STRING_PerHour.tr} ${STRING_CURRENCY.tr} ${controller.providerList[index].service?.price ?? 0}',
                          isBold: true,
                          color: Colors.grey.shade600,
                          fontSize: FONT_13),
                      vGap(5),
                      SizedBox(
                        width: Get.width * 0.45,
                        child: text(
                            '${STRING_Distance.tr} : ${controller.providerList[index].totalDistance ?? ""} Km',
                            isBold: true,
                            color: Colors.grey.shade600,
                            fontSize: FONT_13),
                      ),
                      vGap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              var cotroller =
                                  Get.put(BookServiceProviderController());
                              cotroller.updateCurrentTabIndex(1);
                              Get.to(BookServiceProvider(
                                  controller.providerList[index].id!));
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    text('$STRING_ALL_SERVICES'.tr,
                                        color: Colors.white, fontSize: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          hGap(10),
                          InkWell(
                            onTap: () {
                              Get.to(BookNowScreen(
                                id: controller.providerList[index].id,
                                serviceList:
                                    controller.providerList[index].service,
                                subId:
                                    controller.providerList[index].service?.id,
                              ));
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    text('$STRING_bookNow'.tr,
                                        color: Colors.white, fontSize: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceProviderWidget extends StatelessWidget {
  const ServiceProviderWidget(
      {Key? key, required this.item, required this.controller})
      : super(key: key);
  final ServiceProvider item;
  final BookServiceProviderController controller;
  @override
  Widget build(BuildContext context) {
    String fullName = item.fullName ?? '';
    return InkWell(
      onTap: () {
        var cotroller = Get.put(BookServiceProviderController());
        cotroller.updateCurrentTabIndex(0);
        Get.to(
          BookServiceProvider(item.id),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            Container(
              // height: DIMENS_150,
              padding: EdgeInsets.symmetric(vertical: 25),
              decoration: cardDecoration,

              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: DIMENS_90,
                        width: DIMENS_90,
                        margin: EdgeInsetsDirectional.only(
                          start: 10,
                        ),
                        decoration: BoxDecoration(
                          color: lScaffoldColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: circleImageNetWork(
                            imageurl: imageUrl + item.profileFile,
                          ),
                        ),
                      ),
                      hGap(10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  fullName.limitToSpecificLength(20),
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: buttonColor,
                                      ),
                                ),
                                hGap(7),
                              ],
                            ),
                            vGap(5),
                            CustomDivider(),
                            vGap(5),
                            TitleSubtitleRichText(
                              title: '${STRING_PerHour.tr} ',
                              subtitle:
                                  '${STRING_CURRENCY.tr} ${item.service?.price ?? 0}',
                              isPrimaryColor: true,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Text(
                            //           '${STRING_PerHour.tr}',
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyText1!
                            //               .copyWith(
                            //                 fontWeight: FontWeight.w500,
                            //               ),
                            //         ),
                            //         Text(
                            //           '${item.service?.price ?? 0}',
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyText1!
                            //               .copyWith(
                            //                 fontWeight: FontWeight.w500,
                            //                 color: lTextColorLight,
                            //               ),
                            //         ),
                            //       ],
                            //     ),

                            //     // hGap(margin_7),
                            //   ],
                            // ),
                            // text(
                            //     '${keyExperienceWith.tr} ${staff.userDetail?.experience ?? ""}',
                            //     isBold: true,
                            //     color: Colors.grey.shade600,
                            //     fontSize: FONT_14),
                            vGap(5),
                            CustomDivider(),
                            vGap(5),
                            TitleSubtitleRichText(
                              title: '${STRING_Distance.tr}: ',
                              subtitle: '${item.totalDistance ?? ""} km',
                            ),
                            // Flexible(
                            //   child: Padding(
                            //       padding:
                            //           const EdgeInsetsDirectional.only(end: 8.0),
                            //       child: Text(
                            //         aboutMe.limitToSpecificLength(40),
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .bodyText1!
                            //             .copyWith(
                            //               color: COLOR_LightTextColor,
                            //             ),
                            //       )),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            var cotroller =
                                Get.put(BookServiceProviderController());
                            cotroller.updateCurrentTabIndex(1);
                            Get.to(BookServiceProvider(item.id!));
                          },
                          child: Text(
                            STRING_ALL_SERVICES.tr,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: buttonColor,
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CircularPrimaryButton(
                            text: '$STRING_bookNow'.tr,
                            horizontalPadding: 36,
                            onPressed: () {
                              Get.to(BookNowScreen(
                                id: item.id,
                                serviceList: item.service,
                                subId: item.service?.id,
                              ));
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 10,
              end: 10,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: buttonColor,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${item.providerRating ?? '0.0'}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: buttonColor,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
