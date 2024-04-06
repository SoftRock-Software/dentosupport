import 'package:json_annotation/json_annotation.dart';

part 'medical_history.g.dart';

@JsonSerializable()
class MedicalHistory {
  MedicalHistory({
    required this.id,
    required this.title,
    this.description = '',
    this.selected = false,
  });

  factory MedicalHistory.fromJson(Map<String, dynamic> json) =>
      _$MedicalHistoryFromJson(json);

  int id;
  final String title;

  final String description;
  bool selected;
}
