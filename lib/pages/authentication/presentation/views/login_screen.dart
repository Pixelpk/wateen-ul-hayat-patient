import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/loginController.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/signup_controller.dart';
import 'package:swift_care/pages/authentication/presentation/views/forget_screen.dart';
import 'package:swift_care/pages/authentication/presentation/views/signup_screen.dart';
import '../../../../components/inputfield_widget.dart';
import '../../../../export.dart';
import '../../../../utils/projectutils/prefic_widget.dart';

class LoginScreen extends StatelessWidget {
  var ctrl = Get.put(LoginController());
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: Get.height - safePadding,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Column(children: [
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Center(
                                child: Image.asset(
                                  ICON_appLogo,
                                  width: Get.width * 0.4,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03),
                                width: 80,
                                child: PopupMenuButton(
                                    onSelected: (String value) async {
                                      controller.dropValue = value;
                                      controller.update();
                                      if (value == STRING_english.tr) {
                                        storage.write(LOCALKEY_english, true);
                                        Get.updateLocale(Locale('en', 'US'));
                                      } else {
                                        storage.write(LOCALKEY_english, false);
                                        Get.updateLocale(Locale('ar', 'DZ'));
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    offset: Offset(-10, 20),
                                    padding: EdgeInsets.all(6),
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            value: STRING_english.tr,
                                            child: Text(
                                              STRING_english.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            value: STRING_arabic.tr,
                                            child: Text(
                                              STRING_arabic.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ),
                                        ],
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/global_icon.svg"),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          controller.dropValue!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.08),
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.08,
                                vertical: Get.height * 0.03),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x11000000),
                                  blurRadius: 32,
                                  offset: Offset(0, 6),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      STRING_login.tr,
                                      style: TextStyle(
                                        color: Color(0xff444444),
                                        fontSize: 22,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  color: Color(0xff08bede),
                                  height: 2,
                                  width: Get.width,
                                ),
                                SizedBox(
                                  height: Get.height * 0.04,
                                ),
                                Form(
                                  key: formGlobalKey,
                                  child: Column(
                                    children: [
                                      InputFieldWidget(
                                        controller: controller.mobileController,
                                        showUnderLineBorder: true,
                                        isFill: false,
                                        hint: STRING_mobileNo.tr,
                                        maxLength: 9,
                                        prefixWidget: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 12,
                                            ),
                                            SvgPicture.asset(
                                              "assets/images/person.svg",
                                              width: 12,
                                            ),
                                            countryCode(
                                                controller: controller,
                                                bool: true),
                                            Container(
                                              width: 2,
                                              height: 15,
                                              color: Color(0xffE5E5E5),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                          ],
                                        ),
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value!.isEmpty)
                                            return STRING_EnterMobile.tr;
                                          else if (value.length > 0 &&
                                              !GetUtils.isPhoneNumber(value))
                                            return STRING_EnterValidMobile.tr;
                                          else if (value.length < 8 &&
                                              !GetUtils.isPhoneNumber(value))
                                            return STRING_EnterValidMobile.tr;
                                          else
                                            return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      InputFieldWidget(
                                        controller:
                                            controller.passwordController,
                                        showUnderLineBorder: true,
                                        isFill: false,
                                        hint: STRING_pswd.tr,
                                        // prefixIcon: Icons.lock,
                                        prefixWidget: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 12,
                                            ),
                                            SvgPicture.asset(
                                              "assets/icons/lock.svg",
                                              width: 12,
                                            ),
                                            SizedBox(
                                              width: 13,
                                            ),
                                          ],
                                        ),
                                        // prefixImage:
                                        //     "assets/images/password.svg",
                                        isSvg: true,
                                        showObscureByText: true,
                                        obscure: true,
                                        focusNode: controller.passwordFocusNode,
                                        validator: (value) {
                                          if (value!.isEmpty)
                                            return STRING_EnterPassword.tr;
                                          else if (value.length < 8)
                                            return STRING_ValidPassword.tr;
                                          else
                                            return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                        scale: 0.8,
                                        child: Checkbox(
                                            value: controller.rememberMe,
                                            activeColor: Colors.black,
                                            splashRadius: 0.0,
                                            fillColor: MaterialStateProperty
                                                .all<Color>(Theme.of(context)
                                                    .primaryColor),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            onChanged: (val) {
                                              controller.updateRememberMe();
                                            })),
                                    Text(
                                      STRING_rememberMe.tr,
                                      style: TextStyle(
                                        color: Color(0xff737373),
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      controller.hitLoginAPI();
                                    }
                                  },
                                  child: Container(
                                    width: 140,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
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
                                        STRING_login.tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(ForgetScreen());
                                  },
                                  child: Text("${STRING_forgotPswd.tr}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: STRING_dontHaveAccount.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                TextSpan(
                                  text: " " + STRING_signupWithSpace.tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      controller.clearFields();
                                      var ctrll = Get.put(SignUpController());
                                      ctrll.getLanguageData();
                                      Get.offAll(SignUpScreen());
                                    },
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        Container(
                          height: Get.height * 0.1,
                          child: SvgPicture.asset(
                            "assets/images/bottom_curve.svg",
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));

          ///---------------------Old Code--------------

          //   SafeArea(
          //   child: Scaffold(
          //       appBar: backAppBar2(
          //           leading: Container(),
          //           elevation: 0.0,
          //           context: context,
          //           actions: [_languageDrpDown(controller)]),
          //       body: Padding(
          //         padding: EdgeInsets.fromLTRB(
          //             DIMENS_14, DIMENS_32, DIMENS_14, DIMENS_16),
          //         child: Column(
          //           children: [
          //             Expanded(
          //               child: SingleChildScrollView(
          //                 child: Padding(
          //                   padding:
          //                       const EdgeInsets.symmetric(horizontal: 14.0),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Center(
          //                           child: imageAsset(ICON_appLogo,
          //                               height: DIMENS_70)),
          //                       vGap(DIMENS_30),
          //                       text(
          //                         STRING_welcome.tr,
          //                         maxLines: 2,
          //                         fontSize: FONT_22,
          //                         fontWeight: FontWeight.bold,
          //                         textAlign: TextAlign.center,
          //                       ),
          //                       text(
          //                         STRING_signInToYourAcc.tr,
          //                         maxLines: 2,
          //                         fontSize: FONT_16,
          //                         color: Colors.black87,
          //                         textAlign: TextAlign.center,
          //                       ),
          //                       vGap(DIMENS_60),
          //                       Form(
          //                           key: formGlobalKey,
          //                           child: Column(
          //                             children: [
          //                               Padding(
          //                                 padding:  EdgeInsets.symmetric(horizontal: 5.0),
          //                                 child: ctextFormFieldMobile(
          //                                     controller:
          //                                         controller.mobileController,
          //                                     label: STRING_mobileNo.tr,
          //                                     hintText: STRING_mobileNo.tr,
          //                                     prefix: countryCode(
          //                                         controller: controller,
          //                                         bool: true),
          //                                     maxLength: 9,
          //                                     validator: (value) {
          //                                       if (value!.isEmpty)
          //                                         return STRING_EnterValidMobile
          //                                             .tr;
          //                                       else if (value.length > 0 &&
          //                                           !GetUtils.isPhoneNumber(
          //                                               value))
          //                                         return STRING_EnterValidMobile
          //                                             .tr;
          //                                       else if (value.length < 8 &&
          //                                           !GetUtils.isPhoneNumber(
          //                                               value))
          //                                         return STRING_EnterValidMobile
          //                                             .tr;
          //                                       else
          //                                         return null;
          //                                     },
          //                                     textInputType: TextInputType.phone,
          //                                     focusNode:
          //                                         controller.mobileFocusNode),
          //                               ),
          //                               vGap(DIMENS_20),
          //                               Padding(
          //                                 padding:  EdgeInsets.symmetric(horizontal: 5.0),
          //                                 child: ctextFormField(
          //                                     controller:
          //                                         controller.passwordController,
          //                                     label: STRING_pswd.tr,
          //                                     obsecureText: controller.hidePswd,
          //                                     hintText: STRING_pswd.tr,
          //                                     suffix: InkWell(
          //                                       onTap: () {
          //                                         controller.updateHidePswd();
          //                                       },
          //                                       child: Icon(
          //                                         !controller.hidePswd
          //                                             ? Icons
          //                                                 .visibility_off_outlined
          //                                             : Icons.visibility_outlined,
          //                                         color: Colors.grey,
          //                                       ),
          //                                     ),
          //                                     validator: (value) {
          //                                       if (value!.isEmpty)
          //                                         return STRING_EnterPassword.tr;
          //                                       else
          //                                         return null;
          //                                     },
          //                                     focusNode:
          //                                         controller.passwordFocusNode),
          //                               ),
          //                             ],
          //                           )),
          //                       vGap(DIMENS_15),
          //                       Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Flexible(
          //                             fit: FlexFit.loose,
          //                             child: RichText(
          //                               text: TextSpan(
          //                                 style: textStyle(
          //                                     color: Colors.black,
          //                                     fontSize: Theme.of(Get.context!)
          //                                         .textTheme
          //                                         .bodyText1
          //                                         ?.fontSize),
          //                                 children: [
          //                                   WidgetSpan(
          //                                     child: hGap(DIMENS_5),
          //                                   ),
          //                                   WidgetSpan(
          //                                     child: InkWell(
          //                                       onTap: () {
          //                                         controller.updateRememberMe();
          //                                       },
          //                                       child: Image.asset(
          //                                         ICON_checkBox,
          //                                         height: DIMENS_16,
          //                                         color: controller.rememberMe
          //                                             ? lightBlue
          //                                             : Colors.grey.shade300,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   WidgetSpan(
          //                                     child: hGap(DIMENS_5),
          //                                   ),
          //                                   TextSpan(
          //                                     text: STRING_rememberMe.tr,
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                           Flexible(
          //                             fit: FlexFit.loose,
          //                             child: RichText(
          //                               text: TextSpan(
          //                                 style: textStyle(
          //                                     color: Colors.black,
          //                                     fontSize: Theme.of(Get.context!)
          //                                         .textTheme
          //                                         .bodyText1
          //                                         ?.fontSize),
          //                                 children: [
          //                                   WidgetSpan(
          //                                     child: hGap(DIMENS_1),
          //                                   ),
          //                                   WidgetSpan(
          //                                     child: imageAsset(ICON_forgotPswd,
          //                                         height: DIMENS_15),
          //                                   ),
          //                                   WidgetSpan(
          //                                     child: hGap(DIMENS_5),
          //                                   ),
          //                                   TextSpan(
          //                                     recognizer:
          //                                         new TapGestureRecognizer()
          //                                           ..onTap = () =>
          //                                               Get.to(ForgetScreen()),
          //                                     text: STRING_forgotPswd.tr + '?',
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                       vGap(DIMENS_50),
          //                       cbtnElevatedButton(
          //                           onPressed: () {
          //                             if (formGlobalKey.currentState!
          //                                 .validate()) {
          //                               controller.hitLoginAPI();
          //                             }
          //                           },
          //                           shape: RoundedRectangleBorder(
          //                               borderRadius:
          //                                   BorderRadius.circular(DIMENS_8)),
          //                           height: DIMENS_50,
          //                           label: STRING_signIn.tr,
          //                           backgroundColor: appColor),
          //                       vGap(DIMENS_20),
          //                       Center(
          //                         child: RichText(
          //                           textAlign: TextAlign.center,
          //                           text: TextSpan(
          //                             children: [
          //                               TextSpan(
          //                                 text: STRING_newUser.tr + ' ',
          //                                 style: textStyle(
          //                                   fontSize: FONT_14,
          //                                   color: Colors.black,
          //                                   fontWeight: FontWeight.w600,
          //                                 ),
          //                               ),
          //                               TextSpan(
          //                                 text: STRING_createAccount.tr,
          //                                 recognizer: new TapGestureRecognizer()
          //                                   ..onTap = () {
          //                                     var ctrll =
          //                                         Get.put(SignUpController());
          //                                     ctrll.getLanguageData();
          //                                     Get.offAll(SignUpScreen());
          //                                   },
          //                                 style: textStyle(
          //                                   fontSize: FONT_14,
          //                                   color: lightBlue,
          //                                   fontWeight: FontWeight.w600,
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ),
          //                       vGap(DIMENS_20),
          //                       // _skip()
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       )),
          // );
        });
  }

  _skip() {
    return Center(
      child: SizedBox(
        width: DIMENS_80,
        child: cbtnElevatedButton(
            onPressed: () {
              // Get.to(BottomNavigationScreen());
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DIMENS_20)),
            height: DIMENS_30,
            label: STRING_skip.tr,
            backgroundColor: indigoColor),
      ),
    );
  }

  Widget _languageDrpDown(LoginController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Container(
        width: DIMENS_80,
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
        child: Container(
          margin: EdgeInsets.only(right: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              iconSize: 0.0,
              dropdownColor: appColor,
              style: TextStyle(
                color: Colors.black,
              ),
              value: controller.dropValue,
              items: [
                DropdownMenuItem(
                    child: text(STRING_english.tr,
                        color: Colors.white, fontWeight: FontWeight.bold),
                    value: STRING_english.tr),
                DropdownMenuItem(
                    child: text(STRING_arabic.tr,
                        color: Colors.white, fontWeight: FontWeight.bold),
                    value: STRING_arabic.tr),
              ],
              onChanged: (String? value) {
                controller.dropValue = value;
                controller.update();
                if (value == 'en') {
                  storage.write(LOCALKEY_english, true);
                  Get.updateLocale(Locale('en', 'US'));
                } else {
                  storage.write(LOCALKEY_english, false);
                  Get.updateLocale(Locale('ar', 'DZ'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
