import 'package:gymfit_mobile/models/user.dart';


class Notifications {
  late int id;
  late String content;
  late bool? Read;
  late DateTime? DateRead;
  late DateTime? SendOnDate;
  late DateTime ?Seen;
  late User? user;
  late int? userId;
  late bool isSelected = false;

Notifications({
  required this.id,
  required this.content,
  required this.Read,
 this.DateRead,
 this.Seen,
 this.SendOnDate,
 this.user,
 this.userId,
 required this.isSelected,
 
});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    content = json['content'];
    Read = json['read'];
    //DateRead = DateTime.parse(json['dateRead']);
    SendOnDate = DateTime.parse(json['sendOnDate']);
    //Seen = DateTime.parse(json['seen']);
    user = User.fromJson(json['user']);
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['read'] = Read;
    //data['dateRead'] = DateRead;
    data['sendOnDate'] = SendOnDate;
    //data['seen'] = Seen;
    return data;
  }



}

