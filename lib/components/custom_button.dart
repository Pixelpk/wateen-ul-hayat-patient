import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:swift_care/constants/dimens.dart';
import 'package:swift_care/constants/font_family.dart';

Widget cbtnTextButton(
        {required void Function() onPressed,
        required String label,
        OutlinedBorder? shape,
        Color? backgroundColor,
        Color? foregroundColor,
        Color? shadowColor,
        double? height,
        EdgeInsetsGeometry? padding,
        Color textColor = Colors.black,
        TextStyle? textStyle}) =>
    FractionallySizedBox(
      child: SizedBox(
        height: height,
        child: TextButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: FONT_16,
                  fontFamily: FontFamily.mazzard),
            ),
          ),
          style: TextButton.styleFrom(
              shape: shape,
              backgroundColor: backgroundColor,
              padding: padding,
              onSurface: foregroundColor,
              shadowColor: shadowColor,
              textStyle: textStyle),
        ),
      ),
    );

Widget cbtnTextButtonWithIcon(
        {required void Function() onPressed,
        required String label,
        required IconData icon,
        Color textColor = Colors.black,
        OutlinedBorder? shape,
        Color? backgroundColor,
        Color? foregroundColor,
        double? height,
        Color? shadowColor,
        EdgeInsetsGeometry? padding,
        TextStyle? textStyle}) =>
    FractionallySizedBox(
      child: SizedBox(
        height: height,
        child: TextButton.icon(
          onPressed: onPressed,
          label: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: FONT_16,
                  fontFamily: FontFamily.mazzard),
            ),
          ),
          icon: Icon(icon),
          style: TextButton.styleFrom(
              shape: shape,
              backgroundColor: backgroundColor,
              padding: padding,
              onSurface: foregroundColor,
              shadowColor: shadowColor,
              textStyle: textStyle),
        ),
      ),
    );

Widget cbtnElevatedButton(
        {required void Function() onPressed,
        required String label,
        Color textColor = Colors.white,
        OutlinedBorder? shape,
        Color? backgroundColor,
        double? height,
        Color? foregroundColor,
        Color? shadowColor,
        EdgeInsetsGeometry? padding,
        TextStyle? textStyle}) =>
    InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: DIMENS_40, vertical: DIMENS_10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                offset: Offset(0, 6),
                blurRadius: 12)
          ],
          color: Color.fromRGBO(8, 190, 222, 1),
        ),
        child: AutoSizeText(
          label,
          textAlign: TextAlign.left,
          maxLines: 1,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 18,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );

Widget cbtnElevatedButtonWithIcon(
        {required void Function() onPressed,
        required String label,
        required IconData icon,
        Color textColor = Colors.white,
        OutlinedBorder? shape,
        Color? backgroundColor,
        double? height,
        Color? foregroundColor,
        Color? shadowColor,
        EdgeInsetsGeometry? padding,
        TextStyle? textStyle}) =>
    FractionallySizedBox(
      child: SizedBox(
        height: height,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          label: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: FONT_16,
                  fontFamily: FontFamily.mazzard),
            ),
          ),
          icon: Icon(icon),
          style: ElevatedButton.styleFrom(
            shape: shape,
            primary: backgroundColor,
            padding: padding ?? EdgeInsets.all(DIMENS_12),
            onSurface: foregroundColor,
            shadowColor: shadowColor,
            textStyle: textStyle,
          ),
        ),
      ),
    );

Widget cbtnOutlinedButton({
  required void Function() onPressed,
  required String label,
  Color textColor = Colors.white,
  OutlinedBorder? shape,
  Color? backgroundColor,
  double? height,
  Color? foregroundColor,
  Color? shadowColor,
  EdgeInsetsGeometry? padding,
  TextStyle? textStyle,
}) =>
    FractionallySizedBox(
      child: SizedBox(
        height: height,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: FONT_16,
                  fontFamily: FontFamily.mazzard),
            ),
          ),
          style: OutlinedButton.styleFrom(
              shape: shape,
              backgroundColor: backgroundColor,
              padding: padding,
              onSurface: foregroundColor,
              shadowColor: shadowColor,
              textStyle: textStyle),
        ),
      ),
    );

Widget cbtnOutlinedButtonWithIcon(
        {required void Function() onPressed,
        required String label,
        required IconData icon,
        Color textColor = Colors.white,
        OutlinedBorder? shape,
        Color? backgroundColor,
        double? height,
        Color? foregroundColor,
        Color? shadowColor,
        EdgeInsetsGeometry? padding,
        TextStyle? textStyle}) =>
    FractionallySizedBox(
      child: SizedBox(
        height: height,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          label: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: FONT_16,
                  fontFamily: FontFamily.mazzard),
            ),
          ),
          icon: Icon(icon),
          style: OutlinedButton.styleFrom(
              shape: shape,
              backgroundColor: backgroundColor,
              padding: padding,
              onSurface: foregroundColor,
              shadowColor: shadowColor,
              textStyle: textStyle),
        ),
      ),
    );

Widget cbtnGestureDetector({
  required void Function() onPressed,
  required Widget child,
}) =>
    GestureDetector(
      onTap: onPressed,
      child: child,
    );

Widget directionality({text}) => Directionality(
    textDirection: TextDirection.ltr,
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ));
