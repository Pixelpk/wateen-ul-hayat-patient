import '../data_model/category_data_model.dart';

class BookingListModel {
  List<BookingModel>? list;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;
  BookingModel? detail;

  BookingListModel({this.list, this.lLinks, this.mMeta, this.copyrighths});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <BookingModel>[];
      json['list'].forEach((v) {
        list!.add(new BookingModel.fromJson(v));
      });
    }

    detail = json['detail'] != null
        ? new BookingModel.fromJson(json['detail'])
        : null;

    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    mMeta = json['_meta'] != null ? new Meta.fromJson(json['_meta']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    if (this.mMeta != null) {
      data['_meta'] = this.mMeta!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

class BookingModel {
  int? id;
  String? uniqueId;
  int? serviceId;
  int? bookingId;
  int? providerId;
  int? staffId;
  int? memberId;
  int? addressId;
  var date;
  String? startTime;
  String? endTime;
  String? price;
  String? slotId;
  String? providerName;
  String? providerImage;
  String? serviceSubCat;
  var description;
  int? stateId;
  int? typeId;
  String? createdOn;
  int? createdById;

  BookingModel(
      {this.id,
      this.uniqueId,
      this.serviceId,
      this.bookingId,
      this.providerId,
      this.staffId,
      this.memberId,
      this.addressId,
      this.date,
      this.startTime,
      this.endTime,
      this.price,
      this.slotId,
      this.description,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.providerName,
      this.providerImage,
      this.serviceSubCat,
      this.createdById});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    serviceId = json['service_id'];
    bookingId = json['booking_id'];
    providerId = json['provider_id'];
    staffId = json['staff_id'];
    memberId = json['member_id'];
    addressId = json['address_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'];
    slotId = json['slot_id'];
    description = json['description'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    providerName = json['provider_name'];
    providerImage = json['provider_image'];
    serviceSubCat = json['service_sub_cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['service_id'] = this.serviceId;
    data['booking_id'] = this.bookingId;
    data['provider_id'] = this.providerId;
    data['staff_id'] = this.staffId;
    data['member_id'] = this.memberId;
    data['address_id'] = this.addressId;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['price'] = this.price;
    data['slot_id'] = this.slotId;
    data['description'] = this.description;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['provider_name'] = this.providerImage;
    data['provider_image'] = this.providerImage;
    data['service_sub_cat'] = this.serviceSubCat;
    return data;
  }
}
