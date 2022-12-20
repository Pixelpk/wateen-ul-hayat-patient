import 'package:swift_care/components/common_widget.dart';
import 'package:swift_care/components/custom_appbar.dart';
import 'package:swift_care/components/custom_text.dart';
import 'package:swift_care/components/mask_formatter.dart';
import 'package:swift_care/pages/service_providers/presentation/controllers/card_controller.dart';
import 'package:swift_care/pages/service_providers/presentation/controllers/card_controller.dart';

import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';

import '../../../../export.dart';

class AddCard extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
        init: CardController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: backAppBar2(
                context: context,
                title: text(STRING_AddCard.tr,
                    fontWeight: FontWeight.w600, fontSize: FONT_18),
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: Get.height * 0.8,
                  padding: EdgeInsets.symmetric(
                      vertical: DIMENS_25, horizontal: DIMENS_20),
                  child: Column(
                    children: [
                      Form(
                        key: formGlobalKey,
                        child: Column(
                          children: [
                            textField(
                                controller: controller.cardNumberController,
                                inputFormatter: [
                                  MaskedTextInputFormatter(
                                      mask: 'xxxx-xxxx-xxxx-xxxx',
                                      separator: '-')
                                ],
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                title: STRING_CardNumber.tr,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return STRING_Card.tr;
                                  else
                                    return null;
                                },
                                msg: STRING_EnterCard.tr),
                            vGap(DIMENS_20),
                            Container(

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: textField(
                                      controller: controller.expiryNoController,
                                      textInputAction: TextInputAction.next,
                                      textInputType: TextInputType.number,
                                      inputFormatter: [
                                        MaskedTextInputFormatter(
                                            mask: 'xx/xx', separator: '/')
                                      ],
                                      title: STRING_exp_date.tr,
                                      msg: STRING_enter_exp_date.tr,
                                      validator: (value) {
                                        if (value!.isEmpty){
                                          return STRING_valid_exp_date.tr;}
                                        else if(value.length != 5){
                                          return STRING_valid_exp_date.tr;
                                        }
                                        else
                                          return null;
                                      },
                                    ),
                                  ),
                                  hGap(DIMENS_20),
                                  Expanded(
                                    child: textField(
                                        controller: controller.cvvController,
                                        textInputAction: TextInputAction.next,
                                        inputFormatter: [
                                          LengthLimitingTextInputFormatter(4),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        textInputType: TextInputType.number,
                                        title: STRING_CVV.tr,
                                        msg: STRING_ENTER_CVV.tr, validator: (value) {
                                      if (value!.isEmpty)
                                        return STRING_please_ENTER_CVV.tr;
                                      else
                                        return null;
                                    },),
                                  )
                                ],
                              ),
                            ),
                            vGap(DIMENS_20),
                            textField(
                                controller: controller.cardNameController,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.name,
                                title: STRING_CardHolderName.tr,
                                msg: STRING_EnterCardHolderName.tr,validator: (value) {
                              if (value!.isEmpty)
                                return STRING_PleaseentervalidHolderName.tr;
                              else
                                return null;
                            }),
                            vGap(DIMENS_50),
                            vGap(DIMENS_20),
                          ],
                        ),
                      ),
                      cbtnElevatedButton(
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              controller.hitAddCardApi();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(DIMENS_8)),
                          height: DIMENS_50,
                          label: STRING_save.tr,
                          backgroundColor: appColor),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  textField(
      {textInputAction,
      textInputType,
      title,
      List<TextInputFormatter>? inputFormatter,
      controller,
      String? validator(String? value)?,
      String? msg}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: textStyle(fontWeight: FontWeight.bold, fontSize: FONT_14),
        ),
        vGap(DIMENS_10),
        TextFormField(
          // readOnly: readOnly,
          controller: controller,
          // focusNode: focusNode,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: 1,
          inputFormatters: inputFormatter,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: appColor,
          style: TextStyle(
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
              color: Colors.black),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            hintText: msg,
            contentPadding: EdgeInsets.fromLTRB(18, 18, 15, 18),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: appColor)),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: textTheme.bodyText1!.fontSize,
                fontWeight: textTheme.bodyText1!.fontWeight),
            helperStyle: TextStyle(
              color: Colors.grey,
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: FONT_18, //textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            prefixStyle: TextStyle(
              color: Colors.grey,
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            fillColor: Colors.grey.shade100,
          ),
        )
      ],
    );
  }
}
