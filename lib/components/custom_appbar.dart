import '../export.dart';

backAppBar(context, {String? title, onPress, actions,elevation}) => PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: elevation??0
            )
          ]
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: imageAsset(
                            ICON_back,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.focusScope!.unfocus();
                        onPress ?? Navigator.pop(context);
                      }),
                  hGap(16),
                  text(title ?? "",
                      fontSize: 24, color: COLOR_russianVoilet, isBold: true),
                ],
              ),
            ),
            actions ?? Container()
          ],
        ),
      ),
    );

titleNDrawerAppBar({title, icon, onPressed}) => PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(title, fontSize: 24, color: COLOR_russianVoilet, isBold: true),
              GestureDetector(
                child: imageAsset(icon, width: 24, height: 24),
                onTap: onPressed,
              ),
            ],
          ),
        ),
      ),
    );

backAppBar2({context, onPress, actions, title, centerTitle,elevation,leading,onBackPress}) {
  return AppBar(
    elevation: elevation??0.5,
    leading: leading??Padding(
      padding: const EdgeInsets.all(14),
      child: InkWell(
          child: SizedBox(
            height: 16,
            width: 16,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: imageAsset(
                ICON_back,
                height: 16,
                width: 16,
              ),
            ),
          ),
          onTap:onBackPress?? () {
            Get.focusScope!.unfocus();
            onPress ?? Navigator.pop(context);
          }),
    ),
    title: title ?? Container(),
    centerTitle: centerTitle ?? true,
    actions: actions ?? [],
  );
}
