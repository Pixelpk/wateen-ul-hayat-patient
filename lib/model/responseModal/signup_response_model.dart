import 'package:swift_care/model/common_model/detail_model.dart';

class SignUpResponseModel {
  var otp;
  String? accessToken;
  String? message;
  Detail? detail;
  String? copyrighths;

  SignUpResponseModel(
      {this.otp,
        this.accessToken,
        this.message,
        this.detail,
        this.copyrighths});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    accessToken = json['access-token'];
    message = json['message'];
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['access-token'] = this.accessToken;
    data['message'] = this.message;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}


