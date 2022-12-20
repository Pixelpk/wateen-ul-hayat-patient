import 'package:country_code_picker/country_code_picker.dart';

import '../../export.dart';
import '../../pages/staticPages/presentation/controllers/static_page_controller.dart';

  prefixContainer(String? val){
    return
      Container(
        width: DIMENS_50,
        padding: EdgeInsets.only(bottom: 3),
        child: Center(child: Text("$val",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.0),)),
      );
  }

countryCode({controller,bool}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
    child: CountryCodePicker(
      enabled: bool,
      padding: EdgeInsets.zero,
      onChanged: (value) {
        controller.updateSelectedCountryCode(value.dialCode.toString());
      },
      showFlag: false,
      textStyle: textStyle(color: Colors.black),
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'SA',
      favorite: ['+966', 'SA'],

      // optional. Shows only country name and flag
      showCountryOnly: false,
      // optional. Shows only country name and flag when popup is closed.
      showOnlyCountryWhenClosed: false,
      // optional. aligns the flag and the Text left
      alignLeft: false,
      showDropDownButton: false,
      flagWidth: 25,
    ),
  );
}
