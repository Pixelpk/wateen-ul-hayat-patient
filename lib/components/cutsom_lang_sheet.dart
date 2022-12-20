import '../export.dart';
import '../pages/home/presentation/controllers/bottom_navigation_controller.dart';
import 'custom_bottom_sheet.dart';

openCustomLanguageDialogue(
    {required Function onYes,
      required Function onNo,
      required String customText,required BottomNavigationController controller}) {
  bottomSheet(
      widget: buildBody(
          customText: customText, onNo: onNo, onYes: onYes,controller: controller));}

/*============================================================ build body of the camera dilaog  =========================================================*/

buildBody(
    {required Function onYes,
      required Function onNo,
      required String customText,required BottomNavigationController controller}) =>
    Container(
        margin: EdgeInsets.all(20.0),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _title(customText: customText)),
            vGap(20.0),
            _noOption(onNo: onNo,controller: controller),
            vGap(10.0),
            _yesOption(onYes: onYes,controller: controller)
          ],
        ));

/*===================================================================== bootom sheet title   =========================================================*/

_title({customText}) =>
    text(customText, fontWeight: FontWeight.bold, fontSize: 25,maxLines: 2,textAlign: TextAlign.center);

/*=====================================================================camera option choosed   =========================================================*/

_noOption({required Function onNo,required BottomNavigationController controller}) => getInkWell(
    child: Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          // imageAsset(noImage, width: 50.0, height: 50.0),
          Radio(
              activeColor: COLOR_middleBlueM,
              value: 1,
              groupValue: controller.langVal,
              onChanged: (int? value) {
                controller.langVal = value!;
                controller.update();
              }),
          hGap(10.0),
          text("English", fontWeight: FontWeight.bold,fontSize: 20.0)
        ],
      ),
    ),
    onTap: () {
      onNo();
    });

/*==============================================================gallery option choosed   =========================================================*/

_yesOption({required Function onYes,required BottomNavigationController controller}) => getInkWell(
    child: Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          // imageAsset(yesImage, width: 50.0, height: 50.0),
          Radio(
              activeColor: COLOR_middleBlueM,
              value: 2,
              groupValue: controller.langVal,
              onChanged: (int? value) {
                controller.langVal = value!;
                controller.update();
              }),
          hGap(10.0),
          text("عربي", fontWeight: FontWeight.bold,fontSize: 20.0)
        ],
      ),
    ),
    onTap: () {
      onYes();
    });
