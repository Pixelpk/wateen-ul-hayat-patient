import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../export.dart';
import '../service/remote_service/network/endpoint.dart';


Widget vGap(double height) => SizedBox(height: height);

Widget hGap(double width) => SizedBox(width: width);

setFileImage(
    {
      required String url, double? height, double? width, double? radius}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 100),
    child: Image.file(new File(url),
        height: height, width: width, fit: BoxFit.contain),
  );
}

focuOnNextEditText({context, nextFocus}) {
  return FocusScope.of(context).requestFocus(nextFocus);
}

circleImageNetWork({imageurl, height, width, radius, bool isMember = false}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 0.0),
    child: FadeInImage.assetNetwork(
        fit: BoxFit.contain,
        width: width ?? 250,
        height: height ?? 250,
        placeholder: ICON_profile,
        imageErrorBuilder: imageErrorBuilder(
          isMember,
        ),
        image: imageurl != null ? imageurl : "",
    ),
  );
}

Widget circleImageNetWorkTwo(
    {String? imageurl = "",
    height,
    width,
    radius,
    BoxFit? fit,
    int? cacheWidth,
    int? cacheHeight,
    placeHodler = ICON_profile}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 0.0),
    child: CachedNetworkImage(
      fit: fit ?? BoxFit.contain,
      memCacheHeight: cacheHeight ?? 250,
      memCacheWidth: cacheWidth ?? 250,
      width: width,
      height: height,
      placeholder: (_, __) {
        return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      },
      errorWidget: (context, exception, stackTrace) {
        return Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: imageAsset(
              placeHodler,
              fit: fit ?? BoxFit.contain,
              width: width,
              height: height,
            ));
      },
      imageUrl: imageurl != null ? imageUrl + imageurl : "",
    ),
  );
}

circleAssetImage(
    {required String asset, double? height, double? width, double? radius}) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 100),
      child:
          imageAsset(asset, height: height, width: width, fit: BoxFit.contain));
}

Widget getInkWell({required Widget child, required Function() onTap}) =>
    InkWell(
      child: child,
      onTap: onTap,
    );

decorationBox(
    {backgroundColor,
    cornerRaduis,
    borderColor,
    borderWidth,
    bool? showShadow}) {
  return BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: borderColor, width: borderWidth),
      borderRadius: BorderRadius.all(
        Radius.circular(cornerRaduis),

        //
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, (showShadow ?? false) ? 4 : 0),
          blurRadius: 1,
          spreadRadius: 1,
          color: Colors.grey[(showShadow ?? false) ? 200 : 100]!,
        )
      ]);
}

class CountryCodeWidget extends StatelessWidget {
  String selectedCountryCode = '+966';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: DIMENS_50,
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: CountryCodePicker(
        padding: EdgeInsets.zero,
        onChanged: (value) {
          selectedCountryCode = value.dialCode.toString();
        },
        showFlag: false,
        textStyle: textStyle(color: Colors.black),
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: 'US',
        favorite: ['+91', 'IN'],
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
}

/*=================================================================== Image Pick Using camera ===================================================*/

imgFromCamera() async {
  return await ImagePicker.platform
      .pickImage(source: ImageSource.camera, imageQuality: 100);
}

/*=================================================================== Image Pick Using Gallery ===================================================*/

imgFromGallery() async {
  return await ImagePicker.platform
      .pickImage(source: ImageSource.gallery, imageQuality: 100);
}
