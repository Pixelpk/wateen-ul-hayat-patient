import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:swift_care/components/common_widget.dart';
import 'package:swift_care/model/data_model/categorylist_item_data_modal.dart';
import '../constants/app_constant.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../pages/home/presentation/controllers/book_service_provider_controller.dart';
import '../pages/home/presentation/controllers/home_tab_controller.dart';

class SubcategoryWidget extends StatelessWidget {
  final Services? categoryListItem;

  const SubcategoryWidget({Key? key, required this.categoryListItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(hMargin),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Color(0x0c000000),
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(categoryListItem?.title ?? "",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins().copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    )),
              ),
              hGap(12),
              InkWell(
                onTap: () {
                  print("Services called");
                  var ctrl = Get.put(BookServiceProviderController());

                  ctrl.getLocation(
                      categoryId: categoryListItem?.categoryId,
                      id: categoryListItem?.id);

                  ctrl.update();
                },
                child: Container(
                  width: 90,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                    color: buttonColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    STRING_orderNow.tr.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(vertical: 6),
            height: 1,
            color: primaryColor,
          ),
          // Html(
          //   data: categoryListItem.description ?? "",
          //
          // ),
          //
          // InkWell(
          //   onTap: () {},
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: Text(
          //       "View more",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         color: Theme
          //             .of(context)
          //             .primaryColor,
          //         fontSize: 12,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // )

          ReadMoreText(
            categoryListItem?.description ?? "",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: 14,
            ),
            trimLines: 3,
            textAlign: TextAlign.start,
            colorClickableText: primaryColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' View More',
            trimExpandedText: ' View Less',
            lessStyle: TextStyle(
                fontSize: 14,
                color: primaryColor,
                decorationStyle: TextDecorationStyle.dashed),
            moreStyle: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
