import 'dart:developer' as Log;

import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/heading_widgets.dart';
import 'package:swift_care/components/primary_buttons.dart';
import 'package:swift_care/components/service_provider_widget.dart';
import 'package:swift_care/components/title_subtitle_widgets.dart';
import 'package:swift_care/model/data_model/booking_detail_model.dart';
import 'package:swift_care/pages/bookings/presentation/controller/book_tab_controller.dart';

import '../../../../export.dart';
import '../../../components/custom_divider.dart';
import '../../../service/remote_service/network/endpoint.dart';

import '../../service_providers/presentation/views/tracking_screen.dart';
import 'controller/booking_info_controller.dart';

class BookingInfoScreen extends StatelessWidget {
  final BookTabController cotroller = Get.put(BookTabController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookInfoController>(
        init: BookInfoController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                appBar: DefaultAppBar(
                  title:
                      '${STRING_BookingId.tr} ${controller.dataModel?.detail?.uniqueId ?? 0}',
                ),
                body: Container(
                  height: Get.height,
                  child: _body(controller, context),
                )),
          );
        });
  }

  Widget _body(
    BookInfoController controller,
    BuildContext context,
  ) {
    Log.log(controller.dataModel!.toJson().toString());
    return SingleChildScrollView(
      child: Column(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vGap(DIMENS_20),
              TitleHeadingWidget(
                title: '$STRING_serviceProvider'.tr,
              ),
              vGap(DIMENS_20),
              ServiceProviderWidget(
                bookingDetailModel: controller.dataModel,
                bookingListModel: controller.model,
              ),
              vGap(DIMENS_30),
              TitleHeadingWidget(
                title: STRING_BookedServices.tr,
              ),
              _servicesListView(controller),
              vGap(DIMENS_30),
              Container(
                decoration: cardDecoration.copyWith(
                  color: lLightGreyColor,
                  boxShadow: [],
                ),
                margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: 15),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  color: lDropDownColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      TitleRounderContainer(text: STRING_Invoice.tr),
                      TitleSubtitleHorizontalWidget(
                        title: STRING_SubTotal.tr,
                        subtitle:
                            '${STRING_CURRENCY.tr} ${controller.dataModel?.detail?.price}',
                        // currency: STRING_CURRENCY.tr,
                        isLtr: true,
                      ),
                      TitleSubtitleHorizontalWidget(
                        title: STRING_VAT.tr,
                        subtitle:
                            '${STRING_CURRENCY.tr} ${controller.dataModel?.detail?.taxPrice}',
                        // currency: STRING_CURRENCY.tr,
                        isLtr: true,
                      ),
                      TitleSubtitleHorizontalWidget(
                        title: STRING_TotalPrice.tr,
                        subtitle:
                            '${STRING_CURRENCY.tr} ${controller.dataModel?.detail?.finalPrice}',
                        // currency: STRING_CURRENCY.tr,
                        isLtr: true,
                        showDivider: false,
                      ),
                      vGap(20)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: controller.dataModel?.detail?.stateId != 1 ||
                  controller.dataModel?.detail?.paymentStatus != 0
              ? false
              : true,
          child: Align(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: hMargin,
                    right: hMargin,
                    bottom: hMargin,
                  ),
                  child: PrimaryButton(
                    onPressed: () {
                      controller.dialog(
                          context,
                          controller.dataModel?.detail?.id ?? 0,
                          controller.dataModel?.detail?.finalPrice);
                    },
                    buttonText: STRING_PayNow.tr,
                  ),
                ),
                Visibility(
                    visible: Platform.isIOS ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: hMargin, right: hMargin, bottom: hMargin),
                      child: PrimaryButton(
                        buttonText: STRING_Applepay.tr,
                        isBlackColor: true,
                        onPressed: () {
                          controller.appleDialog(
                            context,
                            controller.dataModel?.detail?.id ?? 0,
                            controller.dataModel?.detail?.finalPrice,
                          );
                        },
                      ),
                    )),
              ],
            ),
          ),
        )
      ]),
    );
  }

  _servicesListView(BookInfoController bookInfoController) {
    return bookInfoController.dataModel!.detail?.services?.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: bookInfoController.dataModel!.detail?.services?.length,
            itemBuilder: (context, index) {
              var data = bookInfoController.dataModel!.detail?.services?[index];
              var bookingId = bookInfoController.dataModel!.detail?.id;
              return BookedServiceWidget(
                index: index,
                controller: cotroller,
                data: data,
                bookingId: bookingId,
                bookInfoController: bookInfoController,
              );
            },
          )
        : Center(child: text(STRING_NoBookings.tr));
  }

  _booking(BookInfoController controller) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.all(DIMENS_15),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(DIMENS_10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DIMENS_10),
            child: ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              title: text(
                  '${STRING_SubTotal.tr} ${STRING_CURRENCY.tr} ${controller.dataModel?.detail?.price}',
                  color: indigoBlackColor,
                  fontWeight: FontWeight.w500),
              subtitle: text(
                  '${STRING_VAT.tr} ${STRING_CURRENCY.tr}  ${controller.dataModel?.detail?.taxPrice}',
                  color: indigoBlackColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            height: 10,
            color: Colors.grey,
          ),
          vGap(DIMENS_5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DIMENS_10),
            child: text('$STRING_TotalPrice'.tr,
                color: indigoBlackColor, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DIMENS_10),
            child: ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: imageAsset(ICON_priceTag, height: DIMENS_20),
              title: text(
                  '$STRING_CURRENCY ${controller.dataModel?.detail?.finalPrice} ',
                  color: indigoBlackColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class BookedServiceWidget extends StatelessWidget {
  const BookedServiceWidget({
    Key? key,
    required this.index,
    required this.controller,
    this.data,
    required this.bookingId,
    required this.bookInfoController,
  }) : super(key: key);
  final int index;
  final BookTabController controller;
  final BookInfoController bookInfoController;
  final Services? data;
  final int? bookingId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: hMargin, end: hMargin, top: 15),
      decoration: cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    start: DIMENS_10, top: 10, bottom: 20),
                margin: EdgeInsetsDirectional.only(start: hMargin),
                child: Column(
                  children: [
                    Visibility(
                      visible: data?.bookingType == 1 ? true : false,
                      child: text('${STRING_Subscription.tr}',
                          color: Colors.green,
                          fontSize: FONT_13,
                          fontWeight: FontWeight.w500),
                    ),
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
                                '$imageUrl${data?.serviceImage ?? ""}',
                                fit: BoxFit.cover),
                          ),
                        ),
                        hGap(10),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${STRING_service.tr} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.visible),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${data?.serviceSubCat ?? ""}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    )
                                  ],
                                ),
                                // TitleSubtitleRichText(
                                //   title: '${STRING_service.tr} ',
                                //   subtitle: '${data?.serviceSubCat ?? ""}' * 3,
                                //   isPrimaryColor: true,
                                // ),
                                SizedBox(
                                  height: 6,
                                ),
                                CustomDivider(),
                                if (data?.assignPerson?.fullName != null)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                        child: Visibility(
                                          visible:
                                              data?.assignPerson?.fullName ==
                                                      null
                                                  ? false
                                                  : true,
                                          child: TitleSubtitleRichText(
                                            title:
                                                '${STRING_AssignedPerson.tr}',
                                            subtitle:
                                                '${data?.assignPerson?.fullName ?? ""}',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      CustomDivider(),
                                    ],
                                  ),
                                vGap(5),
                                SizedBox(
                                  height: 6,
                                ),
                                TitleSubtitleRichText(
                                  title: '${STRING_price.tr}: ',
                                  subtitle:
                                      '${STRING_CURRENCY.tr} ${data?.price ?? 0}',
                                  isPrimaryColor: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                  end: 20,
                  top: 10,
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: buttonColor,
                          size: 12,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          data?.assignPerson?.staffRating ?? "0.0",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: buttonColor,
                                  ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          Container(
            height: 35,
            padding: EdgeInsets.only(top: 5),
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: text(STRING_BOOKSLOTt.tr,
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
          vGap(10),
          TitleSubtitleHorizontalWidget(
            title: STRING_StartDate.tr,
            subtitle: '${controller.dateFormat(data?.startTime)}',
            isLtr: true,
          ),
          TitleSubtitleHorizontalWidget(
            title: STRING_EndDate.tr,
            subtitle: '${controller.dateFormat(data?.endTime)}',
            isLtr: false,
          ),
          TitleSubtitleHorizontalWidget(
            title: STRING_timeslot.tr,
            subtitle:
                '${controller.timeFormat(data?.startTime)} - ${controller.timeFormat(data?.endTime)}',
            isLtr: true,
            showDivider: false,
          ),
          Visibility(
            visible: data?.stateId == 5 ? true : false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text('${STRING_Track.tr} ',
                      color: indigoBlackColor, fontWeight: FontWeight.w500),
                  InkWell(
                    onTap: () {
                      Get.to(TrackingScreen(myLatLng: data));
                    },
                    child: imageAsset(ICON_address, height: DIMENS_30),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
