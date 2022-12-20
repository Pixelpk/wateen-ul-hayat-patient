import '../data_model/category_data_model.dart';

class FamilyMembersListResponseModel {
  List<FamilyMember>? list;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;

  FamilyMembersListResponseModel(
      {this.list, this.lLinks, this.mMeta, this.copyrighths});

  FamilyMembersListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <FamilyMember>[];
      json['list'].forEach((v) {
        list!.add(new FamilyMember.fromJson(v));
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

class FamilyMember {
  int? id;
  String? name;
  String? relation;
  String? contactNo;
  String? countryCode;
  int? typeId;
  int? stateId;
  String? createdOn;
  int? createdById;
  String? city;
  String? address;
  String? country;
  String? latitude;
  String? longitude;

  FamilyMember(
      {this.id,
      this.name,
      this.relation,
      this.contactNo,
      this.countryCode,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.city,
      this.address,
      this.country,
      this.latitude,
      this.longitude,
      this.createdById});

  FamilyMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['family_name'];
    relation = json['relation'];
    contactNo = json['contact_no'];
    countryCode = json['country_code'];
    typeId = json['type_id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];

    city = json['city'];
    address = json['address'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['family_name'] = this.name;
    data['relation'] = this.relation;
    data['contact_no'] = this.contactNo;
    data['country_code'] = this.countryCode;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['city'] = this.city;
    data['address'] = this.address;
    data['country'] = this.country;
    return data;
  }
}
