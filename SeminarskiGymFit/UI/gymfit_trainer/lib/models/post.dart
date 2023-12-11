
import 'package:gymfit_trainer/models/photo.dart';

class Post {
  late int id;
  late String? title;
  late String? content;
  late DateTime? publishDate;
  late bool isSelected = false;
  late int? status;
  late int? photoId;
  late Photo? photo;

  Post({
    required this.id,
    this.title,
    this.content,
    this.publishDate,
    this.status,
    this.photo,
    this.photoId,
    required this.isSelected,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    content = json['content'];
    status = json['status'];
    publishDate = DateTime.parse(json['publishDate']);
    photoId = json['photoId'];
    if (json['photo'] != null) {
      photo = Photo.fromJson(json['photo']);
    } else {
      photo = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['status'] = status;
    data['publishDate'] = publishDate;
    data['photoId'] = photoId;

    return data;
  }
}
