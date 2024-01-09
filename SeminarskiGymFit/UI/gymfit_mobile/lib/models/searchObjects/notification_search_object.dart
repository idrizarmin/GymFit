
import 'package:gymfit_mobile/models/searchObjects/base_search_object.dart';

class NotificationsSearchObject extends BaseSearchObject {
  String? content;
  int? userId;
  bool? seen;
  int? PageNumber;
  int? PageSize;

  NotificationsSearchObject(
      {this.content, this.userId, this.PageNumber, this.PageSize, this.seen});

  NotificationsSearchObject.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    userId = json['userId'];
    seen = json['seen'];
    PageNumber = json['PageNumber'];
    PageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['content'] = content;
    data['userId'] = userId;
    data['seen'] = seen;
    data['PageNumber'] = PageNumber;
    data['PageSize'] = PageSize;
    return data;
  }
}
