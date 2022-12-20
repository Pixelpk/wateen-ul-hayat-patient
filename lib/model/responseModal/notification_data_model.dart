import '../data_model/category_data_model.dart';

class NotificationDataModel {
  List<NotificationData>? list;
  Links? lLinks;
  Meta? mMeta;
  String? copyrighths;

  NotificationDataModel({this.list, this.lLinks, this.mMeta, this.copyrighths});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <NotificationData>[];
      json['list'].forEach((v) {
        list!.add(new NotificationData.fromJson(v));
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

class NotificationData {
  int? id;
  String? title;
  String? userName;
  Null? description;
  int? modelId;
  String? modelType;
  int? isRead;
  int? stateId;
  int? typeId;
  String? createdOn;
  int? toUserId;
  int? createdById;

  NotificationData(
      {this.id,
        this.title,
        this.description,
        this.modelId,
        this.userName,
        this.modelType,
        this.isRead,
        this.stateId,
        this.typeId,
        this.createdOn,
        this.toUserId,
        this.createdById});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    modelId = json['model_id'];
    userName = json['user_name'];
    modelType = json['model_type'];
    isRead = json['is_read'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    toUserId = json['to_user_id'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['model_id'] = this.modelId;
    data['model_type'] = this.modelType;
    data['is_read'] = this.isRead;
    data['user_name'] = this.userName;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['to_user_id'] = this.toUserId;
    data['created_by_id'] = this.createdById;
    return data;
  }
}


