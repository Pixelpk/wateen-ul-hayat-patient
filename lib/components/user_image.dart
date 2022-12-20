import 'package:swift_care/components/image_widget.dart';
import 'package:swift_care/export.dart';

class UserImage extends StatelessWidget {
  final String? imageUrl;
  final Function()? onCameraTap;

  UserImage({Key? key, this.imageUrl, this.onCameraTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircularImageWidget(imageUrl: imageUrl ?? ""),
          if (onCameraTap != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: getInkWell(
                onTap: onCameraTap!,
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(Get.context!).cardColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: buttonColor),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 3)
                        ]),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: buttonColor,
                      size: 16,
                    )),
              ),
            )
        ],
      ),
    );
  }
}
