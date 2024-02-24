import 'package:gymfit_trainer/models/user.dart';

class NotificationRabbit {
  late int id;
  late String content;
  late String title;
  late bool? isRead;
  late int? userId;
  late bool isSelected = false;

NotificationRabbit({
  required this.id,
  required this.content,
  required this.title,
  required this.isRead,
 this.userId,
 required this.isSelected,
 
});

  NotificationRabbit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    content = json['content'];
    isRead = json['read'];
    title = json['title'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    return data;
  }



}

