import 'package:flutter_html/flutter_html.dart';
import 'package:swift_care/components/custom_appbar.dart';
import 'package:swift_care/components/custom_text.dart';
import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';

import '../../../../export.dart';

class StaticPageScreen extends StatelessWidget {
  String title;

  StaticPageScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticPageController>(
        init: StaticPageController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              appBar: DefaultAppBar(
                title: title,
              ),

              // backAppBar2(
              //   context: context,
              //   title: Html(
              //     data: title,
              //   ),
              // ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: controller.desc != null
                    ? SingleChildScrollView(
                        child: Html(data: controller.desc ?? ""))
                    : Center(child: text('No Data Found')),
              ),
            ),
          );
        });
  }
}
