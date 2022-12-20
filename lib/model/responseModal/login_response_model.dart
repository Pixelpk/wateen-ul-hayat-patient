import 'package:swift_care/model/common_model/detail_model.dart';

class LogInResponseModel {
  String? accessToken;
  Detail? detail;
  String? copyrighths;

  LogInResponseModel({this.accessToken, this.detail, this.copyrighths});

  LogInResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access-token'];
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access-token'] = this.accessToken;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}


