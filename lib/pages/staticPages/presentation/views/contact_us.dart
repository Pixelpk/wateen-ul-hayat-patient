import 'package:swift_care/components/common_widget.dart';
import 'package:swift_care/components/custom_appbar.dart';
import 'package:swift_care/components/custom_text.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/inputfield_widget.dart';

import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';

import '../../../../components/primary_button.dart';
import '../../../../export.dart';

class ContactUs extends StatefulWidget {
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var formGlobalKey = GlobalKey<FormState>();

  StaticPageController controller = Get.put(StaticPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticPageController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: DefaultAppBar(
            title: STRING_ContactUs.tr,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: 50),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    padding:
                        EdgeInsets.symmetric(vertical: 30, horizontal: hMargin),
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
                              controller: controller.nameController,
                              label: STRING_fullName.tr,
                              hint: STRING_fullName.tr,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return STRING_Pleaseenterfullname.tr;
                                else
                                  return null;
                              },
                              keyboardType: TextInputType.name,
                              focusNode: controller.nameFocusNode),
                          vGap(DIMENS_25),
                          InputFieldWidget(
                              controller: controller.emailController,
                              label: STRING_email.tr,
                              hint: STRING_email.tr,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return STRING_Pleaseenteremailaddress.tr;
                                else
                                  return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              focusNode: controller.emailFocusNode),
                          vGap(DIMENS_25),
                          InputFieldWidget(
                              maxLength: 9,
                              controller: controller.mobileController,
                              label: STRING_mobileNo.tr,
                              hint: STRING_mobileNo.tr,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return STRING_EnterMobile.tr;
                                else if (value.length > 0 &&
                                    !GetUtils.isPhoneNumber(value))
                                  return STRING_EnterValidMobile.tr;
                                else
                                  return null;
                              },
                              keyboardType: TextInputType.number,
                              focusNode: controller.mobileFocusNode),
                          vGap(DIMENS_25),
                          InputFieldWidget(
                              controller: controller.subjectController,
                              label: STRING_Subject.tr,
                              hint: STRING_Subject.tr,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return STRING_Pleaseentersubject.tr;
                                else
                                  return null;
                              },
                              keyboardType: TextInputType.text,
                              focusNode: controller.subjectFocusNode),
                          vGap(DIMENS_25),
                          InputFieldWidget(
                              controller: controller.messageController,
                              maxLines: 6,
                              label: STRING_YourMessage.tr,
                              hint: STRING_YourMessage.tr,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return STRING_Pleaseenteryourmessage.tr;
                                else
                                  return null;
                              },
                              keyboardType: TextInputType.text,
                              focusNode: controller.messageFocusNode),
                        ],
                      ),
                    ),
                  ),
                  vGap(30),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: hMargin),
                    child: PrimaryButton(buttonText: STRING_Submit.tr, onPressed: () {    if (formGlobalKey.currentState!.validate()) {
                      controller.hitContactUsApi();
                    } },),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
