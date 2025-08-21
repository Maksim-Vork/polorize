import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final Map<DateTime, int> photoActivity;
  final int sumActivityDays;
  final DateTime? lastDayActiv;

  const Activity({
    required this.photoActivity,
    required this.sumActivityDays,
    required this.lastDayActiv,
  });

  @override
  List<Object?> get props => [photoActivity, sumActivityDays, lastDayActiv];
}
