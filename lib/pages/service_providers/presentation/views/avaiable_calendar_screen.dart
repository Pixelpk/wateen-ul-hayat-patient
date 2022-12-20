import 'package:swift_care/components/custom_flashbar.dart';
import 'package:swift_care/export.dart';
import 'package:swift_care/model/responseModal/slot_data_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../../../home/presentation/controllers/book_service_provider_controller.dart';


class AvailableCalendarScreen extends StatelessWidget {
  var dates = [];

  AvailableCalendarScreen(this.dates);

  @override
  Widget build(BuildContext context) {
    var stringDate = dates.map((string) => DateTime.parse(string)).toList();

    return GetBuilder<BookServiceProviderController>(builder: (controller) {
      return Scaffold(
        appBar: backAppBar2(
          context: context,
          title: text(STRING_Unavailable_Dates.tr,
              fontWeight: FontWeight.w600, fontSize: FONT_18),
        ),
        body: Container(
          height: 350,
          child: SfDateRangePicker(
            selectionColor: Colors.red,
            initialSelectedDates: stringDate,
            selectionMode: DateRangePickerSelectionMode.multiple,
          ),
        ),
      );
    });
  }

}
