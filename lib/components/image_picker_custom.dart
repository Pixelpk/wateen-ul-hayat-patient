
import 'package:image_cropper/image_cropper.dart';
import 'package:swift_care/components/custom_bottom_sheet.dart';


import '../export.dart';

openCameraDialog({ required Function onGallary,required Function onCamera,}) => bottomSheet(widget: buildBody(
  onCamera: onCamera,onGallary: onGallary
));
/*============================================================ build body of the camera dilaog  =========================================================*/

buildBody({required Function onGallary,required Function onCamera,}) => Container(
    margin: EdgeInsets.all(20.0),
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        vGap(20.0),
        _cameraOption(onCamera: onCamera),
        vGap(10.0),
        _galleryOption(onGallary: onGallary)
      ],
    ));


/*===================================================================== bootom sheet title   =========================================================*/

_title() =>
    text("Choose Image",fontWeight: FontWeight.bold,fontSize: 25);

/*=====================================================================camera option choosed   =========================================================*/

_cameraOption({required Function onCamera}) => getInkWell(
    child: Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          imageAsset( iconsCamera, width: 50.0, height: 50.0),
          hGap(15.0),
          text("Camera",fontWeight: FontWeight.bold)

        ],
      ),
    ),
    onTap:(){
      onCamera();
    });

/*==============================================================gallery option choosed   =========================================================*/

_galleryOption({required Function onGallary}) => getInkWell(
    child: Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          imageAsset( iconsGallery, width: 50.0, height: 50.0),
          hGap(15.0),
          text("Gallery",fontWeight: FontWeight.bold)
        ],
      ),
    ),
    onTap: () {
      onGallary();
    });

/*=============================================================== image picked from camera =========================================================*/

void imagePickFromCamera({required Function(File) cropImageFunction}) async {
  Get.back();
  var pickedFile = await imgFromCamera();
  if (pickedFile == null) {
    snackBar('Cancelled');
  } else {
    cropImage(pickedFile.path, cropImageFunction: cropImageFunction);
  }
}

/*=============================================================== image picked from gallery =========================================================*/

void imagePickFromGallery({required Function(File) cropImageFunction}) async {
  Get.back();
  var pickedFile = await imgFromGallery();
  if (pickedFile == null) {
    snackBar('Cancelled');
  } else {
    cropImage(pickedFile.path, cropImageFunction: cropImageFunction);
  }
}

/*=============================================================== image picked from gallery =========================================================*/

cropImage(filePath, {required Function(File) cropImageFunction}) async {
  File? croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    aspectRatioPresets: [CropAspectRatioPreset.square],
  );
  if (croppedImage == null) {
    snackBar('Cancelled');
  } else {
    cropImageFunction(croppedImage);


  }
}