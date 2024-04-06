class SignUpDataModel {
  String? status;
  String? message;
  Data? data;
  String? token;

  SignUpDataModel({this.status, this.message, this.data, this.token});

  SignUpDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? emailUid;
  String? mobileUid;
  String? profilePic;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.emailUid,
      this.mobileUid,
      this.profilePic,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    emailUid = json['emailUid'];
    mobileUid = json['mobileUid'];
    profilePic = json['profilePic'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['emailUid'] = this.emailUid;
    data['mobileUid'] = this.mobileUid;
    data['profilePic'] = this.profilePic;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
