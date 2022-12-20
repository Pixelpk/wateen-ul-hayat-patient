import 'package:swift_care/model/data_model/service_provider_model.dart';
import 'package:swift_care/model/responseModal/family_response_model.dart';

class ServiceProviderDetailModel {
  List<Service>? list;
  Detail? detail;
  String? copyrighths;

  ServiceProviderDetailModel({this.detail, this.copyrighths});

  ServiceProviderDetailModel.fromJson(Map<String, dynamic> json) {
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
  var fullName;
  var email;
  var activationKey;
  var dateOfBirth;
  var gender;
  var countryCode;
  var contactNo;
  var language;
  var providerRating;
  var providerRatingCount;
  var profileFile;
  var tos;
  var roleId;
  var stateId;
  var typeId;
  UserDetail? userDetail;
  UserAddress? userAddress;
  Service? service;
  var otp;
  var otpVerified;
  var timezone;
  var createdOn;
  var providerAddress;
  List<FamilyMember>? familyMember;
  List<Certificates>? certificates;

  Detail(
      {this.id,
      this.fullName,
      this.email,
      this.activationKey,
      this.dateOfBirth,
      this.gender,
      this.countryCode,
      this.contactNo,
      this.providerRating,
      this.providerRatingCount,
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
      this.timezone,
      this.createdOn,
      this.providerAddress,
      this.familyMember,
      this.certificates});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    activationKey = json['activation_key'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    countryCode = json['country_code'];
    contactNo = json['contact_no'];
    language = json['language'];
    providerRating = json['provider_rating'];
    providerRatingCount = json['provider_rating_count'];
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
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    otp = json['otp'];
    otpVerified = json['otp_verified'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
    providerAddress = json['Provider Address'];

    if (json['certificates'] != null) {
      certificates = <Certificates>[];
      json['certificates'].forEach((v) {
        certificates!.add(new Certificates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['activation_key'] = this.activationKey;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['country_code'] = this.countryCode;
    data['contact_no'] = this.contactNo;
    data['language'] = this.language;
    data['profile_file'] = this.profileFile;
    data['provider_rating'] = this.providerRating;
    data['provider_rating_count'] = this.providerRatingCount;
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
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['otp'] = this.otp;
    data['otp_verified'] = this.otpVerified;
    data['timezone'] = this.timezone;
    data['created_on'] = this.createdOn;
    data['Provider Address'] = this.providerAddress;

    if (this.certificates != null) {
      data['certificates'] = this.certificates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAddress {
  int? id;
  String? houseNo;
  String? street;
  String? otherInfo;
  int? stateId;
  int? typeId;
  String? createdOn;
  int? createdById;

  UserAddress(
      {this.id,
      this.houseNo,
      this.street,
      this.otherInfo,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    houseNo = json['house_no'];
    street = json['street'];
    otherInfo = json['other_info'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['house_no'] = this.houseNo;
    data['street'] = this.street;
    data['other_info'] = this.otherInfo;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

class Service {
  int? id;
  int? categoryId;
  int? subCategoryId;
  String? price;
  int? gender;
  int? typeId;
  int? stateId;
  String? createdOn;
  int? createdById;
  Category? category;
  CreatedBy? createdBy;
  SubCategory? subCategory;
  String? subCategoryName;

  Service(
      {this.id,
      this.categoryId,
      this.subCategoryId,
      this.price,
      this.gender,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.createdById,
      this.category,
      this.createdBy,
      this.subCategoryName,
      this.subCategory});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    price = json['price'];
    gender = json['gender'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    subCategoryName = json['sub_category_name'];
    createdById = json['created_by_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    subCategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['price'] = this.price;
    data['gender'] = this.gender;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['sub_category_name'] = this.subCategoryName;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? title;
  String? imageFile;
  Null? description;
  int? typeId;
  int? stateId;
  String? createdOn;
  int? createdById;

  Category(
      {this.id,
      this.title,
      this.imageFile,
      this.description,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.createdById});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageFile = json['image_file'];
    description = json['description'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_file'] = this.imageFile;
    data['description'] = this.description;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

class CreatedBy {
  int? id;
  String? fullName;
  int? designation;
  String? email;
  String? password;
  String? dateOfBirth;
  int? gender;
  String? aboutMe;
  String? contactNo;
  String? address;
  String? latitude;
  String? longitude;
  String? city;
  String? country;
  String? countryCode;
  String? zipcode;
  String? language;
  String? otp;
  int? otpVerified;
  int? providerId;
  String? profileFile;
  int? tos;
  int? roleId;
  int? stateId;
  int? typeId;
  int? isNotify;
  String? lastVisitTime;
  String? lastActionTime;
  String? lastPasswordChange;
  int? loginErrorCount;
  String? activationKey;
  String? timezone;
  String? createdOn;
  String? updatedOn;
  int? createdById;
  int? emailVerified;
  int? pushEnabled;
  int? emailEnabled;
  Null? profileType;

  CreatedBy(
      {this.id,
      this.fullName,
      this.designation,
      this.email,
      this.password,
      this.dateOfBirth,
      this.gender,
      this.aboutMe,
      this.contactNo,
      this.address,
      this.latitude,
      this.longitude,
      this.city,
      this.country,
      this.countryCode,
      this.zipcode,
      this.language,
      this.otp,
      this.otpVerified,
      this.providerId,
      this.profileFile,
      this.tos,
      this.roleId,
      this.stateId,
      this.typeId,
      this.isNotify,
      this.lastVisitTime,
      this.lastActionTime,
      this.lastPasswordChange,
      this.loginErrorCount,
      this.activationKey,
      this.timezone,
      this.createdOn,
      this.updatedOn,
      this.createdById,
      this.emailVerified,
      this.pushEnabled,
      this.emailEnabled,
      this.profileType});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    designation = json['designation'];
    email = json['email'];
    password = json['password'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    aboutMe = json['about_me'];
    contactNo = json['contact_no'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    country = json['country'];
    countryCode = json['country_code'];
    zipcode = json['zipcode'];
    language = json['language'];
    otp = json['otp'];
    otpVerified = json['otp_verified'];
    providerId = json['provider_id'];
    profileFile = json['profile_file'];
    tos = json['tos'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    isNotify = json['is_notify'];
    lastVisitTime = json['last_visit_time'];
    lastActionTime = json['last_action_time'];
    lastPasswordChange = json['last_password_change'];
    loginErrorCount = json['login_error_count'];
    activationKey = json['activation_key'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    createdById = json['created_by_id'];
    emailVerified = json['email_verified'];
    pushEnabled = json['push_enabled'];
    emailEnabled = json['email_enabled'];
    profileType = json['profile_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['password'] = this.password;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['about_me'] = this.aboutMe;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['zipcode'] = this.zipcode;
    data['language'] = this.language;
    data['otp'] = this.otp;
    data['otp_verified'] = this.otpVerified;
    data['provider_id'] = this.providerId;
    data['profile_file'] = this.profileFile;
    data['tos'] = this.tos;
    data['role_id'] = this.roleId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['is_notify'] = this.isNotify;
    data['last_visit_time'] = this.lastVisitTime;
    data['last_action_time'] = this.lastActionTime;
    data['last_password_change'] = this.lastPasswordChange;
    data['login_error_count'] = this.loginErrorCount;
    data['activation_key'] = this.activationKey;
    data['timezone'] = this.timezone;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['created_by_id'] = this.createdById;
    data['email_verified'] = this.emailVerified;
    data['push_enabled'] = this.pushEnabled;
    data['email_enabled'] = this.emailEnabled;
    data['profile_type'] = this.profileType;
    return data;
  }
}

class SubCategory {
  int? id;
  String? title;
  String? imageFile;
  int? categoryId;
  Null? description;
  int? typeId;
  int? stateId;
  String? createdOn;
  int? createdById;

  SubCategory(
      {this.id,
      this.title,
      this.imageFile,
      this.categoryId,
      this.description,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.createdById});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageFile = json['image_file'];
    categoryId = json['category_id'];
    description = json['description'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_file'] = this.imageFile;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

class Certificates {
  int? id;
  String? name;
  int? size;
  String? key;
  String? modelType;
  int? modelId;
  int? typeId;
  String? createdOn;
  int? createdById;

  Certificates(
      {this.id,
      this.name,
      this.size,
      this.key,
      this.modelType,
      this.modelId,
      this.typeId,
      this.createdOn,
      this.createdById});

  Certificates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    key = json['key'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['key'] = this.key;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
