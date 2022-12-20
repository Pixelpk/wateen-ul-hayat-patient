import 'cart_db.dart';

class ServiceDB {
  int? id;
  int? providerId;
  String? name;
  String? gender;
  var price;
  int? difference;

  int? serviceId;
  String? startTime;
  String? endTime;
  String? familyName;
  String? subscribedStartTime;
  String? subscribedEndTime;
  String? latitude;
  String? longitude;
  String? address;
  String? unavailableDate;
  int? slotId;
  int? typeId;
  int? familyId;
  int? slotBookingType;

  ServiceDB(
      this.id,
      this.unavailableDate,
      this.slotBookingType,
      this.providerId,
      this.name,
      this.gender,
      this.price,
      this.serviceId,
      this.startTime,
      this.endTime,
      this.slotId,
      this.typeId,
      this.familyId,
      this.subscribedStartTime,
      this.subscribedEndTime,
      this.difference);

  ServiceDB.fromMap(Map map) {
    id = map['id'];
    providerId = map['providerId'];
    name = map['name'];
    gender = map['gender'];
    price = map['price'];
    address = map['address'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    difference = map['total_days'];
    slotBookingType = map['booking_type'];
    serviceId = map['service_id'];
    startTime = map['start_time'];
    endTime = map['end_time'];
    price = map['price'];
    typeId = map['type_id'];
    familyId = map['member_id'];
    familyName = map['family_name'];
  }

  ServiceDB.fromSlotMap(Map map) {
    name = map['name'];
    serviceId = map['service_id'];
    providerId = map['providerId'];
    startTime = map['start_time'];
    endTime = map['end_time'];
    price = map['price'];
    typeId = map['type_id'];
    familyId = map['member_id'];
    gender = map['gender'];
    difference = map['total_days'];
    address = map['address'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    familyName = map['family_name'];
    subscribedStartTime = map['subscribed_start_time'];
    subscribedEndTime = map['subscribed_end_time'];
    familyName = map['family_name'];
    slotBookingType = map['booking_type'];
    unavailableDate = map['unavailable_date'];
  }

  Map<String, Object?> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.providerId: providerId,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnGender: gender,
      DatabaseHelper.columnPrice: price,
      DatabaseHelper.difference: difference,
      DatabaseHelper.serviceId: serviceId,
      DatabaseHelper.startTime: startTime,
      DatabaseHelper.endTime: endTime,
      DatabaseHelper.price: price,
      DatabaseHelper.typeId: typeId,
      DatabaseHelper.familyId: familyId,
      DatabaseHelper.slotBookingType:slotBookingType
    };
  }

  Map<String, Object?> toSlotMap() {
    return {
      DatabaseHelper.serviceId: serviceId,
      DatabaseHelper.startTime: startTime,
      DatabaseHelper.endTime: endTime,
      DatabaseHelper.price: price,
      DatabaseHelper.typeId: typeId,
      DatabaseHelper.familyId: familyId,
      DatabaseHelper.difference: difference,
      DatabaseHelper.address: address,
      DatabaseHelper.latitude: latitude,
      DatabaseHelper.longitude: longitude,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnGender: gender,
      DatabaseHelper.familyName: familyName,
      DatabaseHelper.providerId: providerId,
      DatabaseHelper.slotStartTime: subscribedStartTime,
      DatabaseHelper.slotEndTime: subscribedEndTime,
      DatabaseHelper.slotBookingType: slotBookingType,
      DatabaseHelper.unavailableDate: unavailableDate
    };
  }

  ServiceDB.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    typeId = json['type_id'];
    familyId = json['member_id'];
    familyName = json['family_name'];
    name = json['name'];
    gender = json['gender'];
    difference = json['total_days'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    price = json['price'];
    providerId = json['providerId'];
    slotBookingType = json['booking_type'];
    unavailableDate = json['unavailable_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['type_id'] = this.typeId;
    data['member_id'] = this.familyId;
    data['family_name'] = this.familyName;
    data['total_days'] = this.difference;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['price'] = this.price;
    data['booking_type'] = this.slotBookingType;
    data['unavailable_date'] = this.unavailableDate;
    return data;
  }
}
