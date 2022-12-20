import 'package:flutter_svg/svg.dart';
import 'package:swift_care/export.dart';

class BottomBarItemWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isSelected;

  BottomBarItemWidget({
    required this.imagePath,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: !Platform.isIOS
          ? null
          : EdgeInsets.only(
              bottom: isSelected ? 0 : MediaQuery.of(context).padding.bottom,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            height: isSelected ? 30 : 20,
            width: isSelected ? 30 : 20,
          ),
          if (!isSelected) vGap(6),
          if (!isSelected)
            Text(title,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, height: 1)),
        ],
      ),
    );
  }
}
