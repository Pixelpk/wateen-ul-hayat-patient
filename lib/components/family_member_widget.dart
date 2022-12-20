import 'package:flutter_svg/svg.dart';
import 'package:swift_care/components/confirm_dialog.dart';
import 'package:swift_care/model/responseModal/family_response_model.dart';
import '../export.dart';
import '../utils/utils.dart';

class FamilyMemberWidget extends StatelessWidget {
  final FamilyMember? item;
  final Function() onDelete;
  final Function() onEdit;

  const FamilyMemberWidget(
      {Key? key, this.item, required this.onDelete, required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
            color: Theme.of(context).cardColor,
          ),
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: hMargin),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        STRING_name.tr + ": ",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item?.name ?? "",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              vGap(6),
              Container(
                width: Get.width,
                height: 2,
                color: isDarkMode() ? dDropDownColor : lDropDownColor,
              ),
              vGap(6),
              Container(
                margin: EdgeInsets.symmetric(horizontal: hMargin),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        STRING_relation.tr + ": ",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item?.relation ?? '',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              vGap(6),
              Container(
                width: Get.width,
                height: 2,
                color: isDarkMode() ? dDropDownColor : lDropDownColor,
              ),
              vGap(6),
              Container(
                margin: EdgeInsets.symmetric(horizontal: hMargin),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        STRING_contact.tr + ": ",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        (item?.countryCode ?? '') +
                            ' ' +
                            (item?.contactNo ?? ''),
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          child: Row(
            children: [
              InkWell(
                onTap: onEdit,
                child: Container(
                  width: 35,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(10),
                    ),
                    color: buttonColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/edit.svg',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final bool? isConfirmed = await confirmDialog(
                    Get.context!,
                    content:
                        "${STRING_AreYouDelete.tr}${item?.name ?? ""}?",
                    cancelText:  STRING_No.tr,
                    confirmText:STRING_yes.tr,
                  );
                  if (isConfirmed != null) {
                    if (isConfirmed) {
                      onDelete();
                    }
                  }
                },
                child: Container(
                  width: 35,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(10),
                    ),
                    color:  Theme.of(context).primaryColorDark,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/delete.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
