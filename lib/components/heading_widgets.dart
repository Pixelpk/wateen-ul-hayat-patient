import '../export.dart';

class TitleHeadingWidget extends StatelessWidget {
  final String title;
  final Color? background;
  final Color? textColor;
  const TitleHeadingWidget(
      {Key? key,
      required this.title,
      this.background = buttonColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: background,
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: textColor ?? Theme.of(context).cardColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class TitleRounderContainer extends StatelessWidget {
  const TitleRounderContainer({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: buttonColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: COLOR_white),
          ),
        ],
      ),
    );
  }
}
