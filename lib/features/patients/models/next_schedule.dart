import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'next_schedule.g.dart';

@JsonSerializable()
class NextSchedule extends Equatable {
  const NextSchedule({required this.id, required this.date});

  factory NextSchedule.fromJson(Map<String, dynamic> json) =>
      _$NextScheduleFromJson(json);

  final int id;
  final DateTime date;

  @override
  List<Object?> get props => [id, date];
}
