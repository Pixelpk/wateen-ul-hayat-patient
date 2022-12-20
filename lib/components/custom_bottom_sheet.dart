import 'package:get/get.dart';

import '../export.dart';
import 'common_widget.dart';

bottomSheet({widget}) {
  return showModalBottomSheet(
      enableDrag: true,
      context: Get.context!,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (BuildContext context) {
        return buildBottomSheetUi(widget: widget);
      });
}

buildBottomSheetUi({widget}) => Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildNotch(),
          widget,
        ],
      ),
    );

buildNotch() => Container(
      width: 150.0,
      height: 5.0,
      decoration: decorationBox(
          borderWidth: 0.0,
          borderColor: buttonColor,
          cornerRaduis: 5.0,
          backgroundColor: buttonColor),
      margin: EdgeInsets.symmetric(vertical: 10.0),
    );
