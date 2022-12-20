import 'package:country_picker/country_picker.dart';

import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/inputfield_mobile_widget.dart';
import 'package:swift_care/model/responseModal/nationalities_response_model.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/complete_profile_screen_controller.dart';

import 'package:swift_care/service/remote_service/network/endpoint.dart';
import 'package:swift_care/utils/projectutils/prefic_widget.dart';

import '../../../../components/custom_sheet.dart';
import '../../../../components/inputfield_widget.dart';
import '../../../../export.dart';
import 'add_family_member.dart';

class CompleteProfile extends StatelessWidget {
  String title;

  CompleteProfile({Key? key, required this.title}) : super(key: key);

  var ctrl = Get.put(CompleteProfileController());

  final formGlobalKey = GlobalKey<FormState>();

  Future<bool> _willPopCallback() async {
    if (title == STRING_EditProfile.tr) {
      Get.back();
    } else {
      Get.to(LoginScreen());
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<CompleteProfileController>(
          init: CompleteProfileController(),
          initState: (state) {
            if (title == STRING_EditProfile.tr) {
              ctrl.isUpdate = true;
            } else {
              ctrl.isUpdate = false;
            }
          },
          builder: (controller) {
            return WillPopScope(
              onWillPop: () {
                return _willPopCallback();
              },
              child: Scaffold(
                appBar: DefaultAppBar(
                  title: title == STRING_EditProfile
                      ? STRING_EditProfile.tr
                      : STRING_EnterComplete.tr,
                  onBackPress: () {
                    if (title == STRING_EditProfile.tr) {
                      Get.back();
                    } else {
                      Get.offAll(LoginScreen());
                    }
                  },
                ),
                body: Container(
                  margin: EdgeInsets.symmetric(horizontal: hMargin),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        vGap(16),
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              margin: EdgeInsets.only(top: 51),
                              padding:
                                  EdgeInsets.symmetric(horizontal: hMargin),
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
                              child: Form(
                                  key: formGlobalKey,
                                  child: Column(
                                    children: [
                                      vGap(100),
                                      InputFieldWidget(
                                          controller: controller.nameController,
                                          label: STRING_fullName.tr,
                                          hint: STRING_fullName.tr,
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return STRING_EnterName;
                                            else if (value.isNumericOnly)
                                              return STRING_EnterValidName;
                                            else if (value.length < 4)
                                              return STRING_Char4.tr;
                                            else
                                              return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          focusNode: controller.nameFocusNode),
                                      vGap(20),
                                      Stack(
                                        children: [
                                          InputFieldWidget(
                                              enable: false,
                                              maxLength: 9,
                                              controller:
                                                  controller.mobileController,
                                              hint: STRING_mobileNo.tr,
                                              prefixWidget: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  countryCode(
                                                      controller: controller,
                                                      bool: true),
                                                  Container(
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .only(end: 10),
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
                                                    !GetUtils.isPhoneNumber(
                                                        value))
                                                  return STRING_EnterValidMobile
                                                      .tr;
                                                else if (value.length < 8 &&
                                                    !GetUtils.isPhoneNumber(
                                                        value))
                                                  return STRING_EnterValidMobile
                                                      .tr;
                                                else
                                                  return null;
                                              },
                                              keyboardType: TextInputType.phone,
                                              focusNode:
                                                  controller.mobileFocusNode),
                                          InputFieldMobileWidget(),
                                        ],
                                      ),
                                      vGap(20),
                                      InputFieldWidget(
                                          controller:
                                              controller.emailController,
                                          /* enable:
                                              title == STRING_EnterComplete.tr
                                                  ? true
                                                  : false,*/
                                          label: STRING_email.tr,
                                          hint: STRING_email.tr,
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return STRING_EnterEmail.tr;
                                            else
                                              return null;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          focusNode: controller.emailFocusNode),
                                      vGap(DIMENS_20),
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ctextFormField(
                                              onTap: () {
                                                _openDropdown(_key);
                                              },
                                              readOnly: true,
                                              controller:
                                                  controller.genderController,
                                              label: STRING_selectGender.tr,
                                              hintText: STRING_selectGender.tr,
                                              suffix: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: Colors.black,
                                                size: DIMENS_30,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty)
                                                  return STRING_EnterGender.tr;
                                                else
                                                  return null;
                                              },
                                              textInputType:
                                                  TextInputType.phone,
                                              focusNode:
                                                  controller.genderFocusNode),
                                          Positioned(
                                            bottom: -50,
                                            left: 20,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        DIMENS_10),
                                                key: _key,
                                                // value: selectedRole,
                                                // style: TextStyle(color: Colors.transparent),
                                                // dropdownColor: Colors.transparent,
                                                iconEnabledColor:
                                                    Colors.transparent,
                                                items: <String>[
                                                  STRING_Male.tr,
                                                  STRING_Female.tr,
                                                  STRING_Other.tr,
                                                ].map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Container(
                                                        width: Get.width - 130,
                                                        child: Text(
                                                          value,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: textStyle(),
                                                        )),
                                                  );
                                                }).toList(),
                                                onChanged: (temp) {
                                                  controller
                                                      .updateGender(temp!);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      vGap(DIMENS_20),

                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ctextFormField(
                                            onTap: () {
                                              showCountryPicker(
                                                context: context,
                                                countryListTheme:
                                                    CountryListThemeData(
                                                  flagSize: 25,
                                                  backgroundColor: Colors.white,
                                                  textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        FONT_14, //textTheme.bodyText1!.fontSize,
                                                    fontWeight: textTheme
                                                        .bodyText1!.fontWeight,
                                                  ),
                                                  bottomSheetHeight:
                                                      500, // Optional. Country list modal height
                                                  //Optional. Sets the border radius for the bottomsheet.
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                  //Optional. Styles the search field.
                                                  inputDecoration:
                                                      InputDecoration(
                                                    labelText:
                                                        STRING_selectNationality
                                                            .tr,
                                                    hintText:
                                                        STRING_selectNationality
                                                            .tr,
                                                    prefixIcon: const Icon(
                                                      Icons.search,
                                                      color: Colors.grey,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(),
                                                    ),
                                                  ),
                                                ),
                                                onSelect: (Country country) => {
                                                  controller
                                                      .nationalityController
                                                      .text = country.name
                                                },
                                              );
                                            },
                                            readOnly: true,
                                            controller: controller
                                                .nationalityController,
                                            label: STRING_selectNationality.tr,
                                            hintText:
                                                STRING_selectNationality.tr,
                                            suffix: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Colors.black,
                                              size: DIMENS_30,
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty)
                                                return STRING_EnterNation.tr;
                                              else
                                                return null;
                                            },
                                            focusNode:
                                                controller.nationalityFocusNode,
                                          )
                                          //     textInputType:
                                          //         TextInputType.phone,
                                          //     focusNode: controller
                                          //         .nationalityFocusNode),
                                          // controller.nationalitiesResponseModel!
                                          //             .list !=
                                          //         null
                                          //     ? Positioned(
                                          //         bottom: -50,
                                          //         left: 20,
                                          //         child:
                                          //             DropdownButtonHideUnderline(
                                          //           child: DropdownButton<
                                          //               Nationalities>(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     DIMENS_10),
                                          //             key: _nationalityKey,
                                          //             // value: selectedRole,
                                          //             // style: TextStyle(color: Colors.transparent),
                                          //             // dropdownColor: Colors.transparent,
                                          //             iconEnabledColor:
                                          //                 Colors.transparent,
                                          //             items: controller
                                          //                 .nationalitiesResponseModel!
                                          //                 .list!
                                          //                 .map((Nationalities
                                          //                     value) {
                                          //               return DropdownMenuItem<
                                          //                   Nationalities>(
                                          //                 value: value,
                                          //                 child: Container(
                                          //                     width: Get.width -
                                          //                         130,
                                          //                     child: Text(
                                          //                       value.name!,
                                          //                       overflow:
                                          //                           TextOverflow
                                          //                               .ellipsis,
                                          //                       style:
                                          //                           textStyle(),
                                          //                     )),
                                          //               );
                                          //             }).toList(),
                                          //             onChanged: (temp) {
                                          //               controller
                                          //                   .updateNationalities(
                                          //                       temp!.name!);
                                          //               print(controller
                                          //                   .updateNationalities(
                                          //                   temp.name!));
                                          //             },
                                          //           ),
                                          //         ),
                                          //       )
                                          //     : Container(),
                                        ],
                                      ),

