class GetPatientDataListModel {
  String? status;
  List<PatientData>? data = [];

  GetPatientDataListModel({this.status, this.data});

  GetPatientDataListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(PatientData.fromJson(v));
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

class PatientData {
  int? id;
  String? name;
  String? lastVisitedDate;
  String? location;
  int? mobile;
  String? gender;
  int? age;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? remainBill;
  int? userId;
  List<Treatments>? treatments;

  PatientData(
      {this.id,
      this.name,
      this.lastVisitedDate,
      this.location,
      this.mobile,
      this.gender,
      this.age,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.treatments});

  PatientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastVisitedDate = json['lastVisitedDate'];
    location = json['location'];
    mobile = json['mobile'];
    gender = json['gender'];
    age = json['age'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    userId = json['userId'];
    remainBill = json['remainBill'].toString();
    if (json['treatments'] != null) {
      treatments = <Treatments>[];
      json['treatments'].forEach((v) {
        treatments!.add(new Treatments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastVisitedDate'] = this.lastVisitedDate;
    data['location'] = this.location;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['userId'] = this.userId;
    if (this.treatments != null) {
      data['treatments'] = this.treatments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Treatments {
  int? id;
  String? name;
  var amount;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? patientId;
  int? clinicId;
  List<Procedures>? procedures;

  Treatments(
      {this.id,
      this.name,
      this.amount,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.clinicId,
      this.procedures});

  Treatments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientId = json['patientId'];
    clinicId = json['clinicId'];
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
  String? updatedAt;
  int? treatmentId;

  Procedures(
      {this.id, this.name, this.createdAt, this.updatedAt, this.treatmentId});

  Procedures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
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
