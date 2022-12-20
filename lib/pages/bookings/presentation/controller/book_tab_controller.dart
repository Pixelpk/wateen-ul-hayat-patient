import 'package:swift_care/export.dart';
import 'package:intl/intl.dart';

import '../../../../model/data_model/booking_model.dart';
import '../booking_info_screen.dart';

class BookTabController extends GetxController {
  List<BookingModelData>? bookingList = [];
  bool viewCurrentBooking = true;
  BookingNewModel bookingModelData = BookingNewModel();
  BookingModel? bookingModel;
  ScrollController? scrollController;
  int _currentPage = 0;
  bool isLoading = false;

  @override
  void onInit() {
    scrollController = ScrollController();
    bookingListHitApi(BOOKING_CURRENT);

    super.onInit();
  }

  timeFormat(date) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("hh:mm a").format(tempEndDate.toLocal());
      return endDate;
    }
    return "00:00";
  }

  dateFormat(date) {
    if (date != null) {
      var tempEndDate = DateTime.parse(date.toString()).toUtc();
      var endDate = DateFormat("dd-MM-yyyy").format(tempEndDate.toLocal());
      return endDate;
    }
    return "";
  }

  updateViewCurrentBooking(value) {
    viewCurrentBooking = value;
    update();
  }

  bookingListHitApi(int type) {
    _currentPage = 0;
    Loader.show(Get.context);
    APIRepository.bookingListAPiCall(type: type, page: _currentPage)
        .then((value) {
      bookingModelData = value;
      bookingList = bookingModelData.list ?? [];
      Loader.hide();
      paginatedData(type);
      update();
    }).onError((error, stackTrace) {
      Loader.hide();
      snackBar(error);
    });
  }

  void paginatedData(int type) {
    scrollController?.addListener(() {
      if (scrollController?.position.pixels ==
          scrollController?.position.maxScrollExtent) {
        if (isLoading == false) {
          _currentPage++;
          if (_currentPage < bookingModelData.mMeta!.pageCount!) {
            isLoading = true;
            Timer.periodic(Duration(milliseconds: 500), (timer) async {
              timer.cancel();
              await APIRepository.bookingListAPiCall(
                      type: type, page: _currentPage)
                  .then((value) {
                bookingModelData = value;
                bookingList?.addAll(bookingModelData.list ?? []);
                isLoading = false;
                update();
              }).onError((error, stackTrace) {
                snackBar(error);
              });
            });
            update();
          } else {
            isLoading = false;
            update();
          }
        }
      }
    });
  }
}

BookingModelData dummyBookingModelData = BookingModelData(
  id: 123,
  uniqueId: 'acnd',
  price: '12',
  providerId: 24,
  paymentStatus: 0,
  taxPrice: '12',
  finalPrice: '121',
  addressId: 121,
  description: 'aanc',
  stateId: 12,
  typeId: 121,
  createdOn: null,
  createdById: 12,
  services: [],
  createdBy: null,
);
