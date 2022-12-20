import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swift_care/export.dart';
import 'package:swift_care/model/responseModal/categorylist_response_modal.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import 'package:swift_care/service/remote_service/network/endpoint.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<TopRatedSubCatgories> topRatedSubCategories;

  ImageSliderWidget({required this.topRatedSubCategories});

  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: widget.topRatedSubCategories.length ?? 0,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return InkWell(
                onTap: () {
                  print("Services called");
                  var ctrl = Get.put(BookServiceProviderController());

                  ctrl.getLocation(
                      categoryId:
                          widget.topRatedSubCategories[itemIndex].categoryId,
                      id: widget.topRatedSubCategories[itemIndex].id);

                  ctrl.update();
                },
                child: Stack(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 135,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color(0x14000000),
                        //     blurRadius: 24,
                        //     offset: Offset(0, 12),
                        //   ),
                        // ],
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Color(0xff09bede), Color(0xffB6E9F2)],
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 60,
                            child: CachedNetworkImage(
                              imageUrl: widget.topRatedSubCategories[itemIndex]
                                          .image !=
                                      null
                                  ? (imageUrl +
                                      widget.topRatedSubCategories[itemIndex]
                                          .image!)
                                  : "",
                              placeholder: (context, url) =>
                                  Image.asset("assets/images/banner_logo.png"),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/banner_logo.png"),
                            ),
                          ),
                          hGap(12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              vGap(10),
                              Container(
                                width: 241,
                                child: Text(
                                    widget.topRatedSubCategories[itemIndex]
                                            .title ??
                                        "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Colors.white,
                                          height: 1,
                                          fontWeight: FontWeight.w600,
                                        )),
                              ),
                              vGap(8),
                              Container(
                                width: 241,
                                height: 1,
                                color: Colors.white,
                              ),
                              vGap(8),
                              Container(
                                width: 241,
                                child: Text(
                                  widget.topRatedSubCategories[itemIndex]
                                          .description ??
                                      "",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: Colors.white, height: 1),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 80,
                        height: 20,
                        // margin: EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            //  topStart: Radius.circular(20),
                            topEnd: Radius.circular(20),
                            bottomStart: Radius.circular(20),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Color(0x14000000),
                          //     blurRadius: 24,
                          //     offset: Offset(0, 12),
                          //   ),
                          // ],
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(STRING_feature.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              aspectRatio: 2 / 0.8,
              viewportFraction: 1.0,

              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 1600),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              pageSnapping: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, onPageChanged) {
                pageIndex = index;
                setState(() {});
              },
              scrollDirection: Axis.horizontal,
            )),
        SizedBox(
          height: 10,
        ),
        if (widget.topRatedSubCategories.isNotEmpty)
          Center(
            child: Container(
              child: CarouselIndicator(
                count: widget.topRatedSubCategories.length ?? 0,
                index: pageIndex,
                height: 8,
                width: 8,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
      ],
    );
  }
}
