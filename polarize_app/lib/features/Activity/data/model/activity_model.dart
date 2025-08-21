import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final Map<DateTime, int>? photoActivity;
  final int? sumActivityDays;
  final DateTime? lastDayActiv;

  ActivityModel({
    Map<DateTime, int>? photoActivity,
    int? sumActivityDays,
    this.lastDayActiv,
  }) : photoActivity = photoActivity ?? {},
       sumActivityDays = sumActivityDays ?? 0;

  Map<String, dynamic> toMap() {
    return {
      "photoActivity": photoActivity?.map(
        (key, value) => MapEntry(key.toIso8601String(), value),
      ),
      "sumActivityDays": sumActivityDays,
      "lastDayActiv": lastDayActiv != null
          ? Timestamp.fromDate(lastDayActiv!)
          : null,
    };
  }

  // factory ActivityModel.fromMap(Map<String, dynamic> map) {
  //   return ActivityModel(
  //     photoActivity: Map<DateTime, int>.from(map['photoActivity']),
  //     sumActivityDays: map['sumActivityDays'] as int,
  //     lastDayActiv: map['lastDayActiv'] != null
  //         ? (map['lastDayActiv'] as Timestamp).toDate()
  //         : null,
  //   );
  // }
  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    final rawPhotoActivity = map['photoActivity'] as Map<String, dynamic>?;

    return ActivityModel(
      photoActivity: rawPhotoActivity?.map(
        (key, value) => MapEntry(
          DateTime.parse(key), // String -> DateTime
          value as int,
        ),
      ),
      sumActivityDays: map['sumActivityDays'] as int?,
      lastDayActiv: map['lastDayActiv'] != null
          ? (map['lastDayActiv'] as Timestamp).toDate()
          : null,
    );
  }
}
