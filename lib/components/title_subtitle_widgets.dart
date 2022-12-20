import 'package:swift_care/components/custom_divider.dart';

import '../export.dart';

class TitleSubtitleRichText extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isPrimaryColor;
  final double? fontSize;
  final bool isLtr;
  final bool showSecondText;
  const TitleSubtitleRichText({
    Key? key,
    required this.title,
    required this.subtitle,
    this.isPrimaryColor = false,
    this.fontSize,
    this.isLtr = false,
    this.showSecondText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: fontSize,
              overflow: TextOverflow.visible),
        ),
        if (showSecondText)
          isLtr
              ? Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: fontSize,
                        color: isPrimaryColor
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColorLight),
                  ),
                )
              : Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: fontSize,
                      color: isPrimaryColor
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColorLight),
                )
      ],
    );
  }
}

class TitleSubtitleVerticalWidget extends StatelessWidget {
  const TitleSubtitleVerticalWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.showDivider = true,
    this.isButtonColor = false,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final bool showDivider;
  final bool isButtonColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isButtonColor
                          ? buttonColor
                          : Theme.of(context).primaryColorLight,
                    ),
              ),
            ],
          ),
        ),
        if (showDivider) CustomDivider()
      ],
    );
  }
}

class TitleSubtitleHorizontalWidget extends StatelessWidget {
  const TitleSubtitleHorizontalWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.showDivider = true,
    this.isButtonColor = false,
    this.isLtr = false,
    this.isTitleButtonColor = false,
    this.currency,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final bool showDivider;
  final bool isButtonColor;
  final bool isLtr;
  final bool isTitleButtonColor;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isTitleButtonColor
                          ? buttonColor
                          : Theme.of(context).primaryColorDark,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  isLtr
                      ? Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            subtitle,
                            textAlign: TextAlign.end,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: isButtonColor
                                          ? buttonColor
                                          : Theme.of(context).primaryColorLight,
                                    ),
                          ),
                        )
                      : Text(
                          subtitle,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: isButtonColor
                                        ? buttonColor
                                        : Theme.of(context).primaryColorLight,
                                  ),
                        ),
                  if (currency != null)
                    isLtr
                        ? Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              currency!,
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: isButtonColor
                                        ? buttonColor
                                        : Theme.of(context).primaryColorLight,
                                  ),
                            ),
                          )
                        : Text(
                            currency!,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: isButtonColor
                                          ? buttonColor
                                          : Theme.of(context).primaryColorLight,
                                    ),
                          ),
                ],
              ),
            ],
          ),
        ),
        if (showDivider) CustomDivider()
      ],
    );
  }
}
