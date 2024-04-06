import 'package:dento_support/features/patients/models/treatment.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction extends Equatable {
  const Transaction({
    required this.processedToothNumber,
    required this.id,
    required this.type,
    required this.amount,
    required this.notes,
    required this.createdAt,
    required this.patientId,
    required this.clinicId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final List<ProcessedToothNumber> processedToothNumber;
  final int id;
  final String type;
  final int amount;
  final String notes;
  final DateTime createdAt;
  final int patientId;
  final int clinicId;

  @override
  List<Object?> get props => [
        id,
        processedToothNumber,
        type,
        amount,
        notes,
        createdAt,
        patientId,
        clinicId
      ];
}

@JsonSerializable()
class ProcessedToothNumber {
  ProcessedToothNumber({
    required this.treatment,
    required this.tooth,
  });

  factory ProcessedToothNumber.fromJson(Map<String, dynamic> json) =>
      _$ProcessedToothNumberFromJson(json);

  final String treatment;
  final List<String> tooth;

  String get toothString => getToothList(tooth)
      .join(', ')
      .replaceAll('Upper', 'Upper arch')
      .replaceAll('Lower', 'Lower arch');
}
