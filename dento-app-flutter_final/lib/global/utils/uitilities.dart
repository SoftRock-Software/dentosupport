import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/src/view/authorization/signup/controller/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../main.dart';
import '../../src/routes/app_pages.dart';
import '../../src/view/authorization/otp/view/otp_screen.dart';
import '../constants/api_constant.dart';
import '../constants/size_constant.dart';
import '../widgets/custom_dialogs.dart';

Future<void> verifyMobileNumber({
  required BuildContext context,
  required String countryCode,
  required String mobileNumber,
}) async {
  // getIt<CustomDialogs>().hideCircularDialog(context);
  if (mobileNumber.contains("+91")) {
    mobileNumber = mobileNumber.replaceAll("+91", "");
  }

  try {
    getIt<CustomDialogs>().showCircularDialog(context);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$mobileNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("The provided phone number is not valid."),
              duration: Duration(milliseconds: 500),
            ),
          );
        }
        getIt<CustomDialogs>().hideCircularDialog(context);
      },
      codeSent: (String verificationId, int? resendToken) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        box.write(ArgumentConstant.verificationId, verificationId);
        box.write(ArgumentConstant.resendToken, resendToken);
        Get.find<SignUpController>().phoneNumberController.text = mobileNumber;
        Get.bottomSheet(OtpView());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("codeAutoRetrievalTimeout $verificationId");
      },
    );
  } catch (e) {
    // Handle some unknown error
  } finally {
    getIt<CustomDialogs>().hideCircularDialog(context);
  }
}

/*Future<void> verifyMobileNumber({
  required BuildContext context,
  required String countryCode,
  required String mobileNumber,
}) async {
  // getIt<CustomDialogs>().hideCircularDialog(context);
  if (mobileNumber.contains("+91")) {
    mobileNumber = mobileNumber.replaceAll("+91", "");
  }
  getIt<CustomDialogs>().showCircularDialog(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  await FirebaseAuth.instance
      .verifyPhoneNumber(
    phoneNumber: '$countryCode$mobileNumber',
    verificationCompleted: (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("The provided phone number is not valid."),
          duration: Duration(milliseconds: 500),
        ));

        print('The provided phone number is not valid.');
      }
      getIt<CustomDialogs>().hideCircularDialog(context);
    },
    forceResendingToken:
        (isNullEmptyOrFalse(box.read(ArgumentConstant.resendToken)))
            ? null
            : box.read(ArgumentConstant.resendToken),
    codeSent: (String verificationId, int? resendToken) async {
      getIt<CustomDialogs>().hideCircularDialog(context);
      box.write(ArgumentConstant.verificationId, verificationId);
      box.write(ArgumentConstant.resendToken, resendToken);
      Get.bottomSheet(OtpView());
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  )
      .catchError((error) {
    getIt<CustomDialogs>().hideCircularDialog(context);
  });
}*/

Widget getButton({
  double height = 50,
  double width = 335,
  String title = "",
  Widget? widget,
  double borderRadius = 10,
  Color color = Colors.white,
  Color borderColor = Colors.transparent,
  double fontSize = 20,
  FontWeight fontWeight = FontWeight.normal,
  Color? backColor,
}) {
  return Container(
    height: MySize.getHeight(height),
    width: MySize.getWidth(width),
    decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: (isNullEmptyOrFalse(backColor)) ? AppColor.blue : backColor,
        borderRadius: BorderRadius.circular(borderRadius)),
    alignment: Alignment.center,
    child: (!isNullEmptyOrFalse(widget))
        ? widget
        : Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: MySize.getHeight(fontSize),
              fontWeight: fontWeight,
            ),
          ),
  );
}

showConfirmationDialog(
    {required BuildContext context,
    required Widget contentWidget,
    required String cancelText,
    required String submitText,
    required Color cancelTextColor,
    required Color submitTextColor,
    required Color submitBackColor,
    required Color cancelBackColor,
    required Function() cancelCallback,
    required Function() submitCallBack}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MySize.getHeight(20))),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                contentWidget,
                Spacing.height(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: submitCallBack,
                      child: getButton(
                        title: submitText,
                        height: 40,
                        width: 100,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        backColor: submitBackColor,
                        color: submitTextColor,
                      ),
                    ),
                    Spacing.width(20),
                    InkWell(
                      onTap: cancelCallback,
                      child: getButton(
                        title: cancelText,
                        height: 40,
                        width: 100,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        backColor: cancelBackColor,
                        color: cancelTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

getLogOut() {
  GoogleSignIn signIn = GoogleSignIn();
  signIn.signOut();
  clearBox();
  Get.offAllNamed(Routes.SPLASH_SCREEN);
}

getLogOutNoRoute() {
  GoogleSignIn signIn = GoogleSignIn();
  signIn.signOut();
  clearBox();
}

var maskFormatterForMobileNumber =
    MaskTextInputFormatter(mask: '##########', filter: {"#": RegExp(r'[0-9]')});

var maskFormatterForAge =
    MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

var maskFormatterForNumber = MaskTextInputFormatter(
    mask: '##########', filter: {"#": RegExp(r'^\d+\.?\d*')});

var maskFormatterFor2Number =
    MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'^\d+\.?\d*')});

var maskFormatterFor3Number =
    MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'^\d+\.?\d*')});

var maskFormatterFor6Number = MaskTextInputFormatter(
    mask: '######', filter: {"#": RegExp(r'^\d+\.?\d*')});

var maskFormatterFor32Text = MaskTextInputFormatter(
    mask: '################################',
    filter: {"#": RegExp(r"^[A-Za-z]+$")});
