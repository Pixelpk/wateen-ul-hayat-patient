import 'package:swift_care/components/custom_divider.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/primary_buttons.dart';
import 'package:swift_care/pages/home/presentation/controllers/bottom_navigation_controller.dart';
import '../../../../export.dart';

class FilterScreen extends StatelessWidget {
  var categoryId;
  var id;

  FilterScreen(this.categoryId, this.id);

  final List<int> ratingsList = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(
      init: BottomNavigationController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
              appBar: DefaultAppBar(
                title: STRING_filter.tr,
              ),
              body: Container(
                height: Get.height,
                child: _body(controller, context),
              )),
        );
      },
    );
  }

  _body(BottomNavigationController controller, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          vGap(30),
          Container(
            decoration: cardDecoration,
            margin:
                EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
            // color: Theme.of(context).cardColor,
            padding: EdgeInsets.symmetric(vertical: DIMENS_15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12),
                  child: ListTile(
                    title: text('$STRING_price_type'.tr,
                        fontWeight: FontWeight.w600, fontSize: FONT_15),
                    minVerticalPadding: 10,
                    contentPadding: EdgeInsets.zero,
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.priceType = 4;
                              controller.update();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: DIMENS_10, vertical: DIMENS_3),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(DIMENS_20),
                                  color: controller.priceType == 4
                                      ? buttonColor
                                      : lFillColorLight,
                                  border: Border.all(
                                      color: controller.priceType == 4
                                          ? buttonColor
                                          : Colors.grey.shade600,
                                      width: 1.5)),
                              child: text(
                                '$STRING_hour_type'.tr,
                                color: controller.priceType == 4
                                    ? Theme.of(context).cardColor
                                    : lTextColorLight,
                                fontSize: FONT_13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          hGap(DIMENS_10),
                          InkWell(
                            onTap: () {
                              controller.priceType = 0;
                              controller.update();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: DIMENS_10, vertical: DIMENS_3),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(DIMENS_20),
                                  color: controller.priceType == 0
                                      ? buttonColor
                                      : lFillColorLight,
                                  border: Border.all(
                                      color: controller.priceType == 0
                                          ? buttonColor
                                          : Colors.grey.shade600,
                                      width: 1.5)),
                              child: text(
                                '$STRING_fixed_type'.tr,
                                color: controller.priceType == 0
                                    ? Theme.of(context).cardColor
                                    : lTextColorLight,
                                fontSize: FONT_13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                vGap(DIMENS_10),
                CustomDivider(
                  isPrimaryColor: true,
                ),
                // CustomSlider(),
                vGap(DIMENS_10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    STRING_gender.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                vGap(DIMENS_10),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: RadioListTile<int>(
                        value: 0,
                        dense: true,
                        activeColor: buttonColor,
                        visualDensity: VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          '$STRING_Male'.tr,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: controller.genderType == 0
                                        ? buttonColor
                                        : lTextColorLight,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        groupValue: controller.genderType,
                        onChanged: (val) {
                          controller.genderType = val;
                          controller.update();
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: RadioListTile<int>(
                        activeColor: buttonColor,
                        dense: true,
                        visualDensity: VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        value: 1,
                        title: Text(
                          '$STRING_Female'.tr,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: controller.genderType == 1
                                        ? buttonColor
                                        : lTextColorLight,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        groupValue: controller.genderType,
                        onChanged: (val) {
                          controller.genderType = val;
                          controller.update();
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),

                    // Expanded(child: Container())
                    // InkWell(
                    //   onTap: () {
                    //     controller.genderType = 0;
                    //     controller.update();
                    //   },
                    //   child: Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: DIMENS_10, vertical: DIMENS_5),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(DIMENS_20),
                    //           border: Border.all(
                    //               color: controller.genderType == 0
                    //                   ? lightBlue
                    //                   : Colors.grey.shade600,
                    //               width: 1.5)),
                    //       child: text('$STRING_Male'.tr,
                    //           color: Colors.black,
                    //           fontSize: FONT_13,
                    //           fontWeight: FontWeight.w500)),
                    // ),
                    // hGap(DIMENS_10),
                    // InkWell(
                    //   onTap: () {
                    //     controller.genderType = 1;
                    //     controller.update();
                    //   },
                    //   child: Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: DIMENS_10, vertical: DIMENS_5),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(DIMENS_20),
                    //           border: Border.all(
                    //               color: controller.genderType == 1
                    //                   ? lightBlue
                    //                   : Colors.grey.shade600,
                    //               width: 1.5)),
                    //       child: text('$STRING_Female'.tr,
                    //           color: Colors.black,
                    //           fontSize: FONT_13,
                    //           fontWeight: FontWeight.w500)),
                    // ),
                  ],
                ),

                vGap(DIMENS_10),
                CustomDivider(
                  isPrimaryColor: true,
                ),
                vGap(DIMENS_10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    STRING_review.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                vGap(DIMENS_20),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12, end: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: ratingsList
                          .asMap()
                          .entries
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                controller.ratingType = e.value;
                                controller.update();
                              },
                              child: RateContainerWidget(
                                  controller: controller, e: e),
                            ),
                          )
                          .toList()),
                ),
                vGap(DIMENS_40),
              ],
            ),
          ),
          vGap(DIMENS_40),
          Container(
            height: DIMENS_60,
            padding: EdgeInsets.symmetric(horizontal: DIMENS_30),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                      buttonText: STRING_clear.tr,
                      isBlackColor: true,
                      onPressed: () {
                        controller.clearFilters();
                      }),
                ),
                // Expanded(
                hGap(DIMENS_10),
                Expanded(
                  child: PrimaryButton(
                      buttonText: STRING_apply.tr,
                      onPressed: () {
                        FilterModel filterModel = FilterModel(
                            categoryId: categoryId,
                            sortType: controller.priceType,
                            subCategoryId: id,
                            gender: controller.genderType,
                            rating: controller.ratingType);
                        Get.back(result: filterModel);
                      }),
                ),
              ],
            ),
          ),
          vGap(DIMENS_30),
        ],
      ),
    );
  }

  serviceCategories(BottomNavigationController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DIMENS_20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(STRING_ServiceCategory.tr,
              fontWeight: FontWeight.w500, fontSize: FONT_16),
          Container(
            height: DIMENS_30,
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: lightBlue,
              value: 1,
              groupValue: controller.serviceType,
              onChanged: (int? val) {
                controller.serviceType = val;
                controller.update();
              },
              title: text(STRING_AmbulanceHiring.tr),
            ),
          ),
          Container(
            height: DIMENS_30,
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: lightBlue,
              value: 2,
              groupValue: controller.serviceType,
              onChanged: (int? val) {
                controller.serviceType = val;
                controller.update();
              },
              title: text(STRING_NursBooking.tr),
            ),
          ),
          Container(
            height: DIMENS_30,
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: lightBlue,
              value: 3,
              groupValue: controller.serviceType,
              onChanged: (int? val) {
                controller.serviceType = val;
                controller.update();
              },
              title: text(STRING_HomeCareServices.tr),
            ),
          ),
          Container(
            height: DIMENS_30,
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: lightBlue,
              value: 4,
              groupValue: controller.serviceType,
              onChanged: (int? val) {
                controller.serviceType = val;
                controller.update();
              },
              title: text(STRING_NearestProvider.tr),
            ),
          ),
          Container(
            height: DIMENS_30,
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: lightBlue,
              value: 5,
              groupValue: controller.serviceType,
              onChanged: (int? val) {
                controller.serviceType = val;
                controller.update();
              },
              title: text(STRING_availability.tr),
            ),
          ),
        ],
      ),
    );
  }
}

