import 'package:dento_support/features/clinic/models/clinic.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  const User({
    required this.name,
    required this.email,
    required this.mobile,
    required this.id,
    required this.about,
    required this.dob,
    required this.gender,
    this.clinics = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.empty() => const User(
        name: '',
        email: '',
        mobile: '',
        id: -1,
        about: '',
        dob: '',
        gender: '',
      );

  final String name;
  final String email;
  final String mobile;
  final int id;
  final String about;
  final String dob;
  final String gender;
  final List<Clinic> clinics;

  String get initials => name.isEmpty ? '' : name[0];
  String get clinicName => clinics.isNotEmpty ? clinics.first.name : '';
  String get clinicLocation => clinics.isNotEmpty ? clinics.first.location : '';

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? name,
    String? email,
    String? mobile,
    int? id,
    String? about,
    String? dob,
    String? gender,
    List<Clinic>? clinics,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      id: id ?? this.id,
      about: about ?? this.about,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      clinics: clinics ?? this.clinics,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        mobile,
        about,
        dob,
        gender,
        clinics,
      ];
}
