import '../../pages/cart/cart_data_model.dart';

class ServiceDbResponseModel {
  String? message;
  List<ServiceDB>? detail;
  String? copyrighths;

  ServiceDbResponseModel({this.message, this.detail, this.copyrighths});

  ServiceDbResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['detail'] != null) {
      detail = <ServiceDB>[];
      json['detail'].forEach((v) {
        detail!.add(new ServiceDB.fromJson(v));
      });
    }
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

