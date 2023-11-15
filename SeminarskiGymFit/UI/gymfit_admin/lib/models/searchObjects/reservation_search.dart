import 'package:gymfit_admin/models/searchObjects/base_search.dart';

class ReservationSearchObject extends BaseSearchObject {
  int? userId;
  int? spol;
  int? trainerId;
  int? PageNumber;
  int? PageSize;

  ReservationSearchObject(
      {this.spol, this.userId, this.PageNumber, this.PageSize, this.trainerId});

  ReservationSearchObject.fromJson(Map<String, dynamic> json) {
    spol = json['spol'];
    userId = json['userId'];
    trainerId = json['trainerId'];
    PageNumber = json['PageNumber'];
    PageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['spol'] = spol;
    data['userId'] = userId;
    data['trainerId'] = trainerId;
    data['PageNumber'] = PageNumber;
    data['PageSize'] = PageSize;
    return data;
  }
}
