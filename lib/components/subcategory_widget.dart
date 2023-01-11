import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:swift_care/components/common_widget.dart';
import 'package:swift_care/model/data_model/categorylist_item_data_modal.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import '../constants/app_constant.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class SubcategoryWidget extends StatefulWidget {
  final Services? categoryListItem;

  const SubcategoryWidget({Key? key, required this.categoryListItem})
      : super(key: key);

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
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
                child: Text(widget.categoryListItem?.title ?? "",
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
                onTap: () async {
                  int qty = 1;
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                widget.categoryListItem?.description ?? "",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  minus(onTap: () {
                                    if(qty>1){
                                      setState(() {
                                        qty = qty - 1;
                                      });
                                    }
                                  }),
                                  Text('$qty',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins().copyWith(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      )),
                                  plus(
                                    onTap: () {
                                      if(qty<99){
                                        setState(() {
                                          qty = qty + 1;
                                        });
                                      }

                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Center(
                                child: Container(
                                  height: 40,
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
                                    STRING_order.tr.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          contentPadding: const EdgeInsets.all(26),
                          title: Text(widget.categoryListItem?.title ?? ""),
                        );
                      },
                    ),
                  );

                  ///
                  /*print("Services called");
                  var ctrl = Get.put(BookServiceProviderController());
                  print(widget.categoryListItem?.categoryId);
                  print(widget.categoryListItem?.id);
                  ctrl.getLocation(
                      categoryId: widget.categoryListItem?.categoryId,
                      id: widget.categoryListItem?.id);

                  ctrl.update();*/
                  ///
                },
                child: Container(
                  width: 90,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: <BoxShadow>[
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
            widget.categoryListItem?.description ?? "",
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
