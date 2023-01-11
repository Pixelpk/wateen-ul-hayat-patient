import 'package:flutter_svg/svg.dart';
import 'package:swift_care/components/common_widget.dart';
import 'package:swift_care/components/inputfield_widget.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';
import '../../../../export.dart';

class ChangePassword extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;

    return GetBuilder<StaticPageController>(
        init: StaticPageController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                  height: Get.height - safePadding,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vGap(DIMENS_10),
                          _imageView(),
                          vGap(DIMENS_30),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: DIMENS_40, horizontal: DIMENS_32),
                            margin: EdgeInsets.symmetric(
                                horizontal: DIMENS_32, vertical: DIMENS_24),
                            decoration: loginDeco,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: text(
                                    STRING_ChangePassword.tr,
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
                                  child: Column(
                                    children: [
                                      InputFieldWidget(
                                          controller:
                                              controller.oldPasswordController,
                                          hint: '$STRING_EnterOldPassword'.tr,
                                          textInputAction: TextInputAction.next,
                                          showObscureByText: true,
                                          prefixImage:
                                              "assets/images/password.svg",
                                          isSvg: true,
                                          showUnderLineBorder: true,
                                          obscure: true,
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return STRING_EnterOld.tr;
                                            else
                                              return null;
                                          },
                                          focusNode:
                                              controller.oldPasswordFocusNode),
                                      vGap(DIMENS_10),
                                      InputFieldWidget(
                                          controller:
                                              controller.newPasswordController,
                                          showUnderLineBorder: true,
                                          hint: '$STRING_EnterNewPassword'.tr,
                                          textInputAction: TextInputAction.next,
                                          showObscureByText: true,
                                          prefixImage:
                                              "assets/images/password.svg",
                                          isSvg: true,
                                          obscure: true,
                                          onFieldSubmitted: (value) {
                                            focuOnNextEditText(
                                                context: context,
                                                nextFocus: controller
                                                    .confirmPasswordFocusNode);
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return STRING_EnterNew.tr;
                                            else
                                              return null;
                                          },
                                          keyboardType: TextInputType.text,
                                          focusNode:
                                              controller.newPasswordFocusNode),
                                      vGap(DIMENS_10),
                                      InputFieldWidget(
                                          controller: controller
                                              .confirmPasswordController,
                                          hint: '$STRING_ReEnterNewPassword'.tr,
                                          showUnderLineBorder: true,
                                          textInputAction: TextInputAction.done,
                                          isFill: false,
                                          prefixImage:
                                              "assets/images/password.svg",
                                          showObscureByText: true,
                                          isSvg: true,
                                          obscure: true,
                                          validator: (value) {
                                            if (value!.isEmpty)
                                              return STRING_EnterReNew.tr;
                                            else if (value !=
                                                controller
                                                    .newPasswordController.text)
                                              return "$STRING_NotSame".tr;
                                            else
                                              return null;
                                          },
                                          keyboardType: TextInputType.text,
                                          focusNode: controller
                                              .confirmPasswordFocusNode),
                                    ],
                                  ),
                                ),
                                vGap(DIMENS_20),
                                cbtnElevatedButton(
                                    onPressed: () {
                                      if (formGlobalKey.currentState!
                                          .validate()) {
                                        controller.hitChangePasswordAPI();
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(DIMENS_8)),
                                    height: DIMENS_50,
                                    label: '$STRING_Submit'.tr,
                                    backgroundColor: buttonColor),
                              ],
                            ),
                          ),
                        ],
                      ),
                      _bottomImageView(),
                    ],
                  )),
            )),
          );
        });
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
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                margin: EdgeInsetsDirectional.only(start: DIMENS_16),
                padding: const EdgeInsets.all(5.0),
                child: RotatedBox(
                    quarterTurns: (storage.read(LOCALKEY_english) == null
                            ? true
                            : storage.read(LOCALKEY_english))
                        ? 0
                        : 2,
                    child: SvgPicture.asset("assets/icons/back_arrow.svg"))),
          ),
          Center(child: imageAsset("assets/icons/logo.png", height: DIMENS_70)),
        ],
      ),
    );
  }

  Widget _bottomImageView() {
    return Transform.translate(
        offset: Offset(0, 20),
        child: SvgPicture.asset("assets/images/bottom_curve.svg"));
  }
}
