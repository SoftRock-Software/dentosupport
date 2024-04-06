import 'package:Dentosupport_mini/global/constants/api_constant.dart';

class PaymentHistoryDataModel {
  String? status;
  List<PaymentData>? data = [];

  PaymentHistoryDataModel({this.status, this.data});

  PaymentHistoryDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(PaymentData.fromJson(v));
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

class PaymentData {
  int? id;
  String? type;
  int? amount;
  String? createdAt;
  DateTime? dateTimeCreatedAt;
  String? updatedAt;
  int? patientId;
  int? clinicId;

  PaymentData(
      {this.id,
      this.type,
      this.amount,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.clinicId});

  PaymentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    if (!isNullEmptyOrFalse(createdAt)) {
      dateTimeCreatedAt = DateTime.parse(createdAt!);
    }
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
    clinicId = json['clinicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['patientId'] = this.patientId;
    data['clinicId'] = this.clinicId;
    return data;
  }
}