class RateContainerWidget extends StatelessWidget {
  final BottomNavigationController controller;
  final MapEntry<int, int> e;

  const RateContainerWidget({
    Key? key,
    required this.controller,
    required this.e,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.15,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(e.value == 5 ? 30 : 0),
          topStart: Radius.circular(e.value == 1 ? 30 : 0),
          bottomEnd: Radius.circular(e.value == 5 ? 30 : 0),
          bottomStart: Radius.circular(e.value == 1 ? 30 : 0),
        ),
        border: Border.all(
          color: buttonColor,
          width: 1,
        ),
        color: controller.ratingType == e.value ? buttonColor : lFillColorLight,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              e.value.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: controller.ratingType == e.value
                        ? Theme.of(context).cardColor
                        : Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(width: 3),
            Icon(
              Icons.star_rounded,
              size: 16,
              color: controller.ratingType == e.value
                  ? Theme.of(context).cardColor
                  : Theme.of(context).primaryColorLight,
            ),
            // Container(
            //   width: 12,
            //   height: 11.49,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     color: Color(0xffbdbdbd),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class FilterModel {
  int? categoryId;
  int? subCategoryId;
  int? sortType;
  int? rating;
  int? gender;

  FilterModel(
      {@required this.categoryId,
      @required this.subCategoryId,
      @required this.rating,
      @required this.gender,
      @required this.sortType});
}
