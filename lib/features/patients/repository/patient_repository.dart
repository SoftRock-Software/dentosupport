import 'dart:async';
import 'dart:math';

import 'package:dento_support/core/constants/end_point.dart';
import 'package:dento_support/core/services/dio_client.dart';
import 'package:dento_support/features/patients/models/medical_history.dart';
import 'package:dento_support/features/patients/models/missed_visitors_response.dart';
import 'package:dento_support/features/patients/models/patient_response.dart';
import 'package:dento_support/features/patients/models/search_response.dart';
import 'package:dento_support/features/patients/models/visitor_response.dart';
import 'package:dento_support/features/patients/models/visitors_count_response.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class PatientRepository {
  PatientRepository(this._client);

  final DioClient _client;

  /// Provides [Stream] of all histories
  Stream<List<MedicalHistory>> get medicalHistories =>
      _historyStreamController.stream;

  int get medicalHistoryLength =>
      _medicalHistories.where((element) => element.selected).length;
  String get medicalHistoriesString => _medicalHistories
      .where((element) => element.selected)
      .map((e) => e.title)
      .join(', ')
      .replaceAll(', Add your own', '');
  final List<MedicalHistory> _medicalHistories = [];

  late int _patientId;

  final _historyStreamController =
      BehaviorSubject<List<MedicalHistory>>.seeded(const []);

  // Future<PatientResponse> getAllPatients() async {
  //   try {
  //     final response = await _client.get(EndPoint.patient);
  //     return PatientResponse.fromJson(response.data as Map<String, dynamic>);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<VisitorResponse> getVisiterInfoByDate(
    int clinicId,
    String date,
  ) async {
    final response = await _client.get(
      '${EndPoint.visitorInfoByDate}?date=$date&clinicId=$clinicId',
    );
    return VisitorResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<VisitorsCountResponse> getVisitorsCount(int clinicId) async {
    final response = await _client.get(
      '${EndPoint.countOfVisitors}?clinicId=$clinicId',
    );
    return VisitorsCountResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<MissedVisitorsResponse> missedVisitors(int clinicId) async {
    try {
      final response = await _client.get(
        '${EndPoint.missedVisitors}?clinicId=$clinicId',
      );
      return MissedVisitorsResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePatient(int id) async {
    final response =
        await _client.delete<Map<String, dynamic>>('${EndPoint.patient}/$id');
    debugPrint('${response.data}');
  }

  Future<PatientResponse> getPatientWithId(int id) async {
    final random = Random();

    _patientId = id;
    _medicalHistories
      ..clear()
      ..addAll(
        [
          'Diabetes',
          'High blood pressure',
          'Asthama',
          'Heart related disorders',
          'Previous jaw surgery',
          'Allergic to drugs',
          'Haemoglobin deficiency',
          'Cancer',
          'HIV',
          'Hepatitis',
          'Blood thinners and aspirin',
        ].map((e) => MedicalHistory(id: random.nextInt(100), title: e)),
      )
      ..add(
        MedicalHistory(
          id: -1,
          title: 'Add your own',
        ),
      );
    _historyStreamController.add(_medicalHistories);

    final response = await _client.get('${EndPoint.patient}/$id');
    final patientResponse =
        PatientResponse.fromJson(response.data as Map<String, dynamic>);

    for (final i in _medicalHistories) {
      for (final j in patientResponse.data.medicalHistories) {
        if (i.title.toLowerCase() == j.title.toLowerCase()) {
          j.selected = true;

          i
            ..id = j.id
            ..selected = true;
          break;
        }
      }
    }

    _medicalHistories.insertAll(
      0,
      patientResponse.data.medicalHistories
          .where((element) => element.selected == false),
    );
    _historyStreamController.add(_medicalHistories);

    return patientResponse;
  }

  Future<Map<String, dynamic>?> addTreatment(AddTreatmentParams params) async {
    final response = await _client
        .post<Map<String, dynamic>>(EndPoint.treatment, data: params.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>?> addTransaction(
    AddTransactionParams params,
  ) async {
    final response = await _client.post<Map<String, dynamic>>(
      EndPoint.transaction,
      data: params.toJson(),
    );
    return response.data;
  }

  Future<void> addMedicalHistory(String title) async {
    final params = AddMedicalHistoryParams(title: title, patientId: _patientId);

    final response = await _client.post<Map<String, dynamic>>(
      EndPoint.medicalHistory,
      data: params.toJson(),
    );

    if (response.data != null && response.data is Map) {
      final id = ((response.data!)['data'] as Map)['id'] as int;

      final fIndex = _medicalHistories.indexWhere(
        (element) => element.title.toLowerCase() == title.toLowerCase(),
      );

      if (fIndex != -1) {
        _medicalHistories[fIndex].selected = true;
      } else {
        final history = MedicalHistory(id: id, title: title, selected: true);
        _medicalHistories.insert(_medicalHistories.length - 1, history);
      }

      _historyStreamController.add(_medicalHistories);
    }
  }

  Future<void> removeMedicalHistory(int id) async {
    await _client
        .delete<Map<String, dynamic>>('${EndPoint.medicalHistory}/$id');

    final medicalH =
        _medicalHistories.firstWhere((element) => element.id == id);
    final contain = [
      'Diabetes',
      'High blood pressure',
      'Asthama',
      'Heart related disorders',
      'Previous jaw surgery',
      'Allergic to drugs',
      'Haemoglobin deficiency',
      'Cancer',
      'HIV',
      'Hepatitis',
      'Blood thinners and aspirin',
    ].contains(medicalH.title);

    if (contain) {
      medicalH.selected = false;
    } else {
      _medicalHistories.removeWhere((element) => element.id == id);
    }
    _historyStreamController.add(_medicalHistories);
  }

  Future<List<SearchResult>> patientSearch(String searchTerm) async {
    try {
      final response =
          await _client.get('${EndPoint.patientSearch}/$searchTerm');
      return SearchResponse.fromJson(response.data as Map<String, dynamic>)
          .data;
    } catch (e) {
      rethrow;
    }
  }

  Future<PatientResponse> addPatient(AddPatientParams params) async {
    final response = await _client.post<Map<String, dynamic>>(
      EndPoint.patient,
      data: params.toJson(),
    );
    return PatientResponse.fromJson(response.data ?? {});
  }

  Future<void> editPatient(AddPatientParams params, String id) async {
    try {
      await _client.patch('${EndPoint.patient}/$id', data: params.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> scheduleVisitor({
    required int clinicId,
    required int patientId,
    required String date,
  }) async {
    // {"status":"fail","message":"You can not schedule patient in past date"}
    final response = await _client.post<Map<String, dynamic>>(
      EndPoint.visitorSchedule,
      data: {
        'clinicId': clinicId,
        'patientId': patientId,
        'date': date,
      },
    );
    return response.data;
  }
}

class AddTreatmentParams {
  const AddTreatmentParams({
    required this.name,
    required this.amount,
    required this.toothNumber,
    required this.clinicId,
    required this.patientId,
  });

  final String name;
  final double amount;
  final String toothNumber;
  final int clinicId;
  final int patientId;

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'toothNumber': toothNumber,
        'clinicId': clinicId,
        'patientId': patientId
      };
}

class AddTransactionParams {
  const AddTransactionParams({
    required this.type,
    this.notes,
    required this.amount,
    required this.clinicId,
    required this.patientId,
    required this.processedToothNumber,
    this.date,
    this.isCompleted,
  });

  final String type;
  final String? notes;
  final double amount;
  final int clinicId;
  final int patientId;
  final String processedToothNumber;
  final String? date;
  final bool? isCompleted;

  Map<String, dynamic> toJson() => {
        'type': type,
        if (notes != null) 'notes': notes,
        'amount': amount,
        'clinicId': clinicId,
        'patientId': patientId,
        'processedToothNumber': processedToothNumber,
        if (date != null) 'date': date,
        if (isCompleted != null && isCompleted! == true)
          'isComplete': isCompleted,
      };
}

class AddMedicalHistoryParams {
  const AddMedicalHistoryParams({
    required this.patientId,
    required this.title,
    this.description = '',
  });

  final int patientId;
  final String title;
  final String description;

  Map<String, dynamic> toJson() => {
        'patientId': patientId,
        'title': title,
        'description': '',
      };
}

class AddPatientParams {
  const AddPatientParams({
    required this.name,
    required this.mobile,
    required this.gender,
    required this.age,
    required this.clinicId,
    this.location,
  });

  final String name;
  final String mobile;
  final String gender;
  final int age;
  final int clinicId;
  final String? location;

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobile': mobile,
        'gender': gender,
        'age': age,
        'clinicId': clinicId,
        if (location != null) 'location': location
      };
}
