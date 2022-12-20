import 'package:geolocator/geolocator.dart';
import 'package:swift_care/components/custom_divider.dart';
import 'package:swift_care/components/title_subtitle_widgets.dart';

import '../export.dart';
import '../model/data_model/booking_detail_model.dart';
import '../pages/bookings/presentation/submit_rating_screen.dart';
import '../service/remote_service/network/endpoint.dart';

class ServiceProviderWidget extends StatelessWidget {
  final BookingDetailModel? bookingDetailModel;
  final BookingListModel? bookingListModel;
  final EdgeInsetsGeometry? margin;

  const ServiceProviderWidget(
      {Key? key,
      required this.bookingDetailModel,
      required this.bookingListModel,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              EdgeInsetsDirectional.only(start: DIMENS_10, top: 10, bottom: 20),
          margin: margin ?? EdgeInsets.symmetric(horizontal: hMargin),
          decoration: cardDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
              if (bookingDetailModel?.detail?.services != null &&
                  bookingDetailModel!.detail!.services!.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: DIMENS_80,
                        width: DIMENS_80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageNetwork(
                                '$imageUrl${bookingDetailModel?.detail?.services?[0].providerImage ?? ""}',
                                fit: BoxFit.cover))),
                    hGap(10),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 8.0),
                              child: Text(
                                (bookingDetailModel
                                        ?.detail?.services?[0].providerName ??
                                    ""),
                                // .limitToSpecificLength(18),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: buttonColor,
                                    ),
                              ),
                            ),
                            // Text(
                            //   calcDistance(
                            //           double.parse(bookingDetailModel?.detail
                            //               ?.services?[0].patientLatitude),
                            //           double.parse(bookingDetailModel?.detail
                            //               ?.services?[0].patientLongitude),
                            //           double.parse(bookingDetailModel?.detail
                            //               ?.services?[0].providerLatitude),
                            //           double.parse(bookingDetailModel?.detail
                            //               ?.services?[0].providerLongitude))
                            //       .toString(),
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headline4!
                            //       .copyWith(
                            //         color: buttonColor,
                            //       ),
                            // ),
                            SizedBox(
                              height: 6,
                            ),
                            CustomDivider(),
                            SizedBox(
                              height: 6,
                            ),
                            TitleSubtitleRichText(
                              title: '${STRING_price.tr}: ',
                              subtitle:
                                  '${STRING_CURRENCY.tr} ${bookingDetailModel?.detail?.price}',
                              isPrimaryColor: true,
                            ),
                            vGap(5),
                            SizedBox(
                              width: Get.width * 0.45,
                              child: text(
                                  bookingListModel?.detail?.serviceSubCat ?? "",
                                  maxLines: 2,
                                  fontSize: FONT_12,
                                  color: Colors.black54),
                            ),
                            Visibility(
                              visible:
                                  bookingDetailModel?.detail?.stateId == 4 &&
                                          bookingDetailModel?.detail
                                                  ?.services?[0].rating ==
                                              false
                                      ? true
                                      : false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(RateProviderScreen(
                                        type: 0,
                                        bookingList: bookingDetailModel
                                            ?.detail?.services?[0],
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 15),
                                      child: Text(
                                        STRING_GiveRating.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: primaryColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        PositionedDirectional(
            end: 40,
            top: 10,
            child: Container(
              // padding: EdgeInsetsDirectional.only(end: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: buttonColor,
                    size: 12,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    bookingDetailModel?.detail?.services?[0].providerRating !=
                            null
                        ? double.parse(bookingDetailModel
                                ?.detail?.services?[0].providerRating)
                            .toStringAsFixed(1)
                        : "0.0",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: buttonColor,
                        ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  calcDistance(startLatitude, startLongitude, endLatitude, endLongitude) {
    var distancee = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    var dist = distancee / 1000;
    double distance = dist;
    return distance.toStringAsFixed(2) + " Km";
  }
}
