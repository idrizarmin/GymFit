import 'package:gymfit_admin/models/searchObjects/base_search.dart';

class NotificationsSearchObject extends BaseSearchObject{
  String? content;
  int? userId;
  bool? seen;

  NotificationsSearchObject({this.content, this.userId, this.seen});

   NotificationsSearchObject.fromJson(Map<String, dynamic> json) {

    content= json['content'];
    userId= json['userId'];
    seen = json['seen'];
    
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['content']= content;
    data['userId']= userId;
    data['seen']= seen;
    return data;
  }
}
