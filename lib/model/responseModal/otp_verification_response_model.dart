import 'package:swift_care/model/common_model/detail_model.dart';

class OtpVerificationResponseModel {
  String? accessToken;
  Detail? detail;
  String? success;
  String? copyrighths;

  OtpVerificationResponseModel(
      {this.accessToken, this.detail, this.success, this.copyrighths});

  OtpVerificationResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access-token'];
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    success = json['success'];
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access-token'] = this.accessToken;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['success'] = this.success;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}


