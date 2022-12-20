import 'package:country_code_picker/country_code.dart';

class RememberMeModel {
  String? email;
  String? password;
  String? mobileNumber;
  String? countryCode;



  RememberMeModel({this.email, this.password,this.mobileNumber,this.countryCode,});

  RememberMeModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    mobileNumber = json['mobile_number'];
    countryCode = json['countryCode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobile_number'] = this.mobileNumber;
    data['countryCode'] = this.countryCode;

    return data;
  }
}
