import 'package:flutter/cupertino.dart';

import '../export.dart';

class CircularImageWidget extends StatelessWidget {
  final double radius;
  final String imageUrl;

  const CircularImageWidget({
    Key? key,
    this.radius = 100,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).cardColor,
          width: 2,
        ),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: ClipOval(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius ?? 0.0),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              memCacheHeight: 250,
              memCacheWidth: 250,
              width: radius,
              height: radius,
              placeholder: (_, __) {
                return Container(
                  width: radius,
                  height: radius,
                  alignment: Alignment.center,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              },
              errorWidget: (context, exception, stackTrace) {
                return Container(
                    width: radius,
                    height: radius,
                    alignment: Alignment.center,
                    color: Color(0xff298999),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                      width: radius,
                      height: radius,
                    ));
              },
              imageUrl: imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
