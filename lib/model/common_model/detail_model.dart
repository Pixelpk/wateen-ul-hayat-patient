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
  var profileFile;
  var tos;
  var roleId;
  var stateId;
  var typeId;
  UserDetail? userDetail;
  UserAddress? userAddress;
  var service;
  var otp;
  var otpVerified;
  var timezone;
  var createdOn;

  Detail(
      {this.id,
      this.fullName,
      this.email,
      this.activationKey,
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
      this.createdOn});

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
    data['country_code'] = this.countryCode;
    data['contact_no'] = this.contactNo;
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
  var id;
  var houseNo;
  var street;
  var otherInfo;
  var stateId;
  var typeId;
  var createdOn;
  var createdById;
  var latitude;
  var longitude;

  UserAddress(
      {this.id,
      this.houseNo,
      this.street,
      this.otherInfo,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.latitude,
      this.longitude,
      this.createdById});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    houseNo = json['house_no'];
    street = json['street'];
    otherInfo = json['other_info'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
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
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
