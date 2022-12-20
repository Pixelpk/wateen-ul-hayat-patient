import '../data_model/category_data_model.dart';

class SlotModel {
  List<SlotDataModel>? list;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;

  SlotModel({this.list, this.lLinks, this.mMeta, this.copyrighths});

  SlotModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SlotDataModel>[];
      json['list'].forEach((v) {
        list!.add(new SlotDataModel.fromJson(v));
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

class SlotDataModel {
  int? id;
  int? dayId;
  String? startTime;
  String? endTime;
  int? stateId;
  int? typeId;
  String? createdOn;
  int? createdById;

  SlotDataModel(
      {this.id,
        this.dayId,
        this.startTime,
        this.endTime,
        this.stateId,
        this.typeId,
        this.createdOn,
        this.createdById});

  SlotDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayId = json['day_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_id'] = this.dayId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}


