import 'package:swift_care/components/custom_expension_tile.dart';
import 'package:swift_care/pages/home/presentation/controllers/home_controller.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';

import '../../../../export.dart';

class StaticPageScreen extends StatelessWidget {
  final type;

  const StaticPageScreen({Key? key, this.type}) : super(key: key);

  static HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticPageController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
            appBar: backAppBar2(context: context, title: type),
            body: type == 'FAQs'
                ? controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor)

                        ))
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: homeController.isfaq.value
                            ? ListView.builder(
                                itemBuilder: (context, index) => customTile(
                                  question: controller.faqList![index].question,
                                  answer: controller.faqList![index].answer,
                                ),
                                itemCount: controller.faqList!.length,
                              )
                            : Container(),
                      )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: text(
                      controller.desc,
                    ),
                  )),
      );
    });
  }
}

String about =
    "Flutter idea came from the daily life of university students and how they live it. Printing is one of the main tasks that students are doing it during their university life. We hear from them printing issues: its costly. I have to drive to get good price. Waiting time in copy center is killing me. I don’t have enough time to print and arrange my ideas. Flutter is stared as the first online printing platform in Kingdom of Saudi Arabia on February 2018. The idea is developed and decorated from the source of printing market (Copy Centers and Students). The service then is extended to more cities and business customers across the region. Within the first year we successfully severed customers in more than 126 cities in the gulf and we are expanding";
