
class TrainersSearchObject   {
  bool? active;
  int? PageNumber;
  int? PageSize;
  TrainersSearchObject({this.active, this.PageNumber, this.PageSize});

  TrainersSearchObject.fromJson(Map<String, dynamic> json) {
    active = json['seen'];
    PageNumber = json['PageNumber'];
    PageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['PageNumber'] = PageNumber;
    data['PageSize'] = PageSize;
    return data;
  }
}
