class CardDetailsModel {
  List<CardDetails>? cardDetails;
  String? copyrighths;

  CardDetailsModel({this.cardDetails, this.copyrighths});

  CardDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['card_details'] != null) {
      cardDetails = <CardDetails>[];
      json['card_details'].forEach((v) {
        cardDetails!.add(new CardDetails.fromJson(v));
      });
    }
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardDetails != null) {
      data['card_details'] = this.cardDetails!.map((v) => v.toJson()).toList();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

class CardDetails {
  String? id;
  String? object;
  var addressCity;
  var addressCountry;
  var addressLine1;
  var addressLine1Check;
  var addressLine2;
  var addressState;
  var addressZip;
  var addressZipCheck;
  String? brand;
  String? country;
  String? customer;
  String? cvcCheck;
  var dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;
  String? name;
  var tokenizationMethod;
  int? isDefault;

  CardDetails(
      {this.id,
        this.object,
        this.addressCity,
        this.addressCountry,
        this.addressLine1,
        this.addressLine1Check,
        this.addressLine2,
        this.addressState,
        this.addressZip,
        this.addressZipCheck,
        this.brand,
        this.country,
        this.customer,
        this.cvcCheck,
        this.dynamicLast4,
        this.expMonth,
        this.expYear,
        this.fingerprint,
        this.funding,
        this.last4,
        this.name,
        this.tokenizationMethod,
        this.isDefault});

  CardDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    addressCity = json['address_city'];
    addressCountry = json['address_country'];
    addressLine1 = json['address_line1'];
    addressLine1Check = json['address_line1_check'];
    addressLine2 = json['address_line2'];
    addressState = json['address_state'];
    addressZip = json['address_zip'];
    addressZipCheck = json['address_zip_check'];
    brand = json['brand'];
    country = json['country'];
    customer = json['customer'];
    cvcCheck = json['cvc_check'];
    dynamicLast4 = json['dynamic_last4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    fingerprint = json['fingerprint'];
    funding = json['funding'];
    last4 = json['last4'];

    name = json['name'];
    tokenizationMethod = json['tokenization_method'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['address_city'] = this.addressCity;
    data['address_country'] = this.addressCountry;
    data['address_line1'] = this.addressLine1;
    data['address_line1_check'] = this.addressLine1Check;
    data['address_line2'] = this.addressLine2;
    data['address_state'] = this.addressState;
    data['address_zip'] = this.addressZip;
    data['address_zip_check'] = this.addressZipCheck;
    data['brand'] = this.brand;
    data['country'] = this.country;
    data['customer'] = this.customer;
    data['cvc_check'] = this.cvcCheck;
    data['dynamic_last4'] = this.dynamicLast4;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['fingerprint'] = this.fingerprint;
    data['funding'] = this.funding;
    data['last4'] = this.last4;

    data['name'] = this.name;
    data['tokenization_method'] = this.tokenizationMethod;
    data['is_default'] = this.isDefault;
    return data;
  }
}
