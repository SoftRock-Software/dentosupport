import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clinic.g.dart';

@JsonSerializable()
class Clinic extends Equatable {
  const Clinic({
    required this.name,
    required this.mobile,
    required this.dayOff,
    required this.id,
    required this.location,
    required this.userId,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);

  final String name;
  final String mobile;
  final List<String> dayOff;
  final int id;
  final String location;
  final int userId;

  @override
  List<Object?> get props => [id, name, mobile, dayOff, location, userId];

  Map<String, dynamic> toJson() => _$ClinicToJson(this);
}
