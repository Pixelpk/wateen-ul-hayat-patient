import '../export.dart';
import 'custom_bottom_sheet.dart';

openCustomDialogue(
        {required Function onYes,
        required Function onNo,
        required String customText}) {
    bottomSheet(
        widget: buildBody(
            customText: customText, onNo: onNo, onYes: onYes));}

/*============================================================ build body of the camera dilaog  =========================================================*/

buildBody(
        {required Function onYes,
        required Function onNo,
        required String customText}) =>
    Container(
        margin: EdgeInsets.all(20.0),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(customText: customText),
            vGap(20.0),
            _noOption(onNo: onNo),
            vGap(10.0),
            _yesOption(onYes: onYes)
          ],
        ));

/*===================================================================== bootom sheet title   =========================================================*/

_title({customText}) =>
    text(customText, fontWeight: FontWeight.bold, fontSize: 25,maxLines: 2,textAlign: TextAlign.center);

/*=====================================================================camera option choosed   =========================================================*/

_noOption({required Function onNo}) => getInkWell(
    child: Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          imageAsset(noImage, width: 50.0, height: 50.0),
          hGap(10.0),
          text(STRING_No.tr, fontWeight: FontWeight.bold,fontSize: 20.0)
        ],
      ),
    ),
    onTap: () {
      onNo();
    });

/*==============================================================gallery option choosed   =========================================================*/

_yesOption({required Function onYes}) => getInkWell(
    child: Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          imageAsset(yesImage, width: 50.0, height: 50.0),
          hGap(10.0),
          text(STRING_yes.tr, fontWeight: FontWeight.bold,fontSize: 20.0)
        ],
      ),
    ),
    onTap: () {
      onYes();
    });
