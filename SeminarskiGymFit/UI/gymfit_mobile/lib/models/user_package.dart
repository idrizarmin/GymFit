import 'package:gymfit_mobile/models/package.dart';
import 'package:gymfit_mobile/models/user.dart';

class UserPackage {
  late int id;
  late String? pauseDuration;
  late bool? isPaused;
  late bool? expired;
  late DateTime? activationDate;
  late DateTime? expirationDate;
  late DateTime? pausedOnDate;
  late DateTime? activateOnDate;
  late bool isSelected = false;

  late User? user;
  late int? userId;

  late Package? package;
  late int? packageId;

  UserPackage({
    required this.id,
    required this.isSelected,
    this.pauseDuration,
    this.isPaused,
    this.expired,
    this.activateOnDate,
    this.expirationDate,
    this.pausedOnDate,
    this.activationDate,
    this.user,
    this.userId,
    this.package,
    this.packageId,
  });

  UserPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activateOnDate = DateTime.parse(json['activateOnDate']);
    expirationDate = DateTime.parse(json['expirationDate']);
    pausedOnDate = DateTime.parse(json['pausedOnDate']);
    activationDate = DateTime.parse(json['activationDate']);
    userId = json['userId'];
    packageId = json['packageId'];
    isPaused = json['isPaused'];
    expired = json['expired'];
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    } else {
      user = null;
    }
    if (json['package'] != null) {
      package = Package.fromJson(json['package']);
    } else {
      user = null;
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pauseDuration'] = pauseDuration;
    data['isPaused'] = isPaused;
    data['expired'] = expired;

    return data;
  }
}
