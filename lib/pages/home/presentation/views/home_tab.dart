import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swift_care/model/data_model/categorylist_item_data_modal.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import 'package:swift_care/pages/home/presentation/controllers/home_tab_controller.dart';
import 'package:swift_care/pages/home/presentation/views/subcategory_view.dart';

import '../../../../components/image_slider_widget.dart';
import '../../../../export.dart';
import '../../../../service/remote_service/network/endpoint.dart';
import '../../../authentication/presentation/controllers/profile_controller.dart';
import '../../../cart/presentation/cart_screen.dart';
import '../../../cart/presentation/controller/cart_controller.dart';

class HomeTab extends StatelessWidget {
  final formGlobalKey = GlobalKey<FormState>();
  var ctrl = Get.put(HomeTabController());
  var profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeTabController>(builder: (controller) {
      return Listener(
        onPointerDown: (event) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: Scaffold(
            extendBody: true, body: servicesListView(controller, context)),
      );
    });
  }

  servicesListView(HomeTabController controller, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              vGap(20),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: (){

                      },
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: Get.width * 0.25,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        var ctrl = Get.put(CartController());
                        ctrl.queryAll();
                        Get.to(CartScreen(ctrl.providerId));
                      },
                      child: Container(
                          height: 25,
                          width: 25,
                          child:
                              SvgPicture.asset("assets/images/cart_icon.svg")))
                ],
              ),
              vGap(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(28),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xff11abc6),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: (profileController
                                  .loginModel!.detail?.profileFile !=
                              null)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(DIMENS_90),
                              child: imageNetwork(
                                  '$imageUrl${profileController.loginModel?.detail?.profileFile ?? ''}',
                                  fit: BoxFit.cover,
                                  isMember: true,
                                  width: 150),
                            )
                          : Image.asset(
                              "assets/images/person_placeholder.png")),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getGreeting(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  height: 1,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold)),
                      Text(profileController.loginModel?.detail?.fullName ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  height: 1))
                    ],
                  )
                ],
              ),
              vGap(20),
            ],
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  if (controller.topRatedSubCategories.isNotEmpty)
                    SliverAppBar(
                      pinned: false,
                      floating: false,
                      backgroundColor: Colors.transparent,
                      expandedHeight: 200,
                      collapsedHeight: 200,
                      automaticallyImplyLeading: false,
                      stretch: true,
                      flexibleSpace: Column(
                        children: [
                          ImageSliderWidget(
                            topRatedSubCategories:
                                controller.topRatedSubCategories,
                          ),
                          vGap(20),
                        ],
                      ),
                    ),
                ];
              },
              physics: BouncingScrollPhysics(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(STRING_services.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 15, color: primaryColor)),
                  vGap(10),
                  Container(
                    width: Get.width,
                    height: 1,
                    color: primaryColor,
                  ),
                  vGap(10),
                  Expanded(
                    child: controller.allServiceIssueList.isNotEmpty
                        ? SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1 / 1.3,
                                      crossAxisSpacing: Get.width * 0.025,
                                      mainAxisSpacing: Get.height * 0.03,
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.allServiceIssueList.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      CategoryListItem categoryListItem =
                                          controller.allServiceIssueList[index];
                                      return InkWell(
                                          onTap: () async {
                                            controller.serviceSubTypeHitApi(
                                                categoryListItem.id!);
                                            Get.to(() =>
                                                SubCategoryView(index: index));
                                          },
                                          child: Container(
                                            width: 118,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x14000000),
                                                  blurRadius: 24,
                                                  offset: Offset(0, 12),
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color(0xff09bede),
                                                  Color(0xffB6E9F2)
                                                ],
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                vGap(12),
                                                Container(
                                                    height: DIMENS_60,
                                                    width: DIMENS_60,
                                                    decoration: BoxDecoration(
                                                      // color: COLOR_BG,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child:
                                                            circleImageNetWorkTwo(
                                                          imageurl: controller
                                                              .allServiceIssueList[
                                                                  index]
                                                              .imageFile,
                                                        ))),
                                                Spacer(),
                                                Container(
                                                  width: 118,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0),
                                                      topRight:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                    ),
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                                  child: Text(
                                                      categoryListItem.title!,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            color: primaryColor,
                                                            height: 1,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          )),
                                                )
                                              ],
                                            ),
                                          ));
                                    }),
                                vGap(20)
                              ],
                            ),
                          )
                        : Center(
                            child: text(STRING_NoServiceAvailable.tr),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return STRING_GoodMorning.tr;
    }
    if (hour < 17) {
      return STRING_GoodAfternoon.tr;
    }
    return STRING_GoodEvening.tr;
  }

  serviceLayout(int index, HomeTabController controller) {
    return InkWell(
      onTap: () {
        controller
            .serviceSubTypeHitApi(controller.allServiceIssueList[index].id!);
        serviceTypeDialog(controller, index);
        controller.updateViewServiceDialog(false);
      },
      child: Container(
        height: DIMENS_85,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: fadeBlue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ]),
        child: Row(
          children: [
            Container(
                height: DIMENS_60,
                width: DIMENS_60,
                decoration: BoxDecoration(
                  color: COLOR_BG,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: circleImageNetWorkTwo(
                      imageurl: controller.allServiceIssueList[index].imageFile,
                    ))),
            hGap(20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(controller.allServiceIssueList[index].title!,
                      isBold: true),
                  vGap(10),
                  text(controller.allServiceIssueList[index].description ?? "",
                      maxLines: 2, fontSize: FONT_12, color: Colors.black54)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  searchField(HomeTabController controller) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
              )
            ]),
        child: TextFormField(
          onChanged: (value) {
            controller.serviceTypeHitApi(value);
          },
          cursorColor: appColor,
          focusNode: controller.searchFocusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 18),
            hintText: STRING_Search.tr,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ));
  }

  serviceTypeDialog(HomeTabController controller, int index) {
    Get.dialog(
        AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.zero,
          content: GetBuilder<HomeTabController>(builder: (controller) {
            return Container(
              height: Get.height * 0.6,
              width: Get.width * 0.8,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: appColor,
                      ),
                      alignment: Alignment.center,
                      child: text(
                          controller.allServiceIssueList[index].title ?? "",
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  controller.allSubServiceIssueList.length != 0
                      ? Expanded(
                          child: Container(
                            child: controller.viewServiceDialog == true
                                ? orderNowDialogLayout(
                                    controller.index1, controller)
                                : ListView.separated(
                                    controller:
                                        controller.subServiceScrollController,
                                    shrinkWrap: true,
                                    itemCount: controller
                                        .allSubServiceIssueList.length,
                                    itemBuilder: (context, index) {
                                      return _serviceTypeLayout(
                                          index,
                                          controller,
                                          controller
                                              .allSubServiceIssueList[index]
                                              .description);
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(color: Colors.grey),
                                  ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                          child: text(STRING_NoServiceFound.tr),
                        )),
                ],
              ),
            );
          }),
        ),
        barrierColor: Colors.transparent);
  }

  orderNowDialogLayout(int index, HomeTabController controller) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Html(
            data: controller.description ?? "",
          )),
          cbtnElevatedButton(
              onPressed: () {
                Get.back();
                var ctrl = Get.put(BookServiceProviderController());

                ctrl.getLocation(
                    categoryId:
                        controller.allSubServiceIssueList[index].categoryId,
                    id: controller.allSubServiceIssueList[index].id);

                ctrl.update();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DIMENS_8)),
              height: DIMENS_40,
              label: STRING_orderNow.tr,
              backgroundColor: appColor),
        ],
      ),
    );
  }

  _serviceTypeLayout(
      int index1, HomeTabController controller, String? description) {
    return InkWell(
      onTap: () {
        controller.description = description;
        controller.updateViewServiceDialog(true);
        controller.index1 = index1;
        controller.update();
      },
      child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: text(controller.allSubServiceIssueList[index1].title ?? "",
                  color: Colors.black, maxLines: 2),
              trailing: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.black,
                size: 35,
              ))),
    );
  }
}
