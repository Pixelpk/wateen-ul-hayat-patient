import '../export.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    required this.titles,
    required this.onPressed,
    required this.selectedIndex,
    this.horizontalPadding,
    this.textTopPadding = 15,
  }) : super(key: key);
  final List<String> titles;
  final int selectedIndex;
  final Function(int index) onPressed;
  final double? horizontalPadding;
  final double textTopPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: appBarDeco,
      // margin: const EdgeInsets.symmetric(
      //   horizontal: 20,
      // ),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 40),
            child: Row(
                children: titles.asMap().entries.map((e) {
              return Expanded(
                child: InkWell(
                  onTap: () {
                    onPressed(e.key);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 12.5,
                          top: textTopPadding,
                        ),
                        child: Text(
                          e.value,
                          textScaleFactor: 1.0,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: e.key == selectedIndex
                                      ? buttonColor
                                      : lTextColorLight,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                      e.key == selectedIndex
                          ? tabBottomLine(buttonColor)
                          : tabBottomLine(Colors.white)
                    ],
                  ),
                ),
              );
            }).toList()),
          ),
          Container(
            height: 1.5,
            color: statusBarColor,
          ),
        ],
      ),
    );
  }

  Widget tabBottomLine(color) {
    return Container(
        width: 150,
        height: 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: color,
        ));
  }
}
