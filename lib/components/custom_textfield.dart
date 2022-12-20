import 'package:swift_care/utils/utils.dart';

import '../export.dart';

Widget ctextFormField(
        {required TextEditingController controller,
        required FocusNode focusNode,
        String? hintText,
        String? label,
        onTap,
        onFieldSubmitted,
        int maxLines = 1,
        bool obsecureText = false,
        bool readOnly = false,
        String? validator(String? value)?,
        TextInputAction textInputAction = TextInputAction.next,
        TextInputType textInputType = TextInputType.text,
        Widget? prefix,
        int? maxLength,
        Widget? suffix}) =>
    TextFormField(

      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLines,
      obscuringCharacter: '*',
      obscureText: obsecureText,
      textAlignVertical: TextAlignVertical.center,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: appColor,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
          fontSize: textTheme.bodyText1!.fontSize,
          fontWeight: textTheme.bodyText1!.fontWeight,
          color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(18, 18, 15, 18),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: isDarkMode() ? dBorderColor : lBorderColor,
        )),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        labelText: label ?? hintText,
        hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: textTheme.bodyText1!.fontSize,
            fontWeight: textTheme.bodyText1!.fontWeight),
        helperStyle: TextStyle(
          color: Colors.grey,
          fontSize: textTheme.bodyText1!.fontSize,
          fontWeight: textTheme.bodyText1!.fontWeight,
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: FONT_18, //textTheme.bodyText1!.fontSize,
          fontWeight: textTheme.bodyText1!.fontWeight,
        ),
        prefixStyle: TextStyle(
          color: Colors.grey,
          fontSize: textTheme.bodyText1!.fontSize,
          fontWeight: textTheme.bodyText1!.fontWeight,
        ),
        fillColor: COLOR_white,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );

Widget ctextFormFieldMobile(
        {required TextEditingController controller,
        required FocusNode focusNode,
        String? hintText,
        String? label,
        int maxLines = 1,
        int? maxLength,
        bool obsecureText = false,
        bool readOnly = false,
        String? validator(String? value)?,
        TextInputAction textInputAction = TextInputAction.next,
        TextInputType textInputType = TextInputType.number,
        Widget? prefix,
        Widget? suffix}) =>
    Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TextFormField(
            readOnly: readOnly,
            controller: controller,
            focusNode: focusNode,
            validator: validator,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines,
            maxLength: 15,
            obscuringCharacter: '*',
            obscureText: obsecureText,
            textAlignVertical: TextAlignVertical.center,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: appColor,
            style: TextStyle(
                fontSize: textTheme.bodyText1!.fontSize,
                fontWeight: textTheme.bodyText1!.fontWeight,
                color: Colors.black),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              labelText: label,
              counterText: "",
              contentPadding: EdgeInsets.fromLTRB(18, 18, 15, 18),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: isDarkMode() ? dBorderColor : lBorderColor,
              )),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: textTheme.bodyText1!.fontSize,
                  fontWeight: textTheme.bodyText1!.fontWeight),
              helperStyle: TextStyle(
                color: Colors.grey,
                fontSize: textTheme.bodyText1!.fontSize,
                fontWeight: textTheme.bodyText1!.fontWeight,
              ),
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: textTheme.bodyText1!.fontSize,
                fontWeight: textTheme.bodyText1!.fontWeight,
              ),
              prefixStyle: TextStyle(
                color: Colors.grey,
                fontSize: textTheme.bodyText1!.fontSize,
                fontWeight: textTheme.bodyText1!.fontWeight,
              ),
              fillColor: COLOR_white,
              prefixIcon: prefix,
              suffixIcon: suffix,
            ),
          ),
        ],
      ),
    );

Widget ctextFormFieldwithPrefix(
        {required TextEditingController controller,
        required FocusNode focusNode,
        String? hintText,
        String? label,
        int maxLines = 1,
        String? validator(String? value)?,
        String? onChange(String? value)?,
        String? onFieldSubmitted(String? value)?,
        String? onEditingComplete(String? value)?,
        TextInputAction textInputAction = TextInputAction.next,
        TextInputType textInputType = TextInputType.text,
        Widget? prefix}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        if (label != null) vGap(4),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
              color: Colors.grey),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: DIMENS_16),
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: textTheme.bodyText1!.fontSize,
                fontWeight: textTheme.bodyText1!.fontWeight),
            helperStyle: TextStyle(
              color: Colors.grey,
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            prefixStyle: TextStyle(
              color: Colors.grey,
              fontSize: textTheme.bodyText1!.fontSize,
              fontWeight: textTheme.bodyText1!.fontWeight,
            ),
            fillColor: COLOR_white,
            prefixIcon: prefix,
          ),
        ),
      ],
    );
