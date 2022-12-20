class StaticPageModel {
  Detail? detail;
  String? copyrighths;

  StaticPageModel({this.detail, this.copyrighths});

  StaticPageModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? url;
  String? description;
  int? stateId;
  String? createdOn;
  int? createdById;

  Detail(
      {this.id,
        this.title,
        this.url,
        this.description,
        this.stateId,
        this.createdOn,
        this.createdById});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    description = json['description'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
