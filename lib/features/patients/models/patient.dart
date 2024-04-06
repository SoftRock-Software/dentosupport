import 'package:dento_support/features/patients/models/medical_history.dart';
import 'package:dento_support/features/patients/models/transaction.dart';
import 'package:dento_support/features/patients/models/treatment.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient extends Equatable {
  const Patient({
    required this.name,
    required this.mobile,
    required this.id,
    required this.location,
    required this.gender,
    required this.age,
    required this.remainBill,
    required this.lastVisitedDate,
    required this.userId,
    this.treatments = const [],
    this.transactions = const [],
    this.medicalHistories = const [],
  });

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  final String name;
  final String mobile;
  final int id;
  final String location;
  final String gender;
  final int age;
  final int remainBill;
  final String? lastVisitedDate;
  final int userId;
  final List<Treatment> treatments;
  final List<Transaction> transactions;
  final List<MedicalHistory> medicalHistories;

  String get genderText {
    switch (gender) {
      case 'M':
        return 'Male';
      case 'F':
        return 'Female';
      case 'O':
        return 'Other';
      default:
        return '';
    }
  }

  String? get lastTreatmentName =>
      treatments.isNotEmpty ? treatments.first.name : null;

  int get lastPaymentAmount => transactions.isNotEmpty
      ? transactions.map((e) => e.amount).reduce((a, b) => a + b)
      : 0;

  String get lastPaymentType => transactions.isNotEmpty
      ? transactions.map<String>((e) => e.type).toSet().toList().join(', ')
      : '';

  @override
  List<Object?> get props => [
        name,
        mobile,
        id,
        location,
        gender,
        age,
        remainBill,
        lastVisitedDate,
        userId,
        treatments,
        transactions,
        medicalHistories,
      ];
}
