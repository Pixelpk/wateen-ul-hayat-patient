import 'assigned_person_data.dart';

class BookingDetailModel {
  Detail? detail;
  String? copyrighths;

  BookingDetailModel({this.detail, this.copyrighths});

  BookingDetailModel.fromJson(Map<String, dynamic> json) {
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

class Detail {
  var id;
  var uniqueId;
  var price;
  var taxPrice;
  var finalPrice;
  var providerId;
  var addressId;
  var description;
  var paymentStatus;
  var stateId;
  var typeId;
  var createdOn;
  var createdById;
  List<Services>? services;
  CreatedBy? createdBy;

  Detail(
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

  Detail.fromJson(Map<String, dynamic> json) {
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

class Services {
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
  var description;
  var rating;
  var checkStaffRating;
  int? stateId;
  int? typeId;
  int? bookingType;
  String? createdOn;
  int? createdById;
  String? providerImage;
  String? providerName;
  String? serviceSubCat;
  String? serviceCat;
  int? serviceCatId;
  String? serviceImage;
  int? totalHours;
  var providerRating;
  var staffRating;
  var patientLatitude;
  var patientLongitude;
  var providerLatitude;
  var providerLongitude;
  AssignPerson? assignPerson;
  var vitalDetail;
  var diagnosisDetail;
  CreatedBy? createdBy;

  Services(
      {this.id,
      this.uniqueId,
      this.serviceId,
      this.bookingId,
      this.providerId,
      this.staffId,
      this.memberId,
      this.addressId,
      this.rating,
      this.checkStaffRating,
      this.date,
      this.startTime,
      this.endTime,
      this.price,
      this.slotId,
      this.description,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById,
      this.providerImage,
      this.providerRating,
      this.staffRating,
      this.providerName,
      this.serviceSubCat,
      this.serviceCat,
      this.bookingType,
      this.serviceCatId,
      this.serviceImage,
      this.totalHours,
      this.assignPerson,
      this.vitalDetail,
      this.diagnosisDetail,
      this.patientLatitude,
      this.patientLongitude,
      this.providerLatitude,
      this.providerLongitude,
      this.createdBy});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    serviceId = json['service_id'];
    bookingId = json['booking_id'];
    providerId = json['provider_id'];
    staffId = json['staff_id'];
    memberId = json['member_id'];
    rating = json['check_provider_rating'];
    addressId = json['address_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'];
    bookingType = json['booking_type'];
    providerRating = json['provider_rating'];
    staffRating = json['staff_rating'];
    checkStaffRating = json['check_staff_rating'];
    slotId = json['slot_id'];
    description = json['description'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    providerImage = json['provider_image'];
    providerName = json['provider_name'];
    serviceSubCat = json['service_sub_cat'];
    serviceCat = json['service_cat'];
    serviceCatId = json['service_cat_id'];
    serviceImage = json['service_Image'];
    patientLatitude = json['patient_latitude'];
    patientLongitude = json['patient_longitude'];
    providerLatitude = json['provider_latitude'];
    providerLongitude = json['provider_longitude'];
    totalHours = json['total_hours'];
    assignPerson = json['assign-person'] != null
        ? AssignPerson.fromJson(json['assign-person'])
        : null;
    vitalDetail = json['vital-detail'];
    diagnosisDetail = json['diagnosis-detail'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
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
    data['check_staff_rating'] = this.checkStaffRating;
    data['end_time'] = this.endTime;
    data['price'] = this.price;
    data['booking_type'] = this.bookingType;
    data['slot_id'] = this.slotId;
    data['check_provider_rating'] = this.rating;
    data['description'] = this.description;
    data['provider_rating'] = this.providerRating;
    data['staff_rating'] = this.staffRating;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['provider_image'] = this.providerImage;
    data['provider_name'] = this.providerName;
    data['service_sub_cat'] = this.serviceSubCat;
    data['service_cat'] = this.serviceCat;
    data['service_cat_id'] = this.serviceCatId;
    data['service_Image'] = this.serviceImage;
    data['total_hours'] = this.totalHours;

    data['patient_latitude'] = this.patientLatitude;
    data['patient_longitude'] = this.patientLongitude;
    data['provider_latitude'] = this.providerLatitude;
    data['provider_longitude'] = this.providerLongitude;

    if (this.assignPerson != null) {
      data['assign-person'] = this.assignPerson!.toJson();
    }
    data['vital-detail'] = this.vitalDetail;
    data['diagnosis-detail'] = this.diagnosisDetail;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  int? id;
  String? fullName;
  String? email;
  String? activationKey;
  var dateOfBirth;
  int? gender;
  String? aboutMe;
  String? countryCode;
  String? contactNo;
  String? address;
  var language;
  String? profileFile;
  var tos;
  int? roleId;
  int? stateId;
  int? typeId;
  UserDetail? userDetail;
  UserAddress? userAddress;
  var service;
  String? otp;
  int? otpVerified;
  var providerId;
  String? timezone;
  String? createdOn;

  CreatedBy(
      {this.id,
      this.fullName,
      this.email,
      this.activationKey,
      this.dateOfBirth,
      this.gender,
      this.aboutMe,
      this.countryCode,
      this.contactNo,
      this.address,
      this.language,
      this.profileFile,
      this.tos,
      this.roleId,
      this.stateId,
      this.typeId,
      this.userDetail,
      this.userAddress,
      this.service,
      this.otp,
      this.otpVerified,
      this.providerId,
      this.timezone,
      this.createdOn});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    activationKey = json['activation_key'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    aboutMe = json['about_me'];
    countryCode = json['country_code'];
    contactNo = json['contact_no'];
    address = json['address'];
    language = json['language'];
    profileFile = json['profile_file'];
    tos = json['tos'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
    userAddress = json['user_address'] != null
        ? new UserAddress.fromJson(json['user_address'])
        : null;
    service = json['service'];
    otp = json['otp'];
    otpVerified = json['otp_verified'];
    providerId = json['provider_id'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['activation_key'] = this.activationKey;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['about_me'] = this.aboutMe;
    data['country_code'] = this.countryCode;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    data['language'] = this.language;
    data['profile_file'] = this.profileFile;
    data['tos'] = this.tos;
    data['role_id'] = this.roleId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    if (this.userAddress != null) {
      data['user_address'] = this.userAddress!.toJson();
    }
    data['service'] = this.service;
    data['otp'] = this.otp;
    data['otp_verified'] = this.otpVerified;
    data['provider_id'] = this.providerId;
    data['timezone'] = this.timezone;
    data['created_on'] = this.createdOn;
    return data;
  }
}

class UserDetail {
  int? id;
  Null? businessName;
  Null? registerNo;
  String? nationality;
  String? nationalityTitle;
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

  Null? servicesSubType;

  UserDetail(
      {this.id,
      this.businessName,
      this.registerNo,
      this.nationality,
      this.nationalityTitle,
      this.certificateName,
      this.instituteName,
      this.experience,
      this.serviceType,
      this.serviceSubType,
      this.issueDate,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.createdById,
      this.servicesSubType});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    registerNo = json['register_no'];
    nationality = json['nationality'];
    nationalityTitle = json['nationality_title'];
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
    serviceType = json['serviceType'];
    servicesSubType = json['servicesSubType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['register_no'] = this.registerNo;
    data['nationality'] = this.nationality;
    data['nationality_title'] = this.nationalityTitle;
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
    data['serviceType'] = this.serviceType;
    data['servicesSubType'] = this.servicesSubType;
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
  String? otherInfo;
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

  UserAddress(
      {this.id,
      this.address,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.street,
      this.houseNo,
      this.otherInfo,
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
      this.createdById});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    street = json['street'];
    houseNo = json['house_no'];
    otherInfo = json['other_info'];
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
    data['other_info'] = this.otherInfo;
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
    return data;
  }
}
