import 'package:flutter/material.dart';
import 'package:swift_care/constants/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    this.isPrimaryColor = false,
    this.height,
  }) : super(key: key);
  final bool isPrimaryColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1,
      color: isPrimaryColor ? buttonColor : Theme.of(context).dividerColor,
    );
  }
}
