import '../data_model/card_details.dart';

class CardsListResponse {
  List<CardDetails>? list;
  String? copyrighths;

  CardsListResponse({this.list, this.copyrighths});

  CardsListResponse.fromJson(Map json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list!.add(new CardDetails.fromJson(v));
      });
    }
    copyrighths = json['copyrighths'];
  }

  Map toJson() {
    final Map data = new Map();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}