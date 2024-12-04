import 'package:gymfit_admin/models/city.dart';
import 'package:gymfit_admin/models/photo.dart';

class Gym {
  late int id;
  late String name;
  late String? address;
  late String? description;
  late String? phoneNumber;
  late String? website;
  late City? city;
  late int? cityId;
  late Photo? photo;
  late int? photoId;

  Gym({
    required this.id,
    required this.name,
    this.address,
    this.description,
    this.phoneNumber,
    this.website,
    this.city,
    this.cityId,
    this.photo,
    this.photoId,
  });

  Gym.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'];
    description = json['description'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    website = json['website'];
    cityId = json['cityId'];
    photoId = json['photoId'];

    if (json['photo'] != null) {
      photo = Photo.fromJson(json['photo']);
    } else {
      photo = null;
    }
    if (json['city'] != null) {
      city = City.fromJson(json['city']);
    } else {
      photo = null;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['website'] = website;
    data['cityId'] = cityId;
    data['photoId'] = photoId;

    return data;
  }
}
