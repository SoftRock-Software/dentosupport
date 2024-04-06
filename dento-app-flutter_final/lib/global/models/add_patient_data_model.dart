class AddPatientDataModel {
  String? status;
  String? message;
  Data? data;

  AddPatientDataModel({this.status, this.message, this.data});

  AddPatientDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? mobile;
  String? gender;
  int? age;
  String? location;
  int? userId;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
      this.name,
      this.mobile,
      this.gender,
      this.age,
      this.location,
      this.userId,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    gender = json['gender'];
    age = json['age'];
    location = json['location'];
    userId = json['userId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['location'] = this.location;
    data['userId'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
