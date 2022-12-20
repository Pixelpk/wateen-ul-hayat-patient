import 'package:flutter/material.dart';
import 'package:swift_care/constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isBlackColor;
  const PrimaryButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.isBlackColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
          color: isBlackColor ? Color(0xff444444) : buttonColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 9,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: COLOR_white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryGreyButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const PrimaryGreyButton(
      {Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: lBorderColor,
            width: 1,
          ),
          color: lLightGreyColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 9,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: lTextColorLight,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularPrimaryButton extends StatelessWidget {
  const CircularPrimaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.horizontalPadding})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final double? horizontalPadding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 3,
          horizontal: horizontalPadding ?? 43,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff08bede),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: lCardColor,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
