import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/heading_widgets.dart';
import 'package:swift_care/components/primary_buttons.dart';
import 'package:swift_care/components/title_subtitle_widgets.dart';
import 'package:swift_care/model/data_model/category_data_model.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import 'package:swift_care/pages/service_providers/presentation/views/calendar_screen.dart';

import '../../../../export.dart';
import '../../../../model/responseModal/signup_response_model.dart';
import '../../../../utils/projectutils/custom_dropdown.dart';
import '../../../cart/presentation/controller/cart_controller.dart';

class BookNowScreen extends StatelessWidget {
  final int? id;
  final int? subId;
  final CategoryData? serviceList;

  BookNowScreen({this.id, this.serviceList, this.subId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                appBar: DefaultAppBar(
                  title: STRING_bookServiceProvider.tr,
                ),
                body: Container(
                  child: _body(controller, context),
                )),
          );
        });
  }

  _body(CartController controller, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // padding: EdgeInsets.symmetric(horizontal: DIMENS_10),
            margin:
                EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
            decoration: cardDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vGap(DIMENS_20),
                Container(
                  height: 25,
                  color: lLightGreyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          activeColor: buttonColor,
                          value: controller.isSubscribed,
                          onChanged: (val) {
                            controller.isSubscribed = !controller.isSubscribed;
                            controller.difference = null;
                            controller.selectedEndDate = null;
                            controller.dbEndDate = null;
                            controller.newSelectedEndDate = null;
                            controller.slotDataModel = null;
                            controller.isStartDate = false;

                            if (val == true) {
                              controller.bookingType = 1;
                            } else {
                              controller.bookingType = 0;
                            }
                            controller.update();
                          }),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        STRING_SubscribedMember.tr,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color:
                                  controller.isSubscribed ? buttonColor : null,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
                // ListTile(
                //   minLeadingWidth: 0,
                //   leading: Checkbox(
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(2)),
                //       activeColor: indigoColor,
                //       value: controller.isSubscribed,
                //       onChanged: (val) {
                //         controller.isSubscribed = !controller.isSubscribed;
                //         controller.difference = null;
                //         controller.selectedEndDate = null;
                //         controller.dbEndDate = null;
                //         controller.newSelectedEndDate = null;
                //         controller.slotDataModel = null;
                //         controller.isStartDate = false;

                //         if (val == true) {
                //           controller.bookingType = 1;
                //         } else {
                //           controller.bookingType = 0;
                //         }
                //         controller.update();
                //       }),
                //   contentPadding: EdgeInsets.zero,
                //   title: text(STRING_SubscribedMember.tr,
                //       color: indigoColor, fontWeight: FontWeight.w500),
                // ),
                vGap(DIMENS_10),
                _startDate(controller, context),
                vGap(DIMENS_20),
                Visibility(
                  visible: controller.isSubscribed,
                  child: _endDate(controller, context),
                ),
                memberRadioButton(
                  controller,
                  context,
                ),
                // vGap(DIMENS_20),
                Visibility(
                  visible: controller.val != 1 ? true : false,
                  child: Column(
                    children: [
                      vGap(DIMENS_14),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: nationalityEditText(),
                      ),
                    ],
                  ),
                ),
                vGap(DIMENS_10),
                Visibility(
                  visible: controller.isMemberSelected,
                  child: Container(
                      margin: EdgeInsets.all(DIMENS_10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        border: Border.all(
                          color: Color(0xffe5e5e5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(DIMENS_10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/house.svg',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              '${controller.familyAddress}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            'assets/icons/map_pin.png',
                            height: 21,
                            width: 21,
                          )
                        ],
                      )
                      // ListTile(
                      //   // contentPadding: EdgeInsets.zero,
                      //   leading: Icon(
                      //     Icons.home,
                      //     color: indigoBlackColor,
                      //   ),
                      //   minLeadingWidth: 36,
                      //   title: text('${controller.familyAddress}',
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: FONT_16,
                      //       maxLines: 2),
                      //   trailing: imageAsset(
                      //     ICON_address2,
                      //     height: DIMENS_30,
                      //   ),
                      // ),
                      ),
                ),
                vGap(DIMENS_10),
                _booking(controller),
              ],
            ),
          ),
          vGap(DIMENS_20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DIMENS_30),
            child: PrimaryButton(
              onPressed: () {
                if (controller.isSubscribed == false) {
                  if (controller.cartServiceList.isNotEmpty) {
                    var listDB = controller.cartServiceList.where((element) =>
                        element.startTime ==
                        controller.slotDataModel?.startTime);
                    if (listDB.length == 0) {
                      if (controller.typeId == 0) {
                        if (controller.slotDataModel != null) {
                          controller.queryProviderSlot(
                              context,
                              controller.slotDataModel!,
                              serviceList!,
                              controller.typeId,
                              controller.itemSelectedFamily,
                              id,
                              endDate: controller.selectedEndDate != null
                                  ? controller.newDbEndDate
                                  : null,
                              price: controller.difference != null
                                  ? (int.parse(serviceList!.price!) *
                                      controller.difference)
                                  : null,
                              difference: controller.difference != null
                                  ? controller.difference
                                  : 0,
                              bookingType: controller.bookingType);

                          controller.queryProviderTap(
                              id ?? 0,
                              context,
                              serviceList!,
                              controller.slotDataModel!,
                              controller.itemSelectedFamily?.name ?? "",
                              endDate: controller.selectedEndDate != null
                                  ? controller.newDbEndDate
                                  : null,
                              price: controller.difference != null
                                  ? (int.parse(serviceList!.price!) *
                                      controller.difference)
                                  : null,
                              difference: controller.difference != null
                                  ? controller.difference
                                  : 0,
                              bookingType: controller.bookingType);

                          controller.hitPostCartApi();
                        } else {
                          snackBar(STRING_select_slot.tr);
                        }
                      } else {
                        if (controller.itemSelectedFamily?.id == null) {
                          snackBar('$STRING_SELECT_FAMILY'.tr);
                        } else {
                          controller.queryProviderSlot(
                              context,
                              controller.slotDataModel!,
                              serviceList!,
                              controller.typeId,
                              controller.itemSelectedFamily!,
                              id,
                              endDate: controller.selectedEndDate != null
                                  ? controller.newDbEndDate
                                  : null,
                              price: controller.difference != null
                                  ? (int.parse(serviceList!.price!) *
                                      controller.difference)
                                  : null,
                              difference: controller.difference != null
                                  ? controller.difference
                                  : 0,
                              bookingType: controller.bookingType);

                          controller.queryProviderTap(
                              id ?? 0,
                              context,
                              serviceList!,
                              controller.slotDataModel!,
                              controller.itemSelectedFamily!.name ?? "",
                              endDate: controller.selectedEndDate != null
                                  ? controller.newDbEndDate
                                  : null,
                              price: controller.difference != null
                                  ? (int.parse(serviceList!.price!) *
                                      controller.difference)
                                  : null,
                              difference: controller.difference != null
                                  ? controller.difference
                                  : 0,
                              bookingType: controller.bookingType);

                          controller.hitPostCartApi();
                        }
                      }
                    } else {
                      snackBar(STRING_SlotBooked.tr);
                    }
                  } else {
                    if (controller.typeId == 0) {
                      if (controller.slotDataModel != null) {
                        controller.queryProviderSlot(
                            context,
                            controller.slotDataModel!,
                            serviceList!,
                            controller.typeId,
                            controller.itemSelectedFamily,
                            id,
                            endDate: controller.selectedEndDate != null
                                ? controller.newDbEndDate
                                : null,
                            price: controller.difference != null
                                ? (int.parse(serviceList!.price!) *
                                    controller.difference)
                                : null,
                            difference: controller.difference != null
                                ? controller.difference
                                : 0,
                            bookingType: controller.bookingType);

                        controller.queryProviderTap(
                            id ?? 0,
                            context,
                            serviceList!,
                            controller.slotDataModel!,
                            controller.itemSelectedFamily?.name ?? "",
                            endDate: controller.selectedEndDate != null
                                ? controller.newDbEndDate
                                : null,
                            price: controller.difference != null
                                ? (int.parse(serviceList!.price!) *
                                    controller.difference)
                                : null,
                            difference: controller.difference != null
                                ? controller.difference
                                : 0,
                            bookingType: controller.bookingType);

                        controller.hitPostCartApi();
                      } else {
                        snackBar(STRING_select_slot.tr);
                      }
                    } else {
                      if (controller.itemSelectedFamily?.id == null) {
                        snackBar('$STRING_SELECT_FAMILY'.tr);
                      } else {
                        controller.queryProviderSlot(
                            context,
                            controller.slotDataModel!,
                            serviceList!,
                            controller.typeId,
                            controller.itemSelectedFamily!,
                            id,
                            endDate: controller.selectedEndDate != null
                                ? controller.newDbEndDate
                                : null,
                            price: controller.difference != null
                                ? (int.parse(serviceList!.price!) *
                                    controller.difference)
                                : null,
                            difference: controller.difference != null
                                ? controller.difference
                                : 0,
                            bookingType: controller.bookingType);

                        controller.queryProviderTap(
                            id ?? 0,
                            context,
                            serviceList!,
                            controller.slotDataModel!,
                            controller.itemSelectedFamily!.name ?? "",
                            endDate: controller.selectedEndDate != null
                                ? controller.newDbEndDate
                                : null,
                            price: controller.difference != null
                                ? (int.parse(serviceList!.price!) *
                                    controller.difference)
                                : null,
                            difference: controller.difference != null
                                ? controller.difference
                                : 0,
                            bookingType: controller.bookingType);

                        controller.hitPostCartApi();
                      }
                    }
                  }
                } else {
                  if (controller.selectedEndDate != null) {
                    if (controller.cartServiceList.isNotEmpty) {
                      var listDB = controller.cartServiceList.where((element) =>
                          element.startTime ==
                          controller.slotDataModel?.startTime);
                      if (listDB.length == 0) {
                        if (controller.typeId == 0) {
                          if (controller.slotDataModel != null) {
                            controller.queryProviderSlot(
                                context,
                                controller.slotDataModel!,
                                serviceList!,
                                controller.typeId,
                                controller.itemSelectedFamily,
                                id,
                                endDate: controller.selectedEndDate != null
                                    ? controller.newDbEndDate
                                    : null,
                                price: controller.difference != null
                                    ? (int.parse(serviceList!.price!) *
                                        controller.difference)
                                    : null,
                                difference: controller.difference != null
                                    ? controller.difference
                                    : 0,
                                bookingType: controller.bookingType);

                            controller.queryProviderTap(
                                id ?? 0,
                                context,
                                serviceList!,
                                controller.slotDataModel!,
                                controller.itemSelectedFamily?.name ?? "",
                                endDate: controller.selectedEndDate != null
                                    ? controller.newDbEndDate
                                    : null,
                                price: controller.difference != null
                                    ? (int.parse(serviceList!.price!) *
                                        controller.difference)
                                    : null,
                                difference: controller.difference != null
                                    ? controller.difference
                                    : 0,
                                bookingType: controller.bookingType);

                            controller.hitPostCartApi();
                          } else {
                            snackBar(STRING_select_slot.tr);
                          }
                        } else {
                          if (controller.itemSelectedFamily?.id == null) {
                            snackBar('$STRING_SELECT_FAMILY'.tr);
                          } else {
                            controller.queryProviderSlot(
                                context,
                                controller.slotDataModel!,
                                serviceList!,
                                controller.typeId,
                                controller.itemSelectedFamily!,
                                id,
                                endDate: controller.selectedEndDate != null
                                    ? controller.newDbEndDate
                                    : null,
                                price: controller.difference != null
                                    ? (int.parse(serviceList!.price!) *
                                        controller.difference)
                                    : null,
                                difference: controller.difference != null
                                    ? controller.difference
                                    : 0,
                                bookingType: controller.bookingType);

                            controller.queryProviderTap(
                                id ?? 0,
                                context,
                                serviceList!,
                                controller.slotDataModel!,
                                controller.itemSelectedFamily!.name ?? "",
                                endDate: controller.selectedEndDate != null
                                    ? controller.newDbEndDate
                                    : null,
                                price: controller.difference != null
                                    ? (int.parse(serviceList!.price!) *
                                        controller.difference)
                                    : null,
                                difference: controller.difference != null
                                    ? controller.difference
                                    : 0,
                                bookingType: controller.bookingType);

                            controller.hitPostCartApi();
                          }
                        }
                      } else {
                        snackBar(STRING_SlotBooked.tr);
                      }
                    } else {
                      if (controller.typeId == 0) {
                        if (controller.slotDataModel != null) {
                          controller.queryProviderSlot(
                              context,
                              controller.slotDataModel!,
                              serviceList!,
                              controller.typeId,
                              controller.itemSelectedFamily,
                              id,
                              endDate: controller.selectedEndDate != null
                                  ? controller.newDbEndDate
                                  : null,
                              price: controller.difference != null
                                  ? (int.parse(serviceList!.price!) *
                                      controller.difference)
                                  : null,
                              difference: controller.difference != null
                                  ? controller.difference
                                  : 0,
                              bookingType: controller.bookingType);

                          controller.queryProviderTap(
                              id ?? 0,
                              context,
                              serviceList!,
                              controller.slotDataModel!,
                              controller.itemSelectedFamily?.name ?? "",
                              endDate: controller.selectedEndDate != null
                                  ? controller.newDbEndDate
                                  : null,
                              price: controller.difference != null
                                  ? (int.parse(serviceList!.price!) *
                                      controller.difference)
                                  : null,
                              difference: controller.difference != null
                                  ? controller.difference
                                  : 0,
                              bookingType: controller.bookingType);

                          controller.hitPostCartApi();
                        } else {
                          snackBar(STRING_select_slot.tr);
                        }
                      } else {
                        if (controller.itemSelectedFamily?.id == null) {
                          snackBar('$STRING_SELECT_FAMILY'.tr);
                        } else {
                          controller.queryProviderSlot(
                              context,
                              controller.slotDataModel!,
                              serviceList!,
                              controller.typeId,
                              controller.itemSelectedFamily!,
                              id,
                              endDate: controller.selectedEndDate != null
                                  ? controller.newDbEndDate
                                  : null,
                              price: controller.difference != null
                                  ? (int.parse(serviceList!.price!) *
                                      controller.difference)
                                  : null,
                              difference: controller.difference != null
                                  ? controller.difference
                                  : 0,
                              bookingType: controller.bookingType);

                          controller.queryProviderTap(
                              id ?? 0,
                              context,
                              serviceList!,
                              controller.slotDataModel!,
                              controller.itemSelectedFamily!.name ?? "",
                              endDate: controller.selectedEndDate != null
                                  ? controller.newDbEndDate
                                  : null,
                              price: controller.difference != null
                                  ? (int.parse(serviceList!.price!) *
                                      controller.difference)
                                  : null,
                              difference: controller.difference != null
                                  ? controller.difference
                                  : 0,
                              bookingType: controller.bookingType);

                          controller.hitPostCartApi();
                        }
                      }
                    }
                  } else {
                    snackBar(STRING_PleaseSelectEndDate.tr);
                  }
                }
              },
              // : RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(DIMENS_8)),
              // height: DIMENS_50,
              // textStyle: textStyle(fontWeight: FontWeight.bold),
              buttonText: STRING_AddtoCart.tr,
              // backgroundColor: appColor,
            ),
          ),
          vGap(DIMENS_30),
        ],
      ),
    );
  }

  Widget nationalityEditText() =>
      GetBuilder<CartController>(builder: (controller) {
        return customDropDown(
            lable: "$STRING_Select_Patient".tr,
            focusNode: FocusNode(),
            dropdownMenuItems: controller.dropdownMenuItemsServiceType,
            itemSelected: controller.itemSelectedFamily,
            onChanged: (data) {
              controller.onChangeMemberType(data);
              controller.isMemberSelected = true;
            },
            hintText: STRING_SelectPatient.tr);
      });

  _startDate(CartController controller, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DIMENS_15),
      // decoration: BoxDecoration(
      //     color: fadeBlue, borderRadius: BorderRadius.circular(DIMENS_10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // text(STRING_StartDate.tr,
          //     color: indigoColor, fontWeight: FontWeight.w500),
          // vGap(DIMENS_5),
          Container(
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(DIMENS_10),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.shade300,
            //         blurRadius: 3,
            //       )
            //     ]),
            height: 55,
            child: TextField(
              onTap: () async {
                controller.clearSlotData();
                var comtroller = Get.put(BookServiceProviderController());

                var dayId = intl.DateFormat('EEEE').format(DateTime.now());

                var nameId = comtroller.getDayId(dayId);
                var startDate = intl.DateFormat("yyyy-MM-dd HH:mm:ss")
                    .parse(DateTime.now().toString());

                var endDate = DateTime(
                    startDate.year, startDate.month, startDate.day, 23, 59, 59);

                comtroller.updateProviderId(id ?? 0);
                comtroller.hitGetSlotApiApi(
                    id ?? 0,
                    startDate.toString().replaceAll('.000Z', ''),
                    endDate.toString().replaceAll('.000', ''),
                    nameId,
                    subId);

                storage.write('subId', subId);
                var data =
                    await Get.to(CalendarScreen(), arguments: {'subId': subId});
                if (data != null) {
                  controller.slotDataModel = data;

                  controller.newSelectedEndDate =
                      controller.slotDataModel?.endTime.toString();

                  controller.isStartDate = true;
                  controller.update();
                }
                controller.startDate.text = controller
                        .dateFormat(controller.slotDataModel?.startTime) ??
                    "Date";
                controller.startTime.text =
                    "${controller.timeFormat(controller.slotDataModel?.startTime)}";
                controller.endTime.text =
                    "${controller.timeFormat(controller.slotDataModel?.endTime)}";
              },
              controller: controller.startDate,
              decoration: InputDecoration(
                  hintText: controller
                          .dateFormat(controller.slotDataModel?.startTime) ??
                      "Date",
                  label: Text(STRING_StartDate.tr),
                  hintStyle: textStyle(fontSize: FONT_14),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(13),
                    child: SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      // color: indigoBlackColor,
                      // height: DIMENS_10,
                      // width: DIMENS_10,
                    ),
                  )),
              readOnly: true,
            ),
          ),

          Visibility(
            visible: controller.isStartDate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vGap(DIMENS_20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // text(STRING_StartTime.tr,
                          //     color: indigoColor, fontWeight: FontWeight.w500),
                          // vGap(DIMENS_5),
                          Container(
                            // decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(DIMENS_10),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.grey.shade300,
                            //         blurRadius: 3,
                            //       )
                            //     ]),
                            height: 55,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: buttonColor,
                                      ),
                                ),
                                child: TextField(
                                  controller: controller.startTime,
                                  decoration: InputDecoration(
                                      label: Text(STRING_StartTime.tr),
                                      focusColor: buttonColor,
                                      hintText:
                                          '${controller.timeFormat(controller.slotDataModel?.startTime) ?? STRING_StartTime.tr}',
                                      hintStyle: textStyle(
                                          color: Colors.black,
                                          fontSize: FONT_16),
                                      suffixIcon: Icon(
                                        Icons.watch_later_rounded,
                                        // color: indigoBlackColor,
                                      )),
                                  readOnly: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    hGap(DIMENS_15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // text(STRING_EndTime.tr,
                          //     color: indigoColor, fontWeight: FontWeight.w500),
                          // vGap(DIMENS_5),
                          Container(
                            // decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(DIMENS_10),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.grey.shade300,
                            //         blurRadius: 3,
                            //       )
                            //     ]),
                            height: 55,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: buttonColor,
                                      ),
                                ),
                                child: TextField(
                                  controller: controller.endTime,
                                  decoration: InputDecoration(
                                      label: Text(STRING_EndTime.tr),
                                      focusColor: buttonColor,
                                      hintText:
                                          '${controller.timeFormat(controller.slotDataModel?.endTime) ?? STRING_EndTime.tr}',
                                      hintStyle: textStyle(
                                          color: Colors.black,
                                          fontSize: FONT_16),
                                      // suffixIconColor: buttonColor,
                                      suffixIcon: Icon(
                                        Icons.watch_later_rounded,

                                        // color: indigoBlackColor,
                                      )),
                                  readOnly: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget memberRadioButton(CartController controller, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      height: 25,
      color: lLightGreyColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Radio(
                  activeColor: COLOR_middleBlueM,
                  value: 1,
                  groupValue: controller.val,
                  onChanged: (int? value) async {
                    controller.typeId = 0;
                    SignUpResponseModel data =
                        await storage.read(LOCALKEY_profile);
                    controller.familyAddress =
                        '${data.detail?.userAddress?.houseNo},${data.detail?.userAddress?.street}';
                    controller.itemSelectedFamily = null;
                    controller.isMemberSelected = true;
                    controller.val = value;
                    controller.update();
                  }),
              Text(
                STRING_Myselff.tr,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: controller.val == 1 ? buttonColor : null,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                  activeColor: COLOR_middleBlueM,
                  value: 2,
                  groupValue: controller.val,
                  onChanged: (int? value) {
                    controller.typeId = 1;
                    controller.familyAddress = "";
                    controller.isMemberSelected = false;
                    controller.val = value;
                    controller.update();
                  }),
              Text(
                STRING_Family_Member.tr,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: controller.val == 2 ? buttonColor : null,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _endDate(CartController controller, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DIMENS_15),
      // decoration: BoxDecoration(
      //     color: fadeBlue, borderRadius: BorderRadius.circular(DIMENS_10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // text(STRING_EndDate.tr,
          //     color: indigoColor, fontWeight: FontWeight.w500),
          // vGap(DIMENS_5),
          Container(
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(DIMENS_10),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.shade300,
            //         blurRadius: 3,
            //       )
            //     ]),
            height: 55,
            child: TextField(
              onTap: () async {
                if (controller.slotDataModel == null) {
                  snackBar(STRING_PleaseSelectStartDateFirst.tr);
                } else {
                  await controller.selectDate(context, id, subId);
                  controller.endDate.text = controller.selectedEndDate == null
                      ? STRING_EndDate.tr
                      : controller
                          .dateFormat(controller.selectedEndDate.toString());
                }
              },
              decoration: InputDecoration(
                  hintText: controller.selectedEndDate == null
                      ? STRING_EndDate.tr
                      : controller
                          .dateFormat(controller.selectedEndDate.toString()),
                  hintStyle: textStyle(
                    fontSize: FONT_14,
                  ),
                  label: Text(
                    STRING_EndDate.tr,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(13),
                    child: SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      // color: indigoBlackColor,
                      // height: DIMENS_10,
                      // width: DIMENS_10,
                    ),
                  )),
              controller: controller.endDate,
              readOnly: true,
            ),
          ),
          vGap(DIMENS_20),
          Visibility(
            visible: false,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      text(STRING_StartTime.tr,
                          color: indigoColor, fontWeight: FontWeight.w500),
                      vGap(DIMENS_5),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(DIMENS_10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 3,
                              )
                            ]),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText:
                                  '${controller.timeFormat(controller.slotDataModel?.startTime) ?? "Start Time"}',
                              hintStyle: textStyle(
                                  color: Colors.black, fontSize: FONT_16),
                              suffixIcon: Icon(
                                Icons.watch_later_rounded,
                                color: indigoBlackColor,
                              )),
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                ),
                hGap(DIMENS_15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      text(STRING_EndTime.tr,
                          color: indigoColor, fontWeight: FontWeight.w500),
                      vGap(DIMENS_5),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(DIMENS_10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 3,
                              )
                            ]),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText:
                                  '${controller.timeFormat(controller.slotDataModel?.endTime) ?? STRING_EndTime.tr}',
                              hintStyle: textStyle(
                                  color: Colors.black, fontSize: FONT_16),
                              suffixIcon: Icon(
                                Icons.watch_later_rounded,
                                color: indigoBlackColor,
                              )),
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _booking(CartController controller) {
    print('PRICE  ${serviceList!.price!}');
    return Container(
      width: Get.width,
      // margin: EdgeInsets.all(DIMENS_10),
      // padding: EdgeInsets.all(DIMENS_15),
      // decoration: BoxDecoration(
      //     color: fadeBlue,
      //     borderRadius: BorderRadius.circular(DIMENS_10),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.shade300,
      //         blurRadius: 5,
      //       )
      //     ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeadingWidget(
            title: STRING_BOOKSLOTt.tr,
          ),
          TitleSubtitleHorizontalWidget(
            title: STRING_StartDate.tr,
            subtitle: controller.isSubscribed == false
                ? '${controller.dateFormat(controller.slotDataModel?.startTime) ?? ""}'
                : '${controller.dateFormat(controller.slotDataModel?.startTime) ?? ""}',
          ),
          TitleSubtitleHorizontalWidget(
            title: STRING_EndDate.tr,
            subtitle: controller.isSubscribed == true
                ? '${controller.dateFormat(controller.slotDataModel?.endTime, bool: true) ?? ""}'
                : '${controller.dateFormat(controller.selectedEndDate, bool: true) ?? ""}',
          ),
          TitleSubtitleHorizontalWidget(
            title: STRING_timeslot.tr,
            showDivider: false,
            subtitle: storage.read(LOCALKEY_english) == null ||
                    storage.read(LOCALKEY_english) == true
                ? '${controller.timeFormat(controller.slotDataModel?.startTime) ?? ""} - ${controller.timeFormat(controller.slotDataModel?.endTime) ?? ""}'
                : '${controller.timeFormat(controller.slotDataModel?.startTime) ?? ""} - ${controller.timeFormat(controller.slotDataModel?.endTime) ?? ""}',
          ),
          // text(STRING_BOOKSLOTt.tr,
          //     color: Colors.grey, fontWeight: FontWeight.w500),
          // ListTile(
          //     minLeadingWidth: 0,
          //     contentPadding: EdgeInsets.zero,
          //     leading: Image.asset(
          //       ICON_calendar,
          //       color: indigoBlackColor,
          //       height: DIMENS_20,
          //       width: DIMENS_20,
          //     ),
          //     title: controller.isSubscribed == false
          //         ? text(
          //             '${controller.dateFormat(controller.slotDataModel?.startTime) ?? ""} - ${controller.dateFormat(controller.slotDataModel?.endTime, bool: true) ?? ""}',
          //             color: indigoColor,
          //             fontWeight: FontWeight.w500)
          //         : text(
          //             '${controller.dateFormat(controller.slotDataModel?.startTime) ?? ""} - ${controller.dateFormat(controller.selectedEndDate, bool: true) ?? ""}',
          //             color: indigoColor,
          //             fontWeight: FontWeight.w500),
          //     subtitle: storage.read(LOCALKEY_english) == null ||
          //             storage.read(LOCALKEY_english) == true
          //         ? Align(
          //             alignment: Alignment.topLeft,
          //             child: Directionality(
          //               textDirection: TextDirection.ltr,
          //               child: text(
          //                   '${controller.timeFormat(controller.slotDataModel?.startTime) ?? ""} - ${controller.timeFormat(controller.slotDataModel?.endTime) ?? ""}',
          //                   color: indigoColor,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           )
          //         : Align(
          //             alignment: Alignment.topRight,
          //             child: Directionality(
          //               textDirection: TextDirection.ltr,
          //               child: text(
          //                   '${controller.timeFormat(controller.slotDataModel?.startTime) ?? ""} - ${controller.timeFormat(controller.slotDataModel?.endTime) ?? ""}',
          //                   color: indigoColor,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           )),
          Container(
            height: 25,
            color: lLightGreyColor,
          ),
          TitleSubtitleHorizontalWidget(
            title: STRING_TotalPricee.tr,
            subtitle: controller.difference == null
                ? '${STRING_CURRENCY.tr} ${serviceList?.price ?? ""}'
                : '${STRING_CURRENCY.tr} ${double.parse(serviceList!.price!) * controller.difference}',
            showDivider: false,
            isButtonColor: true,
            isTitleButtonColor: true,
          ),
          const SizedBox(
            height: 15,
          ),
          // text(STRING_TotalPricee.tr,
          //     color: Colors.grey, fontWeight: FontWeight.w500),
          // ListTile(
          //   minLeadingWidth: 0,
          //   contentPadding: EdgeInsets.zero,
          //   leading: imageAsset(ICON_priceTag, height: DIMENS_20),
          //   title: controller.difference == null
          //       ? text('${STRING_CURRENCY.tr} ${serviceList?.price ?? ""}',
          //           color: indigoColor, fontWeight: FontWeight.w500)
          //       : text(
          //           '${STRING_CURRENCY.tr} ${double.parse(serviceList!.price!) * controller.difference}',
          //           color: indigoColor,
          //           fontWeight: FontWeight.w500),
          // ),
        ],
      ),
    );
  }
}
