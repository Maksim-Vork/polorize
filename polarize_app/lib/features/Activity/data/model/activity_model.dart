import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final Map<String, int>? photoActivity;
  final int? sumActivityDays;
  final DateTime? lastDayActiv;

  ActivityModel({
    Map<String, int>? photoActivity,
    int? sumActivityDays,
    this.lastDayActiv,
  }) : photoActivity = photoActivity ?? {},
       sumActivityDays = sumActivityDays ?? 0;

  Map<String, dynamic> toMap() {
    return {
      "photoActivity": photoActivity,
      "sumActivityDays": sumActivityDays,
      "lastDayActiv": lastDayActiv != null
          ? Timestamp.fromDate(lastDayActiv!)
          : null,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      photoActivity: Map<String, int>.from(map['photoActivity']),
      sumActivityDays: map['sumActivityDays'] as int,
      lastDayActiv: map['lastDayActiv'] != null
          ? (map['lastDayActiv'] as Timestamp).toDate()
          : null,
    );
  }
}
