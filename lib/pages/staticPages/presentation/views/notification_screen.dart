import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';
import '../../../../export.dart';
import '../../../../model/responseModal/notification_data_model.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticPageController>(
        init: StaticPageController(),
        builder: (controller) {
          return Scaffold(
            appBar: DefaultAppBar(
              title: STRING_Notifications.tr,
              showBackButton: false,
            ),
            body: controller.notificationList.isNotEmpty
                ? ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.notificationList.length,
                    // separatorBuilder: (context, index) => Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: DIMENS_10),
                    //   child: Divider(
                    //     thickness: 1,
                    //   ),
                    // ),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Theme.of(context).cardColor,
                        margin: EdgeInsets.symmetric(
                            horizontal: hMargin, vertical: 10),
                        child: _notificationView(context,
                            controller.notificationList[index], controller),
                      ),
                      //  ListTile(
                      //     contentPadding: EdgeInsets.zero,
                      //     leading: Container(
                      //       height: DIMENS_50,
                      //       width: DIMENS_50,
                      //       child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(DIMENS_50),
                      //           child: imageAsset(ICON_appLogo)),
                      //     ),
                      //     title: Padding(
                      //       padding: const EdgeInsets.only(top: 10.0),
                      //       child: text(controller.notificationList[index].userName ?? "",
                      //           maxLines: 1,
                      //           textAlign: TextAlign.justify,
                      //           color: indigoColor,
                      //           fontWeight: FontWeight.w500),
                      //     ),
                      //     subtitle: Padding(
                      //       padding: const EdgeInsets.only(top: 8.0),
                      //       child: text(
                      //           controller.notificationList[index].title ?? "",
                      //           maxLines: 3,
                      //           fontSize: FONT_14),
                      //     ),
                      //     trailing: Column(
                      //       children: [
                      //         text(controller.timeAgo(controller.convertTimeToLocal(dateString: controller.notificationList[index].createdOn)),
                      //             maxLines: 2,
                      //             textAlign: TextAlign.justify,
                      //             fontSize: FONT_13,
                      //             color: Colors.black),
                      //       ],
                      //     )),
                    ),
                  )
                : Center(child: text(STRING_NoNotifications.tr)),
          );
        });
  }

  _notificationView(BuildContext context, NotificationData? item,
      StaticPageController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Container(
            height: DIMENS_50,
            width: DIMENS_50,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff298999),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DIMENS_50),
              child: imageAsset(ICON_appLogo),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: DIMENS_15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(item?.userName ?? "",
                          maxLines: 1,
                          color: indigoColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: text(
                            controller.timeAgo(controller.convertTimeToLocal(
                                dateString: item?.createdOn)),
                            maxLines: 1,
                            fontSize: 12,
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: DIMENS_5, bottom: DIMENS_10),
                    height: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                  text(item?.title ?? "",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w400,
                      fontSize: FONT_13),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
