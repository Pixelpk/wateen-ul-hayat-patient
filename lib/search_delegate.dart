import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';

import 'components/common_widget.dart';
import 'constants/app_constant.dart';
import 'constants/colors.dart';
import 'constants/strings.dart';
import 'model/data_model/categorylist_item_data_modal.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.categoryListItem});

  final List<CategoryListItem?> categoryListItem;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: query.isEmpty
              ? const Icon(
                  Icons.clear,
                  color: Colors.transparent,
                )
              : const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<CategoryListItem> matchQuery = [];
    for (var fruit in categoryListItem) {
      if ((fruit!.title!.toLowerCase()).contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: ListView.builder(
        itemBuilder: (context, index) {
          var result = matchQuery[index];
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
                      child: Text(result.title ?? "",
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
                            categoryId: result.categoryId, id: result.id);

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
                ReadMoreText(
                  result.description ?? "",
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
        },
        itemCount: matchQuery.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CategoryListItem> matchQuery = [];

    for (var fruit in categoryListItem) {
      if ((fruit!.title!.toLowerCase()).contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: matchQuery.isEmpty
          ? Center(
              child: Text(
              "${query} Not found",
              style: TextStyle(fontSize: 16),
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                var result = matchQuery[index];
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
                            child: RichText(
                              text: TextSpan(
                                  children: highlightOccurrences(
                                      result.title!, query),
                                  style: GoogleFonts.poppins().copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  )),
                            ),
                            // child: Text(result.title ?? "",
                            //     maxLines: 2,
                            //     textAlign: TextAlign.start,
                            //     style: GoogleFonts.poppins().copyWith(
                            //       color: Theme.of(context).primaryColorDark,
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 13,
                            //     )),
                          ),
                          hGap(12),
                          InkWell(
                            onTap: () {
                              print("Services called");
                              var ctrl =
                                  Get.put(BookServiceProviderController());

                              ctrl.getLocation(
                                  categoryId: result.categoryId, id: result.id);

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
                      ReadMoreText(
                        result.description ?? "",
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
                // return ListTile(
                //   title: RichText(
                //     text: TextSpan(
                //       children: highlightOccurrences(result, query),
                //       style: TextStyle(color: Colors.grey),
                //     ),
                //   ),
                // );
              },
              itemCount: matchQuery.length,
            ),
    );
  }
}

List<TextSpan> highlightOccurrences(String source, String query) {
  if (query == null ||
      query.isEmpty ||
      !source.toLowerCase().contains(query.toLowerCase())) {
    return [TextSpan(text: source)];
  }
  final matches = query.toLowerCase().allMatches(source.toLowerCase());

  int lastMatchEnd = 0;

  final List<TextSpan> children = [];
  for (var i = 0; i < matches.length; i++) {
    final match = matches.elementAt(i);

    if (match.start != lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.start),
      ));
    }

    children.add(TextSpan(
      text: source.substring(match.start, match.end),
      style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor),
    ));

    if (i == matches.length - 1 && match.end != source.length) {
      children.add(TextSpan(
        text: source.substring(match.end, source.length),
      ));
    }

    lastMatchEnd = match.end;
  }
  return children;
}
