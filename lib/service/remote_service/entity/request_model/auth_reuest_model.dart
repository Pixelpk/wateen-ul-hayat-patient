// Project imports:
import 'package:dio/dio.dart';

class AuthRequestModel {
  static signUpReq({
    String? contactNo,
    String? countryCode,
    String? password,
    var roleId,
    String? deviceToken,
    int? deviceType,
    String? deviceName,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[contact_no]'] = contactNo;
    data['User[country_code]'] = countryCode;
    data['User[password]'] = password;
    data['User[role_id]'] = roleId;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;

    return data;
  }

  static contactUsReq(
      {String? fullName,
      String? email,
      String? subject,
      var description,
      String? mobile}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Information[full_name]'] = fullName;
    data['Information[email]'] = email;
    data['Information[subject]'] = subject;
    data['Information[description]'] = description;
    data['Information[mobile]'] = mobile;

    return data;
  }

  static addCardReq(
      {String? fullName, String? cardNumber, String? expiryDate, String? cvv}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = fullName;
    data['card_number'] = cardNumber;
    data['expiry_date'] = expiryDate;
    data['cvc'] = cvv;

    return data;
  }

  static verifyOTPReq({
    String? contactNo,
    String? countryCode,
    String? otp,
    String? deviceToken,
    int? deviceType,
    String? deviceName,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[contact_no]'] = contactNo;
    data['User[country_code]'] = countryCode;
    data['User[otp]'] = otp;
    data['AccessToken[device_token]'] = deviceToken;
    data['AccessToken[device_type]'] = deviceType;
    data['AccessToken[device_name]'] = deviceName;
    return data;
  }

  static addFamilyMemberReq(
      {String? contactNo,
      String? countryCode,
      String? name,
      String? address,
      String? latitude,
      String? longitude,
      String? zipcode,
      String? country,
      String? state,
      String? city,
      String? relation}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserFamilyMember[name]'] = name;
    data['UserFamilyMember[relation]'] = relation;
    data['UserFamilyMember[contact_no]'] = contactNo;
    data['UserFamilyMember[country_code]'] = countryCode;
    data['UserFamilyMember[address]'] = address;
    data['UserFamilyMember[latitude]'] = latitude;
    data['UserFamilyMember[longitude]'] = longitude;
    data['UserFamilyMember[zipcode]'] = zipcode;
    data['UserFamilyMember[country]'] = country;
    data['UserFamilyMember[state]'] = state;
    data['UserFamilyMember[city]'] = city;

    return data;
  }

  static forgetReq({
    String? contactNo,
    String? countryCode,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_no'] = contactNo;
    data['country_code'] = countryCode;
    return data;
  }

  static updatePassReq({
    String? contactNo,
    String? countryCode,
    String? otp,
    String? password,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_no'] = contactNo;
    data['country_code'] = countryCode;
    data['otp'] = otp;
    data['password'] = password;
    return data;
  }

  static serviceProviderReq({
    String? categoryId,
    String? subCategoryId,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['[category_id]'] = categoryId;
    data['[sub_category_id]'] = subCategoryId;
    return data;
  }

  static changePasswordReq({
    String? newPassword,
    String? oldPassword,
    String? confirmPassword,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[oldPassword]'] = oldPassword;
    data['User[password]'] = newPassword;
    data['User[confirm_password]'] = confirmPassword;
    return data;
  }

  static getSlotReq({
    String? startDay,
    String? endDay,
    String? startTime,
    String? endTime,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Availability[start_day_id]'] = startDay;
    data['Availability[end_day_id]'] = endDay;
    data['Availability[start_time]'] = startTime;
    data['Availability[end_time]'] = endTime;
    return data;
  }

  static getSlotAvailabilityReq({
    String? startDay,
    String? endDay,
    String? subscribedStartTime,
    String? subscribedEndTime,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Availability[start_date]'] = startDay;
    data['Availability[end_date]'] = endDay;
    data['Availability[subscribed_start_time]'] = subscribedStartTime;
    data['Availability[subscribed_end_time]'] = subscribedEndTime;
    print(data.toString());
    return data;
  }

  static giveRatingReq({
    String? rating,
    String? comment,
    String? staffId,
    String? providerId,
    String? typeId,
    String? bookingId,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceRating[rating]'] = rating;
    data['ServiceRating[comment]'] = comment;
    data['ServiceRating[staff_id]'] = staffId;
    data['ServiceRating[model_id]'] = providerId;
    data['ServiceRating[booking_id]'] = typeId;
    data['ServiceRating[type_id]'] = bookingId;
    return data;
  }

  static filterReq({
    String? price,
    String? gender,
    String? review,
    String? service,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceRating[rating]'] = price;
    data['ServiceRating[comment]'] = gender;
    data['Booking[staff_id]'] = review;
    data['Booking[provider_id]'] = service;

    return data;
  }

  static getBookingReq({
    String? price,
    String? taxPrice,
    String? finalPrice,
    String? addressId,
    String? providerId,
    var serviceJson,
    String? cardId,
    String? familyId,
    String? typeId,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Booking[price]'] = price;
    data['Booking[tax_price]'] = taxPrice;
    data['Booking[final_price]'] = finalPrice;
    data['Booking[address_id]'] = addressId;
    data['Booking[provider_id]'] = providerId;
    data['Booking[service_json]'] = serviceJson;
    data['Booking[card_id]'] = cardId;
    print(data);
    return data;
  }

  static getCartReq({
    var serviceJson,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CartJson[value]'] = serviceJson;
    print(data);
    return data;
  }

  static loginReq(
      {String? contactNo,
      String? countryCode,
      String? password,
      String? deviceToken,
      int? deviceType,
      String? deviceName,
      String? lang,
      email}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginForm[contact_no]'] = contactNo;
    data['LoginForm[country_code]'] = countryCode;
    data['LoginForm[password]'] = password;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    data['User[language]'] = lang;

    return data;
  }

  static updateProfileReq({
    MultipartFile? profileFile,
    String? fullName,
    String? email,
    String? countryCode,
    String? contactNo,
    int? gender,
    String? nationality,
    String? houseNo,
    String? street,
    String? otherInfo,
    String? latitude,
    String? longitude,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[profile_file]'] = profileFile;
    data['User[full_name]'] = fullName;
    data['User[email]'] = email;
    data['User[country_code]'] = countryCode;
    data['User[contact_no]'] = contactNo;
    data['User[gender]'] = gender;
    data['UserDetail[nationality]'] = nationality;
    data['UserAddress[house_no]'] = houseNo;
    data['UserAddress[street]'] = street;
    data['UserAddress[other_info]'] = otherInfo;
    data['UserAddress[latitude]'] = latitude;
    data['UserAddress[longitude]'] = longitude;
    return data;
  }

  static addAddressReq({
    String? address,
    String? fullName,
    String? phoneNumber,
    String? latitude,
    String? longitude,
    String? zipcode,
    String? country,
    String? state,
    String? city,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserAddress[address]'] = address;
    data['UserAddress[full_name]'] = fullName;
    data['UserAddress[phone_number]'] = phoneNumber;
    data['UserAddress[latitude]'] = latitude;
    data['UserAddress[longitude]'] = longitude;
    data['UserAddress[zipcode]'] = zipcode;
    data['UserAddress[country]'] = country;
    data['UserAddress[state]'] = state;
    data['UserAddress[city]'] = city;

    return data;
  }

  static paymentReq({
    String? id,
    var value,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Transaction[transaction_id]'] = id;
    data['Transaction[value]'] = value;
    return data;
  }


  static filtersReq({
    var gender,
    var rating,
    var sort,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = gender;
    data['rating'] = rating;
    data['sort'] = sort;

    return data;
  }

  static langReq({
    var lang,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[language]'] = lang;
    return data;
  }

  static notifyReq({
    var lang,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[is_notify]'] = lang;
    return data;
  }
}
