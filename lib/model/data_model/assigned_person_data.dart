class AssignPerson {
  var id;
  var fullName;
  var designation;
  var email;
  var password;
  var dateOfBirth;
  var gender;
  var aboutMe;
  var contactNo;
  var address;
  var latitude;
  var longitude;
  var city;
  var staffRating;
  var providerRating;
  var country;
  var countryCode;
  var zipcode;
  var language;
  var otp;
  var otpVerified;
  var providerId;
  var profileFile;
  var customerId;
  var tos;
  var roleId;
  var stateId;
  var typeId;
  var isNotify;
  var lastVisitTime;
  var lastActionTime;
  var lastPasswordChange;
  var loginErrorCount;
  var activationKey;
  var timezone;
  var createdOn;
  var updatedOn;
  var createdById;
  var emailVerified;
  var pushEnabled;
  var emailEnabled;
  var profileType;

  AssignPerson(
      {this.id,
        this.fullName,
        this.designation,
        this.email,
        this.password,
        this.dateOfBirth,
        this.gender,
        this.aboutMe,
        this.providerRating,
        this.contactNo,
        this.staffRating,
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
        this.customerId,
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

  AssignPerson.fromJson(Map json) {
    id = json['id'];
    fullName = json['full_name'];
    designation = json['designation'];
    email = json['email'];
    password = json['password'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    aboutMe = json['about_me'];
    contactNo = json['contact_no'];
    staffRating = json['staff_rating'];
    providerRating = json['provider_rating'];
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
    customerId = json['customer_id'];
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

  Map toJson() {
    final Map data = new Map();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['password'] = this.password;
    data['date_of_birth'] = this.dateOfBirth;
    data['staff_rating'] = this.staffRating;
    data['provider_rating'] = this.providerRating;
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
    data['customer_id'] = this.customerId;
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