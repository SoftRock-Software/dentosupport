// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      processedToothNumber: (json['processedToothNumber'] as List<dynamic>)
          .map((e) => ProcessedToothNumber.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
      type: json['type'] as String,
      amount: json['amount'] as int,
      notes: json['notes'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      patientId: json['patientId'] as int,
      clinicId: json['clinicId'] as int,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'processedToothNumber': instance.processedToothNumber,
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'patientId': instance.patientId,
      'clinicId': instance.clinicId,
    };

ProcessedToothNumber _$ProcessedToothNumberFromJson(
        Map<String, dynamic> json) =>
    ProcessedToothNumber(
      treatment: json['treatment'] as String,
      tooth: (json['tooth'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProcessedToothNumberToJson(
        ProcessedToothNumber instance) =>
    <String, dynamic>{
      'treatment': instance.treatment,
      'tooth': instance.tooth,
    };
