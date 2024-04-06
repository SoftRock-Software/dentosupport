class GetMeDataModel {
  String? status;
  String? message;
  Data? data;

  GetMeDataModel({this.status, this.message, this.data});

  GetMeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
  List<UserData>? data = [];

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? emailUid;
  String? mobileUid;
  String? name;
  String? email;
  String? profilePic;
  int? mobile;
  String? about;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Clinics>? clinics;

  UserData(
      {this.id,
      this.emailUid,
      this.mobileUid,
      this.name,
      this.email,
      this.profilePic,
      this.mobile,
      this.about,
      this.fcmToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.clinics});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emailUid = json['emailUid'];
    mobileUid = json['mobileUid'];
    name = json['name'];
    email = json['email'];
    profilePic = json['profilePic'];
    mobile = json['mobile'];
    about = json['about'];
    fcmToken = json['FcmToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    if (json['clinics'] != null) {
      clinics = <Clinics>[];
      json['clinics'].forEach((v) {
        clinics!.add(new Clinics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emailUid'] = this.emailUid;
    data['mobileUid'] = this.mobileUid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profilePic'] = this.profilePic;
    data['mobile'] = this.mobile;
    data['about'] = this.about;
    data['FcmToken'] = this.fcmToken;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.clinics != null) {
      data['clinics'] = this.clinics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clinics {
  List<String>? dayOff;
  int? id;
  String? name;
  int? mobile;
  String? location;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;

  Clinics(
      {this.dayOff,
      this.id,
      this.name,
      this.mobile,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId});

  Clinics.fromJson(Map<String, dynamic> json) {
    dayOff = json['dayOff'].cast<String>();
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayOff'] = this.dayOff;
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['userId'] = this.userId;
    return data;
  }
}
