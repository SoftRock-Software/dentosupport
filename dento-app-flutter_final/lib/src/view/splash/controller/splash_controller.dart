//The controller layer is represented by various Commands which contain the Application Logic of the app.
// Commands are used to complete any significant action within your app.

import 'dart:async';
import 'package:Dentosupport_mini/global/utils/shared_preference/local_storage.dart';
import 'package:Dentosupport_mini/global/utils/shared_preference/shared_preference_services.dart';
import 'package:Dentosupport_mini/global/widgets/permission.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../global/constants/api_constant.dart';
import '../../../../global/data/NetworkClient.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // FirebaseCrashlytics.instance.crash();
    box.write(ArgumentConstant.firstTimeSignUp, false);
    super.onInit();
    Timer(
      const Duration(
        seconds: 2,
      ),
      () async {
        var isLogin = await getDataFromLocalStorage(
          dataType: LocalStorage.boolType,
          prefKey: LocalStorageKey.isLogin,
        );

        /*if (isLogin == true) {
          Get.offAllNamed(
            Routes.HOME_SCREEN,
          );
        } else {
          Get.offAllNamed(
            Routes.INTRODUCE_SCREEN,
          );
        }*/
      },
    );
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        final token = await user!.getIdToken();
        print(token);
        if (!isNullEmptyOrFalse(user.email)) {
          box.write(ArgumentConstant.userEmail, user.email.toString().trim());
        }
        if (!isNullEmptyOrFalse(user.uid)) {
          box.write(ArgumentConstant.emailUid, user.uid.toString().trim());
        }

        if (!isNullEmptyOrFalse(user.phoneNumber)) {
          box.write(ArgumentConstant.userMobileNumber,
              user.phoneNumber.toString().trim());
        }
        if (!isNullEmptyOrFalse(user.displayName)) {
          box.write(
              ArgumentConstant.userName, user.displayName.toString().trim());
        }
        if (!isNullEmptyOrFalse(token)) {
          box.write(ArgumentConstant.mailFirebaseToken, token);
          callVerifyUserApi(context: context, firebaseToken: token!);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'The account already exists with a different credential',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            content: 'Error occurred using Google Sign In. Try again.',
          ),
        );
      }
    }

    return user;
  }

  callVerifyUserApi(
      {required BuildContext context,
        required String firebaseToken,
        bool isFromMobile = false}) async {
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["firebase_token"] = firebaseToken;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.verifyUser,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          if (!isNullEmptyOrFalse(response["token"])) {
            box.write(ArgumentConstant.token, response["token"]);
            if (response["user"] == "new") {
              if (isFromMobile) {
                // Show pop up
                getIt<CustomDialogs>().getDialog(
                  title: "Info",
                  desc:
                  "Please first sign up with Google after that use login with phone number.",
                );

                // Get.back();
              } else {
                Get.toNamed(Routes.SIGNUP_SCREEN);
              }
            }
            if (response["user"] == "old") {
              Get.offAllNamed(
                Routes.ADD_PATIENT_AND_HOME_SCREEN,
              );
              box.write(ArgumentConstant.userAlreadyLogin, true);
            }
          }
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>().getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

/*  callVerifyUserApi(
      {required BuildContext context, required String firebaseToken}) async {
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["firebase_token"] = firebaseToken;
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.verifyUser,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          if (!isNullEmptyOrFalse(response["token"])) {
            box.write(ArgumentConstant.token, response["token"]);
            if (response["user"] == "new") {
              Get.toNamed(
                Routes.SIGNUP_SCREEN,
              );
            }
            if (response["user"] == "old") {
              Get.offAllNamed(
                Routes.ADD_PATIENT_AND_HOME_SCREEN,
              );
              box.write(ArgumentConstant.userAlreadyLogin, true);
            }
          }
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>().getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }*/
}
