class AvailabilitySlotModel {
  List<AvailabilitySlot>? list;
  int? totalDays;
  String? unavailableDays;
  String? days;


  AvailabilitySlotModel(
      {this.list,
        this.totalDays,
        this.unavailableDays,
        this.days});

  AvailabilitySlotModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <AvailabilitySlot>[];
      json['list'].forEach((v) {
        list!.add(AvailabilitySlot.fromJson(v));
      });
    }
    totalDays = json['total_days'];
    unavailableDays = json['unavailable_days'];
    days = json['days'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['total_days'] = this.totalDays;
    data['unavailable_days'] = this.unavailableDays;
    data['days'] = this.days;
    return data;
  }
}

class AvailabilitySlot {
  String? startTime;
  String? endTime;
  int? available;

  AvailabilitySlot({this.startTime, this.endTime, this.available});

  AvailabilitySlot.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['available'] = this.available;
    return data;
  }
}
