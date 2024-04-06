// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      id: json['id'] as int,
      location: json['location'] as String,
      gender: json['gender'] as String,
      age: json['age'] as int,
      remainBill: json['remainBill'] as int,
      lastVisitedDate: json['lastVisitedDate'] as String?,
      userId: json['userId'] as int,
      treatments: (json['treatments'] as List<dynamic>?)
              ?.map((e) => Treatment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      medicalHistories: (json['medicalHistories'] as List<dynamic>?)
              ?.map((e) => MedicalHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'id': instance.id,
      'location': instance.location,
      'gender': instance.gender,
      'age': instance.age,
      'remainBill': instance.remainBill,
      'lastVisitedDate': instance.lastVisitedDate,
      'userId': instance.userId,
      'treatments': instance.treatments,
      'transactions': instance.transactions,
      'medicalHistories': instance.medicalHistories,
    };
