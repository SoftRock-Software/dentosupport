

class TreatmentData {
  TreatmentData({
    this.id,
    this.treatment,

  });

  TreatmentData.fromJson(dynamic json) {
    id = json['id'];
    treatment = json['treatment'];

  }

  num? id;
  String? treatment;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['treatment'] = treatment;


    return map;
  }
}