import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/components/primary_button.dart';

import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';

import '../../../../export.dart';
import '../../../model/data_model/booking_detail_model.dart';
import '../../../service/remote_service/network/endpoint.dart';

class RateProviderScreen extends StatelessWidget {
  Services? bookingList;
  int? id;
  int? type;

  RateProviderScreen({this.bookingList, this.id, this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceProviderController>(
        init: BookServiceProviderController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: DefaultAppBar(
                title: STRING_Rating.tr,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: cardDecoration,
                      margin: EdgeInsets.symmetric(
                          horizontal: hMargin, vertical: hMargin),
                      child: Column(children: [
                        vGap(16),
                        userImage(),
                        vGap(DIMENS_10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            type == 0
                                ? '${bookingList?.providerName ?? ""}'
                                : '${bookingList?.assignPerson?.fullName ?? ""}',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RatingBar.builder(
                              initialRating: controller.rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: DIMENS_30,
                              glow: false,
                              itemPadding: EdgeInsets.symmetric(horizontal: 1),
                              itemBuilder: (context, _) => Icon(
                                Icons.star_rounded,
                                color: buttonColor,
                                size: DIMENS_5,
                              ),
                              onRatingUpdate: (rating) {
                                controller.rating = rating;
                                controller.update();
                              },
                            )),
                        vGap(DIMENS_20),
                        _personalInfo(controller, context),
                        vGap(DIMENS_20),
                      ]),
                    ),
                    vGap(DIMENS_20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 49),
                      child: PrimaryButton(
                        onPressed: () {
                          if (controller.rating.isGreaterThan(0)) {
                            controller.hitGiveRatingApi(
                                bookingList?.id ?? 0,
                                bookingList?.providerId,
                                bookingList?.assignPerson?.id,
                                type);
                          } else {
                            snackBar(STRING_PleaseGiveRating.tr);
                          }
                        },
                        buttonText: STRING_Submit.tr,
                      ),
                    ),
                    vGap(100)
                  ],
                ),
              ),
            ),
          );
        });
  }

  userImage() {
    return Center(
        child: Container(
      height: DIMENS_80,
      width: DIMENS_80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imageNetwork(
          type == 0
              ? '$imageUrl${bookingList?.providerImage}'
              : '$imageUrl${bookingList?.assignPerson!.profileFile}',
          fit: BoxFit.cover,
        ),
      ),
    )
        //                   Container(
        //   height: DIMENS_90,
        //   width: DIMENS_90,
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: type == 0
        //               ? NetworkImage('$imageUrl${bookingList?.providerImage}')
        //               : NetworkImage(
        //                   '$imageUrl${bookingList?.assignPerson!.profileFile}'),
        //           fit: BoxFit.fill),
        //       color: Colors.grey.shade100,
        //       shape: BoxShape.circle,
        //       boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)]),
        // ),
        );
  }

  divider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 5,
    );
  }

  _personalInfo(
      BookServiceProviderController controller, BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: DIMENS_20, vertical: DIMENS_10),
          child: Text(
            STRING_WriteSomething.tr,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: DIMENS_20,
          ),
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(DIMENS_10),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.shade300,
          //         blurRadius: 3,
          //       )
          //     ]),
          child: TextField(
            controller: controller.commentController,
            maxLines: 6,
            decoration: InputDecoration(
              hintStyle: textStyle(color: Colors.black, fontSize: FONT_16),
            ),
          ),
        ),
      ],
    );
  }

  _fieldLayout({title, subtitle}) {
    return ListTile(
      title: text(title ?? '', fontWeight: FontWeight.w500),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: text(subtitle ?? '',
            color: indigoColor, fontWeight: FontWeight.w500),
      ),
    );
  }

  _certificateFieldLayout() {
    return ListTile(
      title: text(STRING_certifications.tr, fontWeight: FontWeight.w500),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(bottom: 20),
        height: DIMENS_80,
        width: DIMENS_80,
        alignment: Alignment.topLeft,
        child: imageAsset(ICON_certificate, fit: BoxFit.contain),
      ),
    );
  }

  _uploadedImagesFieldLayout() {
    return ListTile(
      title: text('Uploaded Images', fontWeight: FontWeight.w500),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(bottom: 20),
        height: DIMENS_80,
        width: DIMENS_80,
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            imageAsset(IMAGE_dummy2, fit: BoxFit.contain),
            hGap(10),
            imageAsset(IMAGE_dummy2, fit: BoxFit.contain),
            hGap(10),
            imageAsset(IMAGE_dummy2, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }

  _services() {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _serviceLayout(),
        separatorBuilder: (context, index) => Divider(
              color: Colors.grey.shade300,
              thickness: 2,
            ),
        itemCount: 8);
  }

  _availability() {
    return Container();
  }

  _serviceLayout() {
    return Container(
      height: DIMENS_90,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                text('Home Consultant-Nursing Assessment',
                    fontSize: FONT_16, maxLines: 2),
                vGap(DIMENS_15),
                Row(
                  children: [
                    Expanded(
                        child: text('$STRING_gender: Female',
                            fontSize: FONT_14, color: Colors.grey)),
                    Expanded(
                        child: text('$STRING_price: ${STRING_CURRENCY.tr} 110',
                            fontSize: FONT_14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  // Get.to(BookNowScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      color: indigoColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: text('ADD', color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget doubleText(topText, bottomText) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(topText, maxLines: 1, fontSize: 16),
        vGap(4),
        text(bottomText,
            color: Colors.black, isBold: true, fontSize: 16, maxLines: 1),
      ],
    );
