class FaqResponseModel {
  List<FaqList>? list;

  FaqResponseModel({this.list});

  FaqResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <FaqList>[];
      json['list'].forEach((v) {
        list!.add(new FaqList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaqList {
  int? id;
  String? question;
  String? answer;
  int? stateId;
  int? typeId;
  String? createdOn;
  int? createdById;

  FaqList(
      {this.id,
        this.question,
        this.answer,
        this.stateId,
        this.typeId,
        this.createdOn,
        this.createdById});

  FaqList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
