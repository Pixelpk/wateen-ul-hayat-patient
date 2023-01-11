import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/signup_controller.dart';
import 'package:swift_care/pages/authentication/presentation/views/set_new_pass_screen.dart';
import '../../../../export.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String? phoneNo;

  VerifyOtpScreen({this.phoneNo});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;

    return GetBuilder<SignUpController>(builder: (controller) {
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
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        Image.asset(
                          ICON_appLogo,
                          width: Get.width * 0.4,
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.08),
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.08,
                              vertical: Get.height * 0.05),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color(0x11000000),
                                blurRadius: 32,
                                offset: Offset(0, 6),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    STRING_authentication.tr,
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
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: STRING_enterThe.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                    ),
                                    TextSpan(
                                      text: STRING_authenticationCode.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: STRING_weHaveSentYouOn.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                    ),
                                    TextSpan(
                                      text: widget.phoneNo ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                          color: Theme.of(context)
                                              .primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              _otpFields(controller, context),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    if (controller.otpController.text.length == 4) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SetNewPassword(otp: controller.otpController.text,)));
                                      // SetNewPassword(otp: controller.otpController.text,);
                                      // controller.hitVerifyOTPApi(widget.changePswd);
                                    } else {
                                      snackBar(STRING_EnterOtp.tr);
                                    }
                                  },
                                  child: Container(
                                    width: 140,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: <BoxShadow>[
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
                                        STRING_Submit.tr.toUpperCase(),
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
                              ),
                              vGap(DIMENS_20),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    controller.hitResendOTPApi();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.refresh,
                                        color: primaryColor,
                                      ),
                                      hGap(6),
                                      text(
                                        STRING_EnterResend.tr,
                                        maxLines: 2,
                                        fontSize: FONT_12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                      ],
                    ),
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

      ///-------------------Old Code----------------
      //   SafeArea(
      //   child: Scaffold(
      //       appBar: backAppBar2(
      //         context:context,
      //       ),
      //       body: Padding(
      //         padding: EdgeInsets.fromLTRB(
      //             DIMENS_16, DIMENS_10, DIMENS_16, DIMENS_16),
      //         child: Column(
      //           children: [
      //             Expanded(
      //               child: SingleChildScrollView(
      //                 child: Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       text(
      //                         STRING_enterVerificationCode.tr,
      //                         maxLines: 2,
      //                         fontSize: FONT_22,
      //                         fontWeight: FontWeight.bold,
      //                         textAlign: TextAlign.start,
      //                       ),
      //                       vGap(DIMENS_10),
      //                       text(
      //                         STRING_enterVerificationCodeDesc.tr,
      //                         maxLines: 5,
      //                         fontSize: FONT_16,
      //                         color: Colors.black54,
      //                         textAlign: TextAlign.start,
      //                       ),
      //                       vGap(DIMENS_30),
      //                       _otpFields(controller),
      //                       vGap(DIMENS_50),
      //                       cbtnElevatedButton(
      //                           onPressed: () {
      //                             if(controller.otpController.text.length==4) {
      //                               controller.hitVerifyOTPApi(changePswd);
      //                             }else{
      //                               snackBar(STRING_EnterOtp.tr);
      //                             }
      //
      //                           },
      //                           shape: RoundedRectangleBorder(
      //                               borderRadius:
      //                                   BorderRadius.circular(DIMENS_8)),
      //                           height: DIMENS_50,
      //                           label: STRING_sendTxt.tr,
      //                           backgroundColor: appColor),
      //                       vGap(DIMENS_20),
      //                       Center(
      //                         child: InkWell(
      //                           onTap: (){
      //                             controller.hitResendOTPApi();
      //                           },
      //                           child: text(
      //                             STRING_EnterResend.tr,
      //                             maxLines: 2,
      //                             fontSize: FONT_16,
      //                             color: indigoColor,
      //                             fontWeight: FontWeight.w500,
      //                             textAlign: TextAlign.start,
      //                           ),
      //                         ),
      //                       ),
      //                       vGap(DIMENS_20),
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

  _otpFields(SignUpController controller, BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Form(
        key: formGlobalKey,
        child: PinPut(
          preFilledWidget: text(''),
          eachFieldHeight: 60,
          eachFieldWidth: 50,
          fieldsCount: 4,
          withCursor: true,
          textStyle: Theme.of(context).textTheme.subtitle1,
          focusNode: controller.otpFocusNode,
          controller: controller.otpController,
          validator: (value) {
            if (value!.isEmpty)
              return STRING_EnterOtp.tr;
            else if (value.length < 4)
              return STRING_EnterFields.tr;
            else
              return null;
          },
          eachFieldMargin: EdgeInsets.symmetric(horizontal: 1),
          disabledDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: indigoColor),
          ),
          inputDecoration: InputDecoration(
            hintText: '',
            counterText: '',
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          submittedFieldDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: indigoColor),
            // color: Color(0xfff5f5f5),
          ),
          selectedFieldDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
            // color: Color(0xfff5f5f5),
          ),
          followingFieldDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: indigoColor),
            // color: Color(0xfff5f5f5),
          ),
        ),
      ),
    );
  }
}
