import 'package:gymfit_mobile/models/user.dart';

class Reservation {
  late int id;
  late String? description;
  late DateTime? ReservationDate;
  late DateTime? StartDate;
  late DateTime? EndDate;
  late int? Duration;
  late int? PauseDuration;
  late int? MaxCapacity;
  late String? DaysOfWeek;
  late bool? isUsed;
  late int? GymId;
  late User? user;
  late int? userId;
  late int? status;
  late User? Trainer;
  late int? trainerId;

  Reservation({
    required this.id,
    this.description,
    this.status,
    this.ReservationDate,
    this.StartDate,
    this.EndDate,
    this.Duration,
    this.PauseDuration,
    this.MaxCapacity,
    this.DaysOfWeek,
    this.GymId,
    this.Trainer,
    this.trainerId,
    this.isUsed,
    this.user,
    this.userId,
  });

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    description = json['description'];
    ReservationDate = DateTime.parse(json['reservationDate']);
    StartDate = DateTime.parse(json['startDate']);
    EndDate = DateTime.parse(json['endDate']);
    Duration = json['duration'];
    PauseDuration = json['pauseDuration'];
    MaxCapacity = json['maxCapacity'];
    DaysOfWeek = json['daysOfWeek'];
    trainerId = json['trainerId'];
    GymId = json['gymId'];
    isUsed = json['isUsed'];
    status = json['status'];

   // user = User.fromJson(json['user']);
   Trainer = User.fromJson(json['trainer']);
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = id;
  data['userId'] = userId;
  data['description'] = description;

  return data;
}
}
