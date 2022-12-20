import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swift_care/components/common_widget.dart';
import 'package:swift_care/components/custom_appbar.dart';
import 'package:swift_care/components/custom_text.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/model/responseModal/family_response_model.dart';

import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';
import 'package:swift_care/utils/projectutils/prefic_widget.dart';
import 'package:swift_care/utils/utils.dart';

import '../../../../components/inputfield_mobile_widget.dart';
import '../../../../components/inputfield_widget.dart';
import '../../../../export.dart';

class AddFamilyMember extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();

  FamilyMember? item;

  AddFamilyMember({this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticPageController>(
        init: StaticPageController(familyMember: item),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: DefaultAppBar(
                title: STRING_AddFamilyMember,
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: hMargin),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      vGap(30),
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            vertical: 50, horizontal: hMargin),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                          color: Theme.of(context).cardColor,
                        ),
                        child: Form(
                          key: formGlobalKey,
                          child: Column(
                            children: [
                              InputFieldWidget(
                                  label: STRING_fullName.tr,
                                  hint: STRING_fullName.tr,
                                  isFill: false,
                                  borderRadius: 8,
                                  controller: controller.nameController,
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return STRING_EnterName.tr;
                                    else if (value.isNumericOnly)
                                      return STRING_EnterValidName.tr;
                                    else if (value.length < 4)
                                      return STRING_Char4.tr;
                                    else
                                      return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  focusNode: controller.nameFocusNode),
                              vGap(16),
                              InputFieldWidget(
                                maxLength: 20,
                                controller: controller.relationController,
                                label: STRING_relationship.tr,
                                hint: STRING_enterRelationship.tr,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return STRING_EnterRelationShip.tr;
                                  else
                                    return null;
                                },
                                focusNode: controller.emailFocusNode,
                                isFill: false,
                                borderRadius: 8,
                                keyboardType: TextInputType.text,
                              ),
                              vGap(16),
                              Stack(
                                children: [
                                  InputFieldWidget(
                                      isFill: false,
                                      borderRadius: 8,
                                      controller: controller.mobileController,
                                      // label: STRING_mobileNo.tr,
                                      hint: STRING_mobileNo.tr,
                                      maxLength: 9,
                                      prefixWidget: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          countryCode(
                                              controller: controller,
                                              bool: true),
                                          Container(
                                            margin: EdgeInsetsDirectional.only(
                                                end: 10),
                                            width: 1,
                                            height: 20,
                                            color: Color(0xffC2C2C2),
                                          ),
                                        ],
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return STRING_EnterMobile.tr;
                                        else if (value.length > 0 &&
                                            !GetUtils.isPhoneNumber(value))
                                          return STRING_EnterValidMobile.tr;
                                        else
                                          return null;
                                      },
                                      keyboardType: TextInputType.phone,
                                      focusNode: controller.mobileFocusNode),
                                  InputFieldMobileWidget(),
                                ],
                              ),
                              vGap(32),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      text(STRING_address.tr,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                          fontSize: FONT_18),
                                      InkWell(
                                        onTap: () {
                                          controller.showPlacePicker();
                                        },
                                        child: imageAsset(
                                            "assets/icons/map.png",
                                            height: DIMENS_30),
                                      )
                                    ],
                                  )),
                              vGap(16),
                              InkWell(
                                onTap: () {
                                  controller.showPlacePicker();
                                },
                                child: InputFieldWidget(
                                    isFill: false,
                                    enable: false,
                                    borderRadius: 8,
                                    controller: controller.houseNoController,
                                    label: STRING_houseNo.tr,
                                    // hint: STRING_houseNo.tr,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return STRING_EnterHouseNo.tr;
                                      else
                                        return null;
                                    },
                                    keyboardType: TextInputType.streetAddress,
                                    focusNode: controller.houseNoFocusNode),
                              ),
                              vGap(16),
                              InkWell(
                                onTap: () {
                                  controller.showPlacePicker();
                                },
                                child: InputFieldWidget(
                                    isFill: false,
                                    enable: false,
                                    borderColor:
                                        Theme.of(context).primaryColorDark,
                                    borderRadius: 8,
                                    controller: controller.streetController,
                                    label: STRING_street.tr,
                                    // hint: STRING_street.tr,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return STRING_EnterStreet.tr;
                                      else
                                        return null;
                                    },
                                    keyboardType: TextInputType.streetAddress,
                                    focusNode: controller.streetFocusNode),
                              ),
                              vGap(16),
                              InkWell(
                                onTap: () {
                                  controller.showPlacePicker();
                                },
                                child: InputFieldWidget(
                                    isFill: false,
                                    enable: false,
                                    borderRadius: 8,
                                    controller:
                                        controller.additionalInfoController,
                                    label: STRING_additionalInfo.tr,
                                    // hint: STRING_additionalInfo.tr,
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return STRING_EnterAddiNfo.tr;
                                      else
                                        return null;
                                    },
                                    keyboardType: TextInputType.streetAddress,
                                    focusNode:
                                        controller.additionalInfoFocusNode),
                              ),
                            ],
                          ),
                        ),
                      ),
                      vGap(30),
                      InkWell(
                        onTap: () {
                          if (formGlobalKey.currentState!.validate()) {
                            controller.hitAddFamilyMemberApi(id: item?.id ?? 0);
                          }
                        },
                        child: Container(
                          width: Get.width,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          height: 40,
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
                          alignment: Alignment.center,
                          child: Text(
                            STRING_save.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      vGap(30),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
