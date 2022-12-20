import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showCrossIcon;
  final Color backgroundColor;
  final bool showEditButton;
  final Function? onEditTapped;
  final bool? showBottomBorder;
  final Widget? bottomWidget;
  final Function()? onBackPress;

  const DefaultAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.leading,
    this.showCrossIcon = false,
    this.backgroundColor = Colors.white,
    this.showEditButton = false,
    this.onEditTapped,
    this.showBottomBorder = true,
    this.bottomWidget,
    this.onBackPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Get.locale?.languageCode);
    return AppBar(
      leadingWidth: showBackButton ? 40 : 60,
      backgroundColor: Theme.of(context).cardColor,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: showBackButton
            ? Center(
                child: InkWell(
                  onTap: onBackPress ??
                      () {
                        Get.back();
                      },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: Get.locale?.languageCode == 'ar' ||
                                Get.locale?.languageCode == 'ar_DZ'
                            ? 2
                            : 0,
                        child: SvgPicture.asset(
                          'assets/icons/back_arrow.svg',
                          width: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Image.asset(
                'assets/images/logo.png',
              ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: primaryColor, fontWeight: FontWeight.w500),
      ),
      actions: [
        if (actions != null) ...actions!,
        SizedBox(
          width: 21,
        )
      ],
      bottom: CustomAppBarBottomWidget(
        child: bottomWidget ??
            Container(
              width: 428,
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(bottomWidget == null ? kToolbarHeight : 96);
  }
}

class CustomAppBarBottomWidget extends PreferredSize {
  @override
  final Widget child;
  final double height;

  CustomAppBarBottomWidget({
    this.height = 96,
    required this.child,
  }) : super(child: child, preferredSize: Size.fromHeight(kToolbarHeight));

  @override
  Widget build(BuildContext context) => child;
}
