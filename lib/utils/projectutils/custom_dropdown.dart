/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */



import '../../export.dart';

customDropDown({
  required var itemSelected,
  required dropdownMenuItems,
  required focusNode,
  required hintText,
  required onChanged,
  required String lable,
}) =>
    DropdownButtonFormField(
        focusNode: focusNode,
        isDense: true,
        decoration: InputDecoration(
          labelText: lable,
          contentPadding: EdgeInsets.only(
              right: 20.0,
              left: 15.0,
              top: 16.0,
              bottom: 16.0),
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
        ),
        style: TextStyle(
            fontSize: 12.0,
            color: Colors.black45,
            fontWeight: FontWeight.w500,
            letterSpacing: 0),
        hint: Text(hintText,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
                letterSpacing: 0)),
        isExpanded: true,
        validator: (val) {},
        icon: Transform.rotate(
            angle: 4.71239, child: Icon(Icons.arrow_back_ios_outlined)),
        iconSize: 18.0,
        iconEnabledColor: Colors.grey,
        value: itemSelected,
        items: dropdownMenuItems,
        onChanged: onChanged);
