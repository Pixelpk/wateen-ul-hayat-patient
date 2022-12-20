// import 'package:swift_care/components/custom_divider.dart';
// import 'package:swift_care/service/remote_service/network/endpoint.dart';

// import '../export.dart';
// import '../model/data_model/booking_detail_model.dart';

// class BookingWidget extends StatelessWidget {
//   const BookingWidget({Key? key, required this.newBookingListDataModel})
//       : super(key: key);
//   final BookingDetailModel? newBookingListDataModel;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:
//           EdgeInsets.only(top: DIMENS_20, bottom: DIMENS_20, left: DIMENS_20),
//       decoration: cardDecoration,
//       child: Column(children: [
//         Row(
//           children: [
//             Container(
//                 height: DIMENS_90,
//                 width: DIMENS_90,
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: circleImageNetWork(
//                       imageurl: '$imageUrl${newBookingListDataModel?.detail?.services?[0].providerImage ?? ""}',,
//                     ))),
//             hGap(DIMENS_20),
//             Expanded(
//               flex: 5,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     newBookingListDataModel?.serviceSubCat ?? "",
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           fontWeight: FontWeight.w500,
//                         ),
//                   ),
//                   vGap(4),
//                   CustomDivider(),
//                   vGap(4),
//                   Row(
//                     children: [
//                       Text(
//                         keyPricePerHour.tr,
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontWeight: FontWeight.w500,
//                             ),
//                       ),
//                       Text(
//                         "${KeySAR.tr} ${newBookingListDataModel?.price ?? ''}",
//                         maxLines: 2,
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               color: buttonColor,
//                             ),
//                       )
//                     ],
//                   ),
//                   vGap(4),
//                   CustomDivider(),
//                   vGap(4),
//                   Row(
//                     children: [
//                       Text(
//                         keyDate.tr + ': ',
//                         maxLines: 2,
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontWeight: FontWeight.w500,
//                             ),
//                       ),
//                       Text(
//                         newBookingListDataModel?.startTime == null
//                             ? ''
//                             : "${dateFormate(finalDate: newBookingListDataModel?.startTime)}",
//                         maxLines: 2,
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               color: lTextColorLight,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Container(
//           margin: EdgeInsets.only(right: DIMENS_20, top: DIMENS_20),
//           padding:
//               EdgeInsets.symmetric(horizontal: DIMENS_20, vertical: DIMENS_10),
//           decoration: BoxDecoration(
//             color: Color.fromRGBO(249, 249, 249, 1),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // RichText(
//               //   maxLines: 1,
//               //   text: TextSpan(
//               //     children: [
//               //       TextSpan(
//               //         text: keyDate.tr + ':',
//               //         style: Theme.of(context)
//               //             .textTheme
//               //             .bodyText1!
//               //             .copyWith(fontWeight: FontWeight.w500),
//               //       ),
//               //       newBookingListDataModel?.startTime == null
//               //           ? TextSpan(text: '')
//               //           : TextSpan(
//               //               text: " " +
//               //                       "${dateFormate(finalDate: newBookingListDataModel?.startTime)}" ??
//               //                   '',
//               //               style:
//               //                   Theme.of(context).textTheme.bodyText1!.copyWith(
//               //                         color: lTextColorLight,
//               //                       ),
//               //             ),
//               //     ],
//               //   ),
//               // ),
//               RichText(
//                 maxLines: 1,
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: keyTime.tr + ':',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .copyWith(fontWeight: FontWeight.w500),
//                     ),
//                     newBookingListDataModel?.startTime == null &&
//                             newBookingListDataModel?.endTime == null
//                         ? TextSpan(text: "")
//                         : TextSpan(
//                             text: " " +
//                                 "${timeFormate(finalTime: newBookingListDataModel?.startTime)} - ${timeFormate(finalTime: newBookingListDataModel?.endTime)}",
//                             style:
//                                 Theme.of(context).textTheme.bodyText1!.copyWith(
//                                       color: lTextColorLight,
//                                     ),
//                           ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }
