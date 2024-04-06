import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TreatmentDataModel {
  String? status;
  List<Treatment>? data = [];

  TreatmentDataModel({this.status, this.data});

  TreatmentDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(Treatment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Treatment {
  int? id;
  String? name;
  double? amount;
  List? toothNumber;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? patientId;
  int? clinicId;
  RxBool? isExpanded;
  List<Procedures>? procedures;

  Treatment(
      {this.id,
      this.name,
      this.amount,
      this.toothNumber,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.clinicId,
      this.isExpanded,
      this.procedures});

  Treatment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = double.parse(json['amount'].toString());
    toothNumber = /*json['toothNumber'].runtimeType.toString() == "int"
        ? [json['toothNumber']]
        : */json['toothNumber'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
    clinicId = json['clinicId'];
    isExpanded = false.obs;
    if (json['procedures'] != null) {
      procedures = <Procedures>[];
      json['procedures'].forEach((v) {
        procedures!.add(new Procedures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['toothNumber'] = this.toothNumber;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patientId'] = this.patientId;
    data['clinicId'] = this.clinicId;
    if (this.procedures != null) {
      data['procedures'] = this.procedures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Procedures {
  int? id;
  String? name;
  String? createdAt;
  DateTime? dateTimeCreatedAt;
  String? updatedAt;
  int? treatmentId;

  Procedures(
      {this.id, this.name, this.createdAt, this.updatedAt, this.treatmentId});

  Procedures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    if (!isNullEmptyOrFalse(createdAt)) {
      dateTimeCreatedAt = DateTime.parse(createdAt!);
    }
    updatedAt = json['updatedAt'];
    treatmentId = json['treatmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['treatmentId'] = this.treatmentId;
    return data;
  }
}
