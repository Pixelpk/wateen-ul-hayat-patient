import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/assets.dart';
import 'full_screen_image.dart';

Widget imageAsset(String name,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    Image.asset(
      name,
      height: height,
      width: width,
      fit: fit,
    );

Widget imageFile(File file,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    Image.file(
      file,
      height: height,
      width: width,
      fit: fit,
    );

Widget imageMemory(Uint8List bytes,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    Image.memory(
      bytes,
      height: height,
      width: width,
      fit: fit,
    );

Widget imageNetwork(String url,
        {double? scale, double? width, double? height, BoxFit? fit,bool? isMember}) =>
    Image.network(
      url,
      height: height,
      width: width,
      fit: fit,
errorBuilder: imageErrorBuilder(isMember??false),
    );

imageErrorBuilder(bool isMember) {
  return (context, exception, stackTrace) {
    return isMember
        ? CircleAvatar(
        backgroundColor: Colors.white,
        child:
        Image.asset(ICON_profile, fit: BoxFit.cover))
        : Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff298999)
      ),
          child: ClipRRect(
borderRadius: BorderRadius.circular(100),
          child: Image.asset(ICON_appLogo, fit: BoxFit.contain)),
        );
  };
}

imageErrorBuilderProfile(bool isMember) {
  return (context, exception) {
    return isMember
        ? CircleAvatar(
        backgroundColor: Colors.white,
        child:
        Image.asset(ICON_profile, fit: BoxFit.cover))
        : Padding(
      padding: EdgeInsets.all(10),
      child: Icon(Icons.image),
    );
  };
}

imageAssetProvider(name) => AssetImage(name);

imageNetworkProvider(name) => NetworkImage(name);

imageFileProvider(name) => FileImage(name);

Widget cachedImage(
  url, {
  double? height,
  double? width,
  BoxFit boxFit = BoxFit.contain,
}) {
  return CachedNetworkImage(
      width: width,
      height: height,
      fit: boxFit,
      imageUrl: url ?? "",
      placeholder: (context, url) => Center(
            child: CupertinoActivityIndicator(),
          ),
      errorWidget: (context, url, error) => Center(
            child: Icon(
              Icons.error_rounded,
              color: Colors.grey,
            ),
          ));
}

Widget cachedImageWithView(
  url, {
  double? height,
  double? width,
  var tag,
  BoxFit boxFit = BoxFit.contain,
}) {
  return FullScreenWidget(
    disposeLevel: DisposeLevel.High,
    child: Hero(
      tag: tag,
      child: CachedNetworkImage(
          width: width,
          height: height,
          fit: boxFit,
          imageUrl: url ?? "",
          placeholder: (context, url) => Center(
                child: CupertinoActivityIndicator(),
              ),
          errorWidget: (context, url, error) => Icon(
                Icons.error_rounded,
                color: Colors.grey,
              )),
    ),
  );
}
