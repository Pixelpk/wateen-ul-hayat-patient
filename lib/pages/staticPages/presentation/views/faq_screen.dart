import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swift_care/components/common_widget.dart';
import 'package:swift_care/components/custom_appbar.dart';
import 'package:swift_care/components/custom_text.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/pages/authentication/presentation/controllers/loginController.dart';
import 'package:swift_care/pages/home/presentation/controllers/book_service_provider_controller.dart';
import 'package:swift_care/pages/service_providers/presentation/views/book_now_screen.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';

import '../../../../export.dart';

class FaqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticPageController>(
        init: StaticPageController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: DefaultAppBar(
                title: STRING_FAQ.tr,
              ),
              body: ListView.separated(
                  itemCount: controller.faqList?.length ?? 0,
                  separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: DIMENS_10),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                  itemBuilder: (context, index) {
                    var item = controller.faqList![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: text(item.question ?? "",
                            maxLines: 1,
                            textAlign: TextAlign.justify,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: FONT_16),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: text(
                            item.answer ?? "",
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            fontSize: FONT_14,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
