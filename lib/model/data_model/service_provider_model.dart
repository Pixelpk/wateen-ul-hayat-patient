import 'package:swift_care/model/data_model/category_data_model.dart';
import 'package:swift_care/model/data_model/service_provider_detail_model.dart';

class ServiceProviderModel {
  List<ServiceProvider>? list;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;

  ServiceProviderModel({this.list, this.lLinks, this.mMeta, this.copyrighths});

  ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ServiceProvider>[];
      json['list'].forEach((v) {
        list!.add(new ServiceProvider.fromJson(v));
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

class ServiceProvider {
  var id;
  var fullName;
  var totalDistance;
  var email;
  var activationKey;
  var dateOfBirth;
  var gender;
  var countryCode;
  var providerRating;
  var contactNo;
  var language;
  var profileFile;
  var tos;
  var roleId;
  var stateId;
  var typeId;
  UserDetail? userDetail;
  UserAddress? userAddress;
  CategoryData? service;
  var otp;
  var otpVerified;
  var timezone;
  var createdOn;
  var providerAddress;
  List<Certificates>? certificates;

  ServiceProvider(
      {this.id,
      this.fullName,
      this.email,
      this.activationKey,
        this.totalDistance,
      this.dateOfBirth,
      this.gender,
      this.countryCode,
      this.contactNo,
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
      this.providerRating,
      this.providerAddress,
      this.certificates,
      this.createdOn});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    activationKey = json['activation_key'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    countryCode = json['country_code'];
    contactNo = json['contact_no'];
    language = json['language'];
    profileFile = json['profile_file'];
    totalDistance = json['total_distance'];
    providerRating = json['provider_rating'];
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
    service = json['service'] != null
        ? new CategoryData.fromJson(json['service'])
        : null;
    otp = json['otp'];
    otpVerified = json['otp_verified'];
    timezone = json['timezone'];
    providerAddress = json['Provider Address'];
    createdOn = json['created_on'];
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
    data['total_distance'] = this.totalDistance;
    data['country_code'] = this.countryCode;
    data['contact_no'] = this.contactNo;
    data['language'] = this.language;
    data['provider_rating'] = this.providerRating;
    data['profile_file'] = this.profileFile;
    data['tos'] = this.tos;
    data['role_id'] = this.roleId;
    data['Provider Address'] = this.providerAddress;
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
    if (this.certificates != null) {
      data['certificates'] = this.certificates!.map((v) => v.toJson()).toList();
    }

    data['otp'] = this.otp;
    data['otp_verified'] = this.otpVerified;
    data['timezone'] = this.timezone;
    data['created_on'] = this.createdOn;
    return data;
  }
}

class UserDetail {
  var id;
  var businessName;
  var registerNo;
  var nationality;
  var nationalityTitle;
  var certificateName;
  var instituteName;
  var experience;
  var serviceType;
  var serviceSubType;
  var issueDate;
  var typeId;
  var stateId;
  var createdOn;
  var createdById;

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
      this.nationalityTitle,
      this.stateId,
      this.createdOn,
      this.createdById});

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
      this.subCategoryName,
      this.createdById});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    price = json['price'];
    gender = json['gender'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    subCategoryName = json['sub_category_name'];
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
    return data;
  }
}

class Links {
  Self? self;
  Self? first;
  Self? last;

  Links({this.self, this.first, this.last});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    first = json['first'] != null ? new Self.fromJson(json['first']) : null;
    last = json['last'] != null ? new Self.fromJson(json['last']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.toJson();
    }
    if (this.first != null) {
      data['first'] = this.first!.toJson();
    }
    if (this.last != null) {
      data['last'] = this.last!.toJson();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Meta {
  int? totalCount;
  int? pageCount;
  int? currentPage;
  int? perPage;

  Meta({this.totalCount, this.pageCount, this.currentPage, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageCount'] = this.pageCount;
    data['currentPage'] = this.currentPage;
    data['perPage'] = this.perPage;
    return data;
  }
}
