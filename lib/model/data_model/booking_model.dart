import '../responseModal/nationalities_response_model.dart';
import 'booking_detail_model.dart';

class BookingNewModel {
  List<BookingModelData>? list;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;

  BookingNewModel({this.list, this.lLinks, this.mMeta, this.copyrighths});

  BookingNewModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <BookingModelData>[];
      json['list'].forEach((v) {
        list!.add(new BookingModelData.fromJson(v));
      });
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    mMeta = json['_meta'] != null ? new Meta.fromJson(json['_meta']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
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

class BookingModelData {
  int? id;
  String? uniqueId;
  String? price;
  String? taxPrice;
  String? finalPrice;
  int? providerId;
  int? addressId;
  var description;
  int? paymentStatus;
  int? stateId;
  int? typeId;
  String? createdOn;
  int? createdById;
  List<Services>? services;
  CreatedBy? createdBy;

  BookingModelData(
      {this.id,
        this.uniqueId,
        this.price,
        this.taxPrice,
        this.finalPrice,
        this.providerId,
        this.addressId,
        this.description,
        this.paymentStatus,
        this.stateId,
        this.typeId,
        this.createdOn,
        this.createdById,
        this.services,
        this.createdBy});

  BookingModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    price = json['price'];
    taxPrice = json['tax_price'];
    finalPrice = json['final_price'];
    providerId = json['provider_id'];
    addressId = json['address_id'];
    description = json['description'];
    paymentStatus = json['payment_status'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['price'] = this.price;
    data['tax_price'] = this.taxPrice;
    data['final_price'] = this.finalPrice;
    data['provider_id'] = this.providerId;
    data['address_id'] = this.addressId;
    data['description'] = this.description;
    data['payment_status'] = this.paymentStatus;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    return data;
  }
}


class UserDetail {
  int? id;
  var businessName;
  var registerNo;
  String? nationality;
  String? certificateName;
  String? instituteName;
  String? experience;
  String? serviceType;
  String? serviceSubType;
  String? issueDate;
  int? typeId;
  int? stateId;
  String? createdOn;
  int? createdById;

  UserDetail(
      {this.id,
        this.businessName,
        this.registerNo,
        this.nationality,
        this.certificateName,
        this.instituteName,
        this.experience,
        this.serviceType,
        this.serviceSubType,
        this.issueDate,
        this.typeId,
        this.stateId,
        this.createdOn,
        this.createdById});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    registerNo = json['register_no'];
    nationality = json['nationality'];
    certificateName = json['certificate_name'];
    instituteName = json['institute_name'];
    experience = json['experience'];
    serviceType = json['service_type'];
    serviceSubType = json['service_sub_type'];
    issueDate = json['issue_date'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['register_no'] = this.registerNo;
    data['nationality'] = this.nationality;
    data['certificate_name'] = this.certificateName;
    data['institute_name'] = this.instituteName;
    data['experience'] = this.experience;
    data['service_type'] = this.serviceType;
    data['service_sub_type'] = this.serviceSubType;
    data['issue_date'] = this.issueDate;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

class UserAddress {
  int? id;
  String? address;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? street;
  String? houseNo;
  int? isDefault;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? latitude;
  String? longitude;
  int? stateId;
  int? typeId;
  String? createdOn;
  int? createdById;
  String? otherInfo;

  UserAddress(
      {this.id,
        this.address,
        this.fullName,
        this.email,
        this.phoneNumber,
        this.street,
        this.houseNo,
        this.isDefault,
        this.city,
        this.state,
        this.country,
        this.zipcode,
        this.latitude,
        this.longitude,
        this.stateId,
        this.typeId,
        this.createdOn,
        this.createdById,
        this.otherInfo});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    street = json['street'];
    houseNo = json['house_no'];
    isDefault = json['is_default'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipcode = json['zipcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    otherInfo = json['other_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['street'] = this.street;
    data['house_no'] = this.houseNo;
    data['is_default'] = this.isDefault;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['other_info'] = this.otherInfo;
    return data;
  }
}


