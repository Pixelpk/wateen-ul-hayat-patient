import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swift_care/components/inputfield_widget.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/forgot_controller.dart';
import 'package:swift_care/utils/projectutils/prefic_widget.dart';
import '../../../../export.dart';

class ForgetScreen extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    return GetBuilder<ForgotController>(
      init: ForgotController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: Get.height - safePadding,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        vGap(DIMENS_20),
                        _imageView(),
                        vGap(DIMENS_60),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: DIMENS_40, horizontal: DIMENS_32),
                          margin: EdgeInsets.symmetric(
                              horizontal: DIMENS_32, vertical: DIMENS_24),
                          decoration: loginDeco,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: text(
                                  STRING_forgotPswd.tr,
                                  maxLines: 1,
                                  fontSize: FONT_22,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              _divider(),
                              vGap(DIMENS_16),
                              Form(
                                  key: formGlobalKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: InputFieldWidget(
                                      controller: controller.mobileController,
                                      hint: STRING_mobileNo.tr,
                                      isFill: false,
                                      showUnderLineBorder: true,
                                      prefixWidget: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          countryCode(
                                              controller: controller,
                                              bool: true),
                                          Container(
                                            margin: EdgeInsetsDirectional.only(
                                                end: 10,
                                            ),
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
                                        else if (value.length < 8 &&
                                            !GetUtils.isPhoneNumber(value))
                                          return STRING_EnterValidMobile.tr;
                                        else
                                          return null;
                                      },
                                      keyboardType: TextInputType.phone,
                                      focusNode: controller.mobileFocusNode)),
                              vGap(DIMENS_16),
                              cbtnElevatedButton(
                                onPressed: () {
                                  if (formGlobalKey.currentState!.validate()) {
                                    controller.hitForgetAPI();
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(DIMENS_8)),
                                height: DIMENS_50,
                                label: STRING_sendTxt.tr,
                                backgroundColor: buttonColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _bottomImageView(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _divider() {
    return Divider(
      thickness: 2,
      color: buttonColor,
    );
  }

  _imageView() {
    return Container(
      margin: EdgeInsets.only(top: vMargin),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            onTap: () {
              // Get.offAllNamed(Routes.loginWithScreenRoute);
              Get.back();
            },
            child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsetsDirectional.only(
                    start: DIMENS_16, end: DIMENS_16),
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset("assets/icons/back_arrow.svg")),
          ),
          Center(child: imageAsset("assets/icons/logo.png", height: DIMENS_70)),
        ],
      ),
    );
  }

  _countryCode(ForgotController controller) {
    return Container(
      width: DIMENS_50,
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: CountryCodePicker(
        padding: EdgeInsets.zero,
        onChanged: (value) {
          controller.updateSelectedCountryCode(value.dialCode.toString());
        },
        showFlag: false,
        textStyle: textStyle(color: Colors.black),
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: 'US',
        favorite: ['+91', 'IN'],
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
        showDropDownButton: false,
        flagWidth: 25,
      ),
    );
  }

  Widget _bottomImageView() {
    return Transform.translate(
        offset: Offset(0, 20),
        child: SvgPicture.asset("assets/images/bottom_curve.svg"));
  }
}
