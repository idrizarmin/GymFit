import 'package:gymfit_mobile/models/searchObjects/base_search_object.dart';

class ReservationSearchObject extends BaseSearchObject {
  int? userId;
  int? spol;
  int? trainerId;
  int? status;
  int? PageNumber;
  int? PageSize;

  ReservationSearchObject(
      {this.spol,this.status, this.userId, this.PageNumber, this.PageSize, this.trainerId});

  ReservationSearchObject.fromJson(Map<String, dynamic> json) {
    spol = json['spol'];
    status= json['status'];
    userId = json['userId'];
    trainerId = json['trainerId'];
    PageNumber = json['PageNumber'];
    PageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['spol'] = spol;
    data['status'] = status;
    data['userId'] = userId;
    data['trainerId'] = trainerId;
    data['PageNumber'] = PageNumber;
    data['PageSize'] = PageSize;
    return data;
  }
}
