import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swift_care/utils/utils.dart';
import '../export.dart';
import 'image_widget.dart';

class ProfileWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  ProfileWidget(
      {Key? key,
      required this.label,
      required this.value,
      this.showDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(start: hMargin),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w500)),
              vGap(4),
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: buttonColor)),
            ],
          ),
        ),
        vGap(8),
        if (showDivider)
          Container(
            width: Get.width,
            height: 2,
            color: isDarkMode() ? dDropDownColor : lDropDownColor,
          ),
        vGap(12),
      ],
    );
  }
}

class ProfileWidgetWithRatingCount extends StatelessWidget {
  const ProfileWidgetWithRatingCount({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.ratingCount,
    required this.reviewsCount,
    this.showRatings = true,
  }) : super(key: key);
  final String? imageUrl;
  final String name;
  final double ratingCount;
  final String reviewsCount;
  final bool showRatings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: DIMENS_20, horizontal: DIMENS_20),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: DIMENS_20, vertical: DIMENS_20),
        decoration: cardDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: CircularImageWidget(
                  imageUrl: imageUrl ?? '',
                ),
              ),
            ),
            hGap(DIMENS_24),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 2,
                  ),
                  if (showRatings)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vGap(DIMENS_5),
                        RatingBarIndicator(
                          rating: ratingCount,
                          itemSize: 20.0,
                          itemBuilder: (BuildContext context, int index) {
                            return Icon(
                              Icons.star_rounded,
                              color: buttonColor,
                            );
                          },
                        ),
                        vGap(DIMENS_5),
                        Text(
                          reviewsCount,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(),
                        ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