                                      // Stack(
                                      //   clipBehavior: Clip.none,
                                      //   children: [
                                      //     ctextFormField(
                                      //         onTap: () {
                                      //           controller.nationalitiesResponseModel!
                                      //                           .list ==
                                      //                       null ||
                                      //                   controller
                                      //                           .nationalitiesResponseModel!
                                      //                           .list!
                                      //                           .length ==
                                      //                       0
                                      //               ? null
                                      //               : _openDropdown(
                                      //                   _nationalityKey);
                                      //         },
                                      //         readOnly: true,
                                      //         controller: controller
                                      //             .nationalityController,
                                      //         label:
                                      //             STRING_selectNationality.tr,
                                      //         hintText:
                                      //             STRING_selectNationality.tr,
                                      //         suffix: Icon(
                                      //           Icons
                                      //               .keyboard_arrow_down_rounded,
                                      //           color: Colors.black,
                                      //           size: DIMENS_30,
                                      //         ),
                                      //         validator: (value) {
                                      //           if (value!.isEmpty)
                                      //             return STRING_EnterNation.tr;
                                      //           else
                                      //             return null;
                                      //         },
                                      //         textInputType:
                                      //             TextInputType.phone,
                                      //         focusNode: controller
                                      //             .nationalityFocusNode),
                                      //     controller.nationalitiesResponseModel!
                                      //                 .list !=
                                      //             null
                                      //         ? Positioned(
                                      //             bottom: -50,
                                      //             left: 20,
                                      //             child:
                                      //                 DropdownButtonHideUnderline(
                                      //               child: DropdownButton<
                                      //                   Nationalities>(
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(
                                      //                         DIMENS_10),
                                      //                 key: _nationalityKey,
                                      //                 // value: selectedRole,
                                      //                 // style: TextStyle(color: Colors.transparent),
                                      //                 // dropdownColor: Colors.transparent,
                                      //                 iconEnabledColor:
                                      //                     Colors.transparent,
                                      //                 items: controller
                                      //                     .nationalitiesResponseModel!
                                      //                     .list!
                                      //                     .map((Nationalities
                                      //                         value) {
                                      //                   return DropdownMenuItem<
                                      //                       Nationalities>(
                                      //                     value: value,
                                      //                     child: Container(
                                      //                         width: Get.width -
                                      //                             130,
                                      //                         child: Text(
                                      //                           value.name!,
                                      //                           overflow:
                                      //                               TextOverflow
                                      //                                   .ellipsis,
                                      //                           style:
                                      //                               textStyle(),
                                      //                         )),
                                      //                   );
                                      //                 }).toList(),
                                      //                 onChanged: (temp) {
                                      //                   controller
                                      //                       .updateNationalities(
                                      //                           temp!.name!);
                                      //                   print(controller
                                      //                       .updateNationalities(
                                      //                       temp.name!));
                                      //                 },
                                      //               ),
                                      //             ),
                                      //           )
                                      //         : Container(),
                                      //   ],
                                      // ),
                                      vGap(DIMENS_20),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              text(STRING_address.tr,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: FONT_14),
                                              InkWell(
                                                onTap: () {
                                                  controller.showPlacePicker();
                                                },
                                                child: imageAsset(ICON_address,
                                                    height: DIMENS_30),
                                              )
                                            ],
                                          )),
                                      vGap(DIMENS_20),
                                      ctextFormField(
                                          readOnly: true,
                                          onTap: () {
                                            controller.showPlacePicker();
                                          },
                                          controller:
                                              controller.houseNoController,
                                          label: STRING_houseNo.tr,
                                          hintText: STRING_houseNo.tr,
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return STRING_EnterHouseNo.tr;
                                            else
                                              return null;
                                          },
                                          textInputType:
                                              TextInputType.streetAddress,
                                          focusNode:
                                              controller.houseNoFocusNode),
                                      vGap(DIMENS_20),
                                      ctextFormField(
                                          readOnly: true,
                                          onTap: () {
                                            controller.showPlacePicker();
                                          },
                                          controller:
                                              controller.streetController,
                                          label: STRING_street.tr,
                                          hintText: STRING_street.tr,
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return STRING_EnterStreet.tr;
                                            else
                                              return null;
                                          },
                                          textInputType:
                                              TextInputType.streetAddress,
                                          focusNode:
                                              controller.streetFocusNode),
                                      vGap(DIMENS_20),
                                      ctextFormField(
                                          readOnly: true,
                                          onTap: () {
                                            controller.showPlacePicker();
                                          },
                                          controller: controller
                                              .additionalInfoController,
                                          label: STRING_additionalInfo.tr,
                                          hintText: STRING_additionalInfo.tr,
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return STRING_EnterAddiNfo.tr;
                                            else
                                              return null;
                                          },
                                          textInputType:
                                              TextInputType.streetAddress,
                                          focusNode: controller
                                              .additionalInfoFocusNode),
                                      vGap(DIMENS_20),
                                      title == STRING_EnterComplete.tr
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () async {
                                                  var data = await Get.to(
                                                      AddFamilyMember());
                                                  if (data != null) {
                                                    controller
                                                        .hitGetFamilyMembersListAPI();
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    text(
                                                        STRING_addFamilyMembers
                                                            .tr,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: FONT_15),
                                                    Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                ),
                                              ))
                                          : Container(),
                                      controller.familyMembersListResponseModel
                                                      ?.list?.length !=
                                                  null ||
                                              controller
                                                      .familyMembersListResponseModel
                                                      ?.list
                                                      ?.length !=
                                                  0
                                          ? familyMemberList(controller)
                                          : Container(),
                                      vGap(DIMENS_20),
                                      // cbtnElevatedButton(
                                      //     onPressed: () {
                                      //       if (formGlobalKey.currentState!
                                      //           .validate()) {
                                      //         controller.hitUpdateProfileAPI();
                                      //       }
                                      //     },
                                      //     shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(
                                      //                 DIMENS_8)),
                                      //     height: DIMENS_50,
                                      //     label: STRING_save.tr,
                                      //     backgroundColor: appColor),
                                    ],
                                  )),
                            ),
                            PositionedDirectional(
                                start: 0,
                                top: 0,
                                end: 0,
                                child: userImage(controller)),
                            PositionedDirectional(
                              top: 0,
                              end: 0,
                              child: InkWell(
                                onTap: () {
                                  if (formGlobalKey.currentState!.validate()) {
                                    controller.hitUpdateProfileAPI();
                                  }
                                },
                                child: Container(
                                  width: 80,
                                  height: 25,
                                  margin: EdgeInsets.only(top: 51),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(10),
                                      bottomStart: Radius.circular(10),
                                    ),
                                    color: buttonColor,
                                  ),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                        hGap(4),
                                        Text(
                                          STRING_save.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        vGap(32),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  familyMemberList(CompleteProfileController controller) {
    return ListView.builder(
      itemCount: controller.familyMembersListResponseModel?.list?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = controller.familyMembersListResponseModel?.list?[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.blueGrey.shade50,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        vGap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: text('${STRING_name.tr}:',
                                    color: indigoColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FONT_14)),
                            hGap(20),
                            Expanded(
                                flex: 3,
                                child: text(item?.name ?? '',
                                    color: indigoColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FONT_14)),
                          ],
                        ),
                        vGap(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: text('${STRING_relation.tr}:',
                                    color: indigoColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FONT_14)),
                            hGap(20),
                            Expanded(
                                flex: 3,
                                child: text((item?.relation ?? ''),
                                    color: indigoColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FONT_14)),
                          ],
                        ),
                        vGap(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: text('${STRING_contact.tr}:',
                                    color: indigoColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FONT_14)),
                            hGap(20),
                            Expanded(
                                flex: 3,
                                child: text(
                                    (item?.countryCode ?? '') +
                                        ' ' +
                                        (item?.contactNo ?? ''),
                                    color: indigoColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FONT_14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(AddFamilyMember(
                                item: item,
                              ));
                            },
                            child: Icon(Icons.edit_rounded)),
                        vGap(20.0),
                        InkWell(
                            onTap: () {
                              openCustomDialogue(
                                  customText:
                                      "${STRING_AreYouDelete.tr} ${controller.familyMembersListResponseModel?.list?[index].name} ?",
                                  onYes: () {
                                    controller.hitDeleteFamilyMembersAPI(
                                        controller
                                            .familyMembersListResponseModel
                                            ?.list?[index]
                                            .id);
                                  },
                                  onNo: () {
                                    Get.back();
                                  });
                            },
                            child: Icon(Icons.delete)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  userImage(CompleteProfileController controller) {
    return Center(
      child: GestureDetector(
        onTap: () {
          controller.updateProfilePhoto();
        },
        child: Stack(
          children: [
            Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(Get.context!).cardColor,
                    width: 2,
                  ),
                  color: Color(0xff298999),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: controller.profileFile != '' ||
                        controller.networkImage != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(DIMENS_80),
                        child: controller.profileFile != ''
                            ? imageFile(File(controller.profileFile),
                                fit: BoxFit.cover,
                                height: DIMENS_80,
                                width: DIMENS_80)
                            : imageNetwork(imageUrl + controller.networkImage,
                                fit: BoxFit.contain,
                                height: DIMENS_80,
                                width: DIMENS_80))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(DIMENS_80),
                        child: imageAsset(ICON_defaultUserProfile))),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(color: COLOR_middleblue),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 3)
                      ]),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: buttonColor,
                    size: 18,
                  )),
            )
          ],
        ),
      ),
    );
  }

  fieldName({title, subtitle}) {
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: text(title, fontWeight: FontWeight.w400),
      isThreeLine: false,
      subtitle: text(subtitle, color: indigoColor, fontWeight: FontWeight.w600),
    );
  }

  divider() {
    return Divider(
      color: Colors.grey,
    );
  }

  final GlobalKey _key = GlobalKey(debugLabel: 'key');
  final GlobalKey _nationalityKey = GlobalKey(debugLabel: '_nationalityKey');

  _openDropdown(_key) {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector?;
          return;
        } else {
          searchForGestureDetector(element);
        }

        return;
      });
    }

    searchForGestureDetector(_key.currentContext!);
    assert(detector != null);

    detector!.onTap!();
  }
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
