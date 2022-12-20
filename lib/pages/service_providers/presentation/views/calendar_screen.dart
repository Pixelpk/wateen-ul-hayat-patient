import 'package:swift_care/components/default_app_bar.dart';
import 'package:swift_care/export.dart';
import 'package:swift_care/model/responseModal/slot_data_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../../home/presentation/controllers/book_service_provider_controller.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceProviderController>(builder: (controller) {
      return Scaffold(
        appBar: DefaultAppBar(
          title: STRING_Slots.tr,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 350,
                decoration: cardDecoration,
                padding: EdgeInsets.symmetric(
                  // horizontal: hMargin,
                  vertical: vMargin,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: hMargin,
                  vertical: vMargin,
                ),
                child: SfDateRangePicker(
                  extendableRangeSelectionDirection:
                      ExtendableRangeSelectionDirection.forward,
                  selectableDayPredicate: (DateTime val) =>
                      val.difference(DateTime.now()).inDays >= 0 ? true : false,
                  initialSelectedDate: DateTime.now(),
                  onSelectionChanged: controller.onSelectionChanged,
                  showNavigationArrow: true,
                  headerStyle:
                      DateRangePickerHeaderStyle(textAlign: TextAlign.center),
                  headerHeight: 30,
                  selectionColor: buttonColor,
                ),
              ),
              _slotListView(controller)
            ],
          ),
        ),
      );
    });
  }

  _slotListView(BookServiceProviderController controller) {
    return controller.availabilityList.isEmpty
        ? Container(
            margin: EdgeInsets.only(top: Get.height * 0.15),
            child: Center(
                child: Text(
              STRING_NoSlot.tr,
              textAlign: TextAlign.center,
              style: Theme.of(Get.context!).textTheme.headline3,
            )),
          )
        : SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: hMargin,
                vertical: vMargin,
              ),
              child: GridView.builder(
                itemCount: controller.availabilityList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 4.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  var item = controller.availabilityList[index];
                  return Visibility(
                      visible: controller.availabilityList.length != 0
                          ? true
                          : false,
                      child: slotListLayout(index, controller, item, context));
                },
              ),
            ),
          );
  }

  slotListLayout(int index, BookServiceProviderController controller,
      SlotDataModel item, BuildContext context) {
    var temp = DateTime.parse(item.startTime.toString()).toUtc();
    var startDate = DateFormat("hh:mm aaa").format(temp.toLocal());

    var tempEndDate = DateTime.parse(item.endTime.toString()).toUtc();
    var endDate = DateFormat("hh:mm aaa").format(tempEndDate.toLocal());
    return InkWell(
      onTap: () {
        if (item.typeId == 0) {
          Get.back(result: item);
        } else {
          snackBar(STRING_AlreadyBooked.tr);
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
            color: item.typeId == 0 ? buttonColor : Colors.grey,
            borderRadius: BorderRadius.circular(10)),
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              '$startDate-$endDate',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).cardColor,
                  ),
            )),
      ),
    );
  }
}
