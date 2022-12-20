import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swift_care/export.dart';

import '../utils/utils.dart';

class InputFieldWidget extends StatefulWidget {
  final String? hint;
  final FocusNode? focusNode;
  final void Function(String value)? onChange;
  final IconData? prefixIcon;
  final String? prefixImage;
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType keyboardType;
  final bool obscure;
  final bool enable;
  final bool textAlignCenter;
  final bool isSvg;
  final bool showPadding;
  final String? label;
  final bool showDropArrow;
  final bool showBorder;
  final bool isFill;
  bool readOnly;
  final VoidCallback? callBack;
  final bool showUnderLineBorder;
  final Widget? suffixWidget;
  final bool showObscureByText;
  final int? maxLength;

  final FormFieldValidator<String?>? validator; // add this line
  final Widget? prefixWidget;
  final Color? borderColor;
  final double borderRadius;
  final void Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;

   InputFieldWidget(
      {Key? key,
      this.focusNode,
      this.hint,
      this.prefixIcon,
      this.prefixImage,
      this.controller,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text,
      this.obscure = false,
      this.enable = true,
      this.textAlignCenter = false,
      this.onChange,
        this.readOnly = false,
      this.callBack,
      this.isSvg = false,
      this.showPadding = false,
      this.label,
      this.showDropArrow = false,
      this.showBorder = true,
      this.isFill = false,
      this.showUnderLineBorder = false,
      this.suffixWidget,
      this.showObscureByText = false,
      this.validator,
      this.maxLength,
      this.prefixWidget,
      this.borderColor,
      this.onFieldSubmitted,
      this.textInputAction,
      this.borderRadius = 4})
      : super(key: key);

  @override
  _InputFieldWidgetState createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.callBack,
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      cursorColor: Colors.black,
      style: Theme.of(context).textTheme.subtitle1,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      onChanged: widget.onChange,
      validator: widget.validator,
      enabled: widget.enable,
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      textAlign:
          widget.textAlignCenter == true ? TextAlign.center : TextAlign.start,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.keyboardType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      textAlignVertical: TextAlignVertical.center,
      obscureText: widget.obscure ? obscure : widget.obscure,
      decoration: InputDecoration(
        hintText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,

        counter: Offstage(),
        labelText: widget.label,
        contentPadding: widget.showPadding
            ? const EdgeInsets.symmetric(horizontal: 22, vertical: 18)
            : null,
        hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: Theme.of(context).primaryColorLight.withOpacity(0.6)),
        labelStyle: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Theme.of(context).primaryColorDark),
        filled: widget.isFill,
        fillColor: Theme.of(context).primaryColorLight,
        border: buildUnderlineInputBorder(),
        enabledBorder: buildUnderlineInputBorder(),
        errorBorder: buildUnderlineInputBorder(),
        focusedBorder: buildUnderlineInputBorder(),
        disabledBorder: buildUnderlineInputBorder(),
        focusedErrorBorder: buildUnderlineInputBorder(),
        prefixIconConstraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width * 0.5,
          maxWidth: MediaQuery.of(context).size.width * 0.5,
        ),
        prefixIcon: widget.prefixWidget != null
            ? widget.prefixWidget
            : widget.prefixIcon != null
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      widget.prefixIcon,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  )
                : widget.prefixImage != null
                    ? Container(
                        width: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: widget.isSvg
                            ? SvgPicture.asset(
                                widget.prefixImage!,
                                color: Theme.of(context).primaryColorLight,
                                width: 12,
                              )
                            : Image.asset(
                                widget.prefixImage!,
                                color: Theme.of(context).primaryColorLight,
                              ))
                    : null,
        // suffix: widget.suffixWidget,
        suffixIcon: widget.showObscureByText
            ? InkWell(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 1,
                      height: 15,
                      color: Color(0xffc1c1c1),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(obscure ? "Show" : "Hide",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Color(0xffc1c1c1),
                            )),
                  ],
                ))
            : widget.suffixWidget ??
                (widget.showDropArrow
                    ? const Icon(
                        Icons.arrow_drop_down_outlined,
                        // color: BaseTheme.lightThemeIconColor,
                      )
                    : !widget.obscure
                        ? null
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            child: Icon(
                              obscure ? Icons.visibility : Icons.visibility_off,
                              // color: BaseTheme.lightThemeIconColor,
                              size: 23,
                            ),
                          )),
      ),
    );
  }

  InputBorder buildUnderlineInputBorder() {
    return widget.showBorder
        ? widget.showUnderLineBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: isDarkMode() ? dBorderColor : lBorderColor,
                    width: 2))
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: isDarkMode() ? dBorderColor : lBorderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              )
        : InputBorder.none;
  }
}
