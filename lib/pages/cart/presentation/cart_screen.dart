import 'package:intl/intl.dart' as intl;
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'package:swift_care/utils/projectutils/custom_dropdown.dart';
import 'package:swift_care/utils/utils.dart';
import '../../../../export.dart';
import '../../../model/responseModal/signup_response_model.dart';
import '../../home/presentation/controllers/book_service_provider_controller.dart';
import '../../service_providers/presentation/views/book_service_provider.dart';
import 'controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  int? id;

  CartScreen(this.id);

  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        initState: (state) {
          controller.isListEmpty = storage.read(LOCALKEY_cardList);
        },
        init: CartController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () {
              return count();
            },
            child: SafeArea(
              child: Scaffold(
                  appBar: DefaultAppBar(
                    title: STRING_cart.tr,
                  ),
                  body: _body(controller)),
            ),
          );
        });
  }

  count() {
    var ctrl = Get.put(BottomNavigationController());
    var ctrl1 = Get.put(BookServiceProviderController());
    ctrl.getCount();
    ctrl1.getCount();
    Get.back();
  }

  _body(CartController controller) {
    return controller.cartServiceList.isNotEmpty
        ? SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.cartServiceList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                                color: buttonColor,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                STRING_ServiceDetails.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            vGap(6),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: hMargin),
                              child: Text(
                                controller?.cartServiceList[index]?.name ?? "",
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            vGap(6),
                            Container(
                              height: 1,
                              width: Get.width,
                              color: isDarkMode()
                                  ? dDropDownColor
                                  : lDropDownColor,
                            ),
                            vGap(6),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: hMargin),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '${STRING_gender.tr}: ',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    controller.cartServiceList[index].gender ??
                                        "",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${STRING_price.tr}: ',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${STRING_CURRENCY.tr} ${controller.cartServiceList[index].price ?? ""}',
                                    style: TextStyle(
                                      color: buttonColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            vGap(6),
                            Container(
                              width: Get.width,
                              height: 20,
                              color: isDarkMode()
                                  ? dFillColorLight
                                  : lFillColorLight,
                            ),
                            vGap(6),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: hMargin),
                              child: Row(
                                children: [
                                  Text(
                                    '${STRING_patientName.tr}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    controller.cartServiceList[index]
                                                .familyName == ""
                                        ? STRING_Myselff.tr
                                        : '${controller.cartServiceList[index].familyName}',
                                    style: TextStyle(
                                      color: buttonColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            vGap(6),
                            Container(
                              height: 1,
                              width: Get.width,
                              color: isDarkMode()
                                  ? dDropDownColor
                                  : lDropDownColor,
                            ),
                            vGap(6),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: hMargin),
                              child: Row(
                                children: [
                                  Text(
                                    '${STRING_StartDate.tr}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    ' ${intl.DateFormat("dd-MM-yyyy").format(DateTime.parse(controller.cartServiceList[index].startTime!))}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            vGap(6),
                            Container(
                              height: 1,
                              width: Get.width,
                              color: isDarkMode()
                                  ? dDropDownColor
                                  : lDropDownColor,
                            ),
                            vGap(6),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: hMargin),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '${STRING_EndDate.tr}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${intl.DateFormat("dd-MM-yyyy").format(DateTime.parse(controller.cartServiceList[index].endTime!))}',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            vGap(6),
                            Container(
                              height: 1,
                              width: Get.width,
                              color: isDarkMode()
                                  ? dDropDownColor
                                  : lDropDownColor,
                            ),
                            vGap(6),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: hMargin),
                              child: Row(
                                children: [
                                  Text(
                                    STRING_timeslot.tr,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      '${intl.DateFormat("hh:mm a").format(DateTime.parse(controller.cartServiceList[index].startTime!))} - ${intl.DateFormat("hh:mm a").format(DateTime.parse(controller.cartServiceList[index].endTime!))}',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: controller.cartServiceList[index]
                                          .slotBookingType ==
                                      1
                                  ? true
                                  : false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  vGap(6),
                                  Container(
                                    height: 1,
                                    width: Get.width,
                                    color: isDarkMode()
                                        ? dDropDownColor
                                        : lDropDownColor,
                                  ),
                                  vGap(6),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: hMargin),
                                    child: Row(
                                      children: [
                                        Text(
                                          STRING_Days.tr,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          controller.cartServiceList[index]?.difference.toString() ?? "0",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  vGap(6),
                                  Container(
                                    height: 1,
                                    width: Get.width,
                                    color: isDarkMode()
                                        ? dDropDownColor
                                        : lDropDownColor,
                                  ),
                                  vGap(6),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: hMargin),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          STRING_Status.tr,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        text(STRING_Subscription.tr,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: FONT_14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            vGap(30),
                            InkWell(
                              onTap: () {
                                controller.deleteItem(
                                    controller.cartServiceList[index].id ?? 0);

                                controller.deleteSlotItem(
                                    controller.slotServiceList[index].id ?? 0);

                                controller.hitPostCartApi();
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 130,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    STRING_Delete.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            vGap(16),
                          ],
                        ),
                      );
                    },
                  ),
                  vGap(30),

                  ///------------- total section
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Color(0xffe5e5e5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: hMargin),
                          child: Row(
                            children: [
                              Text(
                                STRING_SubTotal.tr,
                                style: TextStyle(
                                  color:
                                      Theme.of(Get.context!).primaryColorDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${STRING_CURRENCY.tr} ${controller.cartTotal}',
                                style: TextStyle(
                                  color:
                                      Theme.of(Get.context!).primaryColorDark,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        vGap(12),
                        Container(
                          height: 1,
                          width: Get.width,
                          color: Color(0xffD9D9D9),
                        ),
                        vGap(12),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: hMargin),
                          child: Row(
                            children: [
                              Text(
                                STRING_VAT.tr,
                                style: TextStyle(
                                  color:
                                      Theme.of(Get.context!).primaryColorDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${STRING_CURRENCY.tr} ${double.parse(controller.subtotal.toStringAsFixed(2))}',
                                style: TextStyle(
                                  color:
                                      Theme.of(Get.context!).primaryColorDark,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        vGap(12),
                        Container(
                          height: 1,
                          width: Get.width,
                          color: Color(0xffD9D9D9),
                        ),
                        vGap(12),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: hMargin),
                          child: Row(
                            children: [
                              Text(
                                STRING_TOTAL.tr,
                                style: TextStyle(
                                  color:
                                      Theme.of(Get.context!).primaryColorDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '${STRING_CURRENCY.tr} ${getTotalAmount(controller)}',
                                style: TextStyle(
                                  color:
                                      Theme.of(Get.context!).primaryColorDark,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  vGap(30),

                  ///-------------- Add More button
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          var cotroller =
                              Get.put(BookServiceProviderController());
                          var cotrollerr =
                              Get.put(BookServiceProviderController());
                          cotroller.updateCurrentTabIndex(1);
                          cotrollerr.hitGetUserProfileAPI(
                              controller.cartServiceList[0].providerId);
                          cotrollerr.servicesListHitApi(
                              controller.cartServiceList[0].providerId ?? 0);
                          Get.to(BookServiceProvider(
                              controller.cartServiceList[0].providerId));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_circle,
                              color: buttonColor,
                            ),
                            hGap(4),
                            text('$STRING_ADD_MORE'.tr,
                                color: buttonColor, fontSize: 16.0),
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          controller.querySlotData(id);
                        },
                        child: Container(
                          width: 180,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                            color: buttonColor,
                          ),
                          child: Center(
                            child: Text(
                              STRING_confirmBooking.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  vGap(DIMENS_30),
                ],
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove_shopping_cart,
                  color: primaryColor,
                ),
                text(STRING_CartEmpty.tr)
              ],
            ),
          );
  }

  getTotalAmount(CartController controller) {
    double? vat = controller.countryCode == "+966" ? 0.0 : 0.15;
    controller.subtotal = controller.cartTotal * vat;
    controller.total = controller.subtotal + controller.cartTotal;
    return double.parse(controller.total.toStringAsFixed(2));
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

  Widget memberRadioButton(CartController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
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
              text('Myself'),
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
              text(STRING_Family_Member.tr),
            ],
          ),
        ],
      ),
    );
  }

}
