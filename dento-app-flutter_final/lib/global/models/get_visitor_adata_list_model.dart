class VisitorListDataModel {
  String? status;
  List<VisitorData>? data = [];

  VisitorListDataModel({this.status, this.data});

  VisitorListDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(VisitorData.fromJson(v));
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

class VisitorData {
  int? id;
  String? date;
  String? createdAt;
  String? updatedAt;
  int? clinicId;
  int? patientId;
  Patient? patient;

  VisitorData(
      {this.id,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.clinicId,
      this.patientId,
      this.patient});

  VisitorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    clinicId = json['clinicId'];
    patientId = json['patientId'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['clinicId'] = this.clinicId;
    data['patientId'] = this.patientId;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    return data;
  }
}

class Patient {
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
  List<Transactions>? transactions;

  Patient({
    this.id,
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
    this.treatments,
    this.transactions,
  });

  Patient.fromJson(Map<String, dynamic> json) {
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
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
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
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  Transactions({
    this.id,
    this.type,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.patientId,
    this.clinicId,
  });

  int? id;
  String? type;
  int? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? patientId;
  int? clinicId;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        amount: json["amount"] == null ? null : json["amount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        patientId: json["patientId"] == null ? null : json["patientId"],
        clinicId: json["clinicId"] == null ? null : json["clinicId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "amount": amount == null ? null : amount,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "patientId": patientId == null ? null : patientId,
        "clinicId": clinicId == null ? null : clinicId,
      };
}

class Treatments {
  int? id;
  String? name;
  double? amount;
  List? toothNumber;
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
      this.toothNumber,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.patientId,
      this.clinicId,
      this.procedures});

  Treatments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = double.parse(json['amount'].toString());
    toothNumber = json['toothNumber'].runtimeType.toString() == "int" ? [json['toothNumber']] : json['toothNumber'];
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
