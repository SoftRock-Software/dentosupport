import 'package:flutter/material.dart';

import '../../main.dart';

// const baseUrl = "http://43.204.182.53/api/v1";
// const baseUrl = "https://backend.dentosupport.com/api/v1";
const baseUrl = "https://live.dentosupport.com/api/v1";
const imagePngPath = "assets/images/png/";
const imageSvgPath = "assets/images/svg/";

class ApiConstant {
  static const config = "/config";
  static const verifyUser = "/user/verifyUser";
  static const signUp = "/user/signup";
  static const getMe = "/user/getMe";
  static const addClinic = "/clinic";
  static const patient = "/patient";
  static const visitor = "/visitor";
  static const searchPatient = "/patient/search/";
  static const treatment = "/treatment";
  static const treatmentBill = "/treatment/bill";
  static const procedure = "/procedure";
  static const transaction = "/transaction";
  static const transactionBill = "/transaction/bill";
  static const user = "/user";
  static const mobileCheck = "/user/mobileCheck";
}

class ArgumentConstant {
  static const token = "token";
  static const firstTimeSignUp = "firstTimeSignUp";
  static const userAlreadyLogin = "userAlreadyLogin";
  static const userId = "userId";
  static const clinicId = "clientId";
  static const clinicName = "clinicName";
  static const clinicMobile = "clinicMobile";
  static const clinicLocation = "clinicLocation";
  static const clinicDayOff = "clinicDayOff";
  static const patientId = "patientId";
  static const userProfilePic = "userProfilePic";
  static const userEmail = "userEmail";
  static const userName = "userName";
  static const userLatterName = "userLatterName";
  static const userMobileNumber = "userMobileNumber";
  static const emailUid = "emailUid";
  static const mobileUid = "mobileUid";
  static const mailFirebaseToken = "mailFirebaseToken";
  static const numberFirebaseToken = "numberFirebaseToken";
  static const resendToken = "resendToken";
  static const verificationId = "verificationId";
  static const patientName = "patientName";
  static const patientAge = "patientAge";
  static const patientNumber = "patientNumber";
  static const patientGender = "patientGender";
  static const lastVisitedDate = "lastVisitedDate";
}

clearBox() {
  box.write(ArgumentConstant.token, "");
  box.write(ArgumentConstant.userAlreadyLogin, "");
  box.write(ArgumentConstant.userId, "");
  box.write(ArgumentConstant.clinicId, "");
  box.write(ArgumentConstant.userProfilePic, "");
  box.write(ArgumentConstant.userEmail, "");
  box.write(ArgumentConstant.userName, "");
  box.write(ArgumentConstant.userMobileNumber, "");
  box.write(ArgumentConstant.emailUid, "");
  box.write(ArgumentConstant.mobileUid, "");
  box.write(ArgumentConstant.mailFirebaseToken, "");
  box.write(ArgumentConstant.numberFirebaseToken, "");
  box.write(ArgumentConstant.resendToken, "");
  box.write(ArgumentConstant.verificationId, "");
}

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}
