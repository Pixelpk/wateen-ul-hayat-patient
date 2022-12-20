import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/strings.dart';

class InputFieldMobileWidget extends StatelessWidget {
  const InputFieldMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 12, bottom: 12),
      color: Colors.white,
      padding: EdgeInsetsDirectional.only(start: 4, end: 4),
      child: Transform.translate(
        offset: Offset(-2, -8),
        child: Container(
            child: Text(
          STRING_mobileNo.tr,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 12, color: Theme.of(context).primaryColorDark),
        )),
      ),
    );
  }
}
