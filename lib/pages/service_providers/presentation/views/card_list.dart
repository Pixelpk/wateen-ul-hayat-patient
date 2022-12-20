import 'package:swift_care/export.dart';
import 'package:swift_care/model/data_model/card_details.dart';
import 'package:swift_care/pages/service_providers/presentation/controllers/card_controller.dart';
import 'package:swift_care/pages/service_providers/presentation/controllers/card_controller.dart';
import 'package:swift_care/pages/service_providers/presentation/views/add_card.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';

import '../../../../components/custom_sheet.dart';

class CardListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
      init: CardController(),
      builder: (controller) {
        return SafeArea(
            child: Scaffold(
          appBar: backAppBar2(
            onBackPress: () {
              Get.back(result: true);
            },
            context: context,
            title: text(STRING_CardList.tr,
                fontWeight: FontWeight.w600, fontSize: FONT_18),
          ),
          body: Stack(
            children: [
              Column(
                children: [cardListView(controller), vGap(65)],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: cbtnElevatedButton(
                      onPressed: () {
                        Get.to(AddCard());
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(DIMENS_8)),
                      height: DIMENS_50,
                      textStyle: textStyle(fontWeight: FontWeight.bold),
                      label: STRING_AddCard.tr,
                      backgroundColor: appColor),
                ),
              )
            ],
          ),
        ));
      },
    );
  }

  cardListView(CardController controller) {
    return Expanded(
      child: controller.cardList?.length != 0
          ? ListView.builder(
              itemCount: controller.cardList?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = controller.cardList?[index];
                return cardView(index, controller, item);
              },
            )
          : Center(child: text(STRING_NoCardAdded.tr)),
    );
  }

  cardView(int index, CardController controller, CardDetails? item) {
    return InkWell(
      onTap: () {
        controller.hitDefaultCardAPI(item?.id ?? 0);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color: Colors.blueAccent,
                  width: item?.isDefault == 1 ? 2.5 : 0.0)),
          height: 200.0,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff4372ff),
                      Color(0xff41bdfe),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    vGap(15.0),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                            onTap: () {
                              openCustomDialogue(
                                  customText: "$STRING_Delete_cart".tr,
                                  onYes: () {
                                    controller.hitDeleteCardAPI(item?.id);
                                    Get.back();
                                  },
                                  onNo: () {
                                    Get.back();
                                  });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    vGap(30.0),
                    text('xxxx-xxxx-xxxx-${item?.last4}',
                        fontSize: 23.0, color: Colors.white),
                    vGap(6.0),
                    Row(
                      children: [
                        text('${item?.brand}', color: Colors.white),
                        Spacer(),
                        item!.expMonth! <= 10
                            ? text(
                                '${STRING_ex_date.tr} 0${item.expMonth}/${item.expYear}',
                                color: Colors.white)
                            : text(
                                '${STRING_ex_date.tr} ${item.expMonth}/${item.expYear}',
                                color: Colors.white),
                      ],
                    ),
                    vGap(5.0)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
