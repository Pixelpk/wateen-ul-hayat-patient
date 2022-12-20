import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:swift_care/utils/utils.dart';

import '../export.dart';

class ConfirmDialogView extends StatelessWidget {
  final String content;
  final String cancelText;
  final String confirmText;

  ConfirmDialogView(
      {required this.content,
      required this.cancelText,
      required this.confirmText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isDarkMode()
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(
          //   "assets/images/home_logo.png",
          //   width: 80,
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: Get.width,
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                    onTap: () {
                      Get.back(result: false);
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: buttonColor,
                          width: 1,
                        ),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Center(
                        child: Text(
                          cancelText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )),
              ),
              hGap(16),
              Expanded(
                child: InkWell(
                    onTap: () {
                      Get.back(result: true);
                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: buttonColor,
                      ),
                      child: Center(
                        child: Text(
                          confirmText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

confirmDialog(BuildContext context,
    {String content = "Are you sure want to delete your account?",
    String confirmText = "Delete",
    String cancelText = "Cancel"}) async {
  var response = await showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: ConfirmDialogView(
              content: content,
              cancelText: cancelText,
              confirmText: confirmText,
            ));
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
      alignment: Alignment.center);
  return response;
}
