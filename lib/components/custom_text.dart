import 'package:get/get.dart';

import '../export.dart';

Text text(String label,
        {Color? color,
        double? fontSize,
        FontWeight? fontWeight,
        int? maxLines,
        TextOverflow? textOverflow = TextOverflow.ellipsis,
        TextAlign? textAlign,
        bool isBold = false}) =>
    Text(
      label,
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
        letterSpacing: 0.2,
        wordSpacing: 0.2,
        color: color ?? Theme.of(Get.context!).textTheme.bodyText1?.color,
        fontWeight: isBold
            ? FontWeight.w800
            : fontWeight ??
                Theme.of(Get.context!).textTheme.bodyText1?.fontWeight,
        fontSize:
            fontSize ?? Theme.of(Get.context!).textTheme.bodyText1?.fontSize,
      ),
    );

textStyle({fontSize, color, fontWeight}) => TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
