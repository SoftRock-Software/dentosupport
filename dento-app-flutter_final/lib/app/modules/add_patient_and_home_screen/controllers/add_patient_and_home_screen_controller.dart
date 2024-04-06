import 'dart:developer';

import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/views/bottom%20widget/role.dart';
import 'package:Dentosupport_mini/global/models/get_me_data_model.dart';
import 'package:Dentosupport_mini/global/models/get_patient_data_list_model.dart';
import 'package:Dentosupport_mini/global/models/get_visitor_adata_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../global/constants/api_constant.dart';
import '../../../../global/data/NetworkClient.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';
import '../../../../src/routes/app_pages.dart';

class AddPatientAndHomeScreenController extends GetxController {
  GlobalKey<FormState> addPatientFormKey = GlobalKey<FormState>();
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> ageController = TextEditingController().obs;
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  RxList<VisitorData> patientList = RxList<VisitorData>([]);
  RxList<PatientData> searchPatientList = RxList<PatientData>([]);
  RxString userName = "".obs;
  RxString selectedGender = "M".obs;
  RxString selectedFilter = "Today".obs;
  RxString addPatientNameOnChange = "".obs;
  RxBool addPatientNameOnFocus = false.obs;
  RxString searchPatientsOnChange = "".obs;
  RxString addPatientPhoneNumberOnChange = "".obs;
  RxBool addPatientPhoneNumberOnFocus = false.obs;
  RxString addSearchPatient = "".obs;

  RxInt noOfVisitor = 0.obs;
  RxBool hasData = false.obs;
  RxBool isPatientNotAdded = true.obs;
  RxBool isAddPatientActive = false.obs;
  RxBool isSearchStarted = false.obs;
  RxBool hasSearchData = true.obs;

  List filterList = [
    "Today",
    "Yesterday",
    "Other",
  ];

  @override
  void onInit() {
    callGetMeApi(context: Get.context!);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  callGetMeApi({required BuildContext context}) async {
    hasData.value = false;
    Map<String, dynamic> dict = {};

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.getMe,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=-=-callGetMeApi");
        log("-=-=-=-response-=-=-$response");

        if (response["status"] == 200 || response["status"] == "success") {
          GetMeDataModel res = GetMeDataModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.data)) {
            if (!isNullEmptyOrFalse(res.data!.data)) {
              if (!isNullEmptyOrFalse(res.data!.data![0])) {
                if (!isNullEmptyOrFalse(res.data!.data![0].id)) {
                  box.write(ArgumentConstant.userId,
                      res.data!.data![0].id.toString());
                }
                if (!isNullEmptyOrFalse(res.data!.data![0].emailUid)) {
                  box.write(ArgumentConstant.emailUid,
                      res.data!.data![0].emailUid.toString());
                }
                if (!isNullEmptyOrFalse(res.data!.data![0].mobileUid)) {
                  box.write(ArgumentConstant.mobileUid,
                      res.data!.data![0].mobileUid.toString());
                }
                if (!isNullEmptyOrFalse(res.data!.data![0].mobile)) {
                  box.write(ArgumentConstant.userMobileNumber,
                      res.data!.data![0].mobile.toString());
                }

                if (!isNullEmptyOrFalse(res.data!.data![0].name)) {
                  debugPrint("-=-name=1=-");
                  box.write(ArgumentConstant.userName,
                      res.data!.data![0].name.toString());

                  debugPrint(
                      "-=-name=2=-${res.data!.data![0].name.toString()}");

                  List<String> temp =
                      res.data!.data![0].name.toString().split(" ");

                  debugPrint("-=-name=3=-$temp");

                  userName.value =
                      temp[0].toString()[0].toString().toUpperCase();

                  debugPrint("-=-name=4=-${userName.value}");
                  if (temp.length > 1) {
                    userName.value = userName.value +
                        temp[1].toString()[0].toString().toUpperCase();
                    debugPrint("-=-name=5=-${userName.value}");
                  }

                  box.write(ArgumentConstant.userLatterName, userName.value);

                  // userName.refresh();

                  debugPrint("-userName=-=-=${userName.value}");
                  debugPrint(
                      "-userLatterName=-=-=${box.read(ArgumentConstant.userLatterName)}");
                }
                if (!isNullEmptyOrFalse(res.data!.data![0].email)) {
                  box.write(ArgumentConstant.userEmail,
                      res.data!.data![0].email.toString());
                }

                debugPrint("-=-==clinics-=-${res.data!.data![0].clinics}");
                if (!isNullEmptyOrFalse(res.data!.data![0].clinics)) {
                  if (!isNullEmptyOrFalse(res.data!.data![0].clinics![0])) {
                    if (!isNullEmptyOrFalse(
                        res.data!.data![0].clinics![0].id)) {
                      box.write(ArgumentConstant.clinicId,
                          res.data!.data![0].clinics![0].id.toString());
                    }
                    if (!isNullEmptyOrFalse(
                        res.data!.data![0].clinics![0].name)) {
                      box.write(ArgumentConstant.clinicName,
                          res.data!.data![0].clinics![0].name.toString());
                    }
                    if (!isNullEmptyOrFalse(
                        res.data!.data![0].clinics![0].mobile)) {
                      box.write(ArgumentConstant.clinicMobile,
                          res.data!.data![0].clinics![0].mobile.toString());
                    }
                    if (!isNullEmptyOrFalse(
                        res.data!.data![0].clinics![0].location)) {
                      box.write(ArgumentConstant.clinicLocation,
                          res.data!.data![0].clinics![0].location.toString());
                    }
                    if (!isNullEmptyOrFalse(
                        res.data!.data![0].clinics![0].dayOff)) {
                      box.write(ArgumentConstant.clinicDayOff,
                          res.data!.data![0].clinics![0].dayOff![0].toString());
                    }
                  }
                }
                callGetPatientListApi(
                  context: context,
                  dateFilter:
                      "?day=Today&clinicId=${box.read(ArgumentConstant.clinicId)}",
                  // "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now())}&clinicId=${box.read(ArgumentConstant.clinicId)}",
                );
              }
            }
          }
        } else {
          hasData.value = false;
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        hasData.value = true;
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callGetPatientListApi({
    required BuildContext context,
    required String dateFilter,
    bool isLoad = false,
    bool isLoaderShow = false,
  }) async {
    if (isLoaderShow) {
      getIt<CustomDialogs>().showCircularDialog(context);
    }

    Map<String, dynamic> dict = {};
    patientList.clear();
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.visitor + dateFilter,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) async {
        debugPrint("-=-=baseUrl-=-$baseUrl");
        debugPrint("-=-=ApiConstant-=-${ApiConstant.visitor + dateFilter}");
        debugPrint("-=-=dict-=-$dict");
        log("-=11-=response-=-$response");

        hasData.value = true;
        if (response["status"] == 200 || response["status"] == "success") {
          if (isLoaderShow) {
            await Future.delayed(const Duration(milliseconds: 500), () {
              getIt<CustomDialogs>().hideCircularDialog(context);

              isPatientNotAdded.value = false;
              VisitorListDataModel res =
                  VisitorListDataModel.fromJson(response);
              if (!isNullEmptyOrFalse(res.data)) {
                res.data!.forEach((element) {
                  patientList.add(element);
                });
              }

              debugPrint("-=-=response-=-$response");

              noOfVisitor.value = response["no_of_visitor"];

              debugPrint("-=-=length-=-${patientList.length}");

              if (!isNullEmptyOrFalse(patientList)) {
                debugPrint("-=-=1-=-${isPatientNotAdded.value}");
                isPatientNotAdded.value = false;
              }

              debugPrint("-=-=-=-${isPatientNotAdded.value}");

              if (isLoad) {
                searchController.value.clear();
                FocusManager.instance.primaryFocus!.unfocus();
                isSearchStarted.value = false;
              }
            });
          } else {
            isPatientNotAdded.value = false;
            VisitorListDataModel res = VisitorListDataModel.fromJson(response);
            if (!isNullEmptyOrFalse(res.data)) {
              res.data!.forEach((element) {
                patientList.add(element);
              });
            }

            debugPrint("-=-=response-=-$response");

            noOfVisitor.value = response["no_of_visitor"];

            debugPrint("-=-=length-=-${patientList.length}");

            if (!isNullEmptyOrFalse(patientList)) {
              debugPrint("-=-=1-=-${isPatientNotAdded.value}");
              isPatientNotAdded.value = false;
            }

            debugPrint("-=-=-=-${isPatientNotAdded.value}");

            if (isLoad) {
              searchController.value.clear();
              FocusManager.instance.primaryFocus!.unfocus();
              isSearchStarted.value = false;
            }
          }
        } else {
          if (isLoaderShow) {
            getIt<CustomDialogs>().hideCircularDialog(context);
          }
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        if (isLoaderShow) {
          getIt<CustomDialogs>().hideCircularDialog(context);
        }

        hasData.value = true;
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callAddPatientApi({required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["name"] = nameController.value.text.trim();
    dict["mobile"] = int.parse(mobileNumberController.value.text);
    dict["gender"] = selectedGender.value;
    dict["age"] = int.parse(ageController.value.text);

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patient,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        if (response["status"] == 200 || response["status"] == "success") {
          if (!isNullEmptyOrFalse(response["data"])) {
            if (!isNullEmptyOrFalse(response["data"]["id"])) {
              callAddVisitorApi(
                context: context,
                patientId: response["data"]["id"],
                // homeScreenRoute: true,
              );
            } else {
              getIt<CustomDialogs>().hideCircularDialog(context);
            }
          } else {
            getIt<CustomDialogs>().hideCircularDialog(context);
          }
        } else {
          getIt<CustomDialogs>().hideCircularDialog(context);
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callAddVisitorApi({
    required BuildContext context,
    required int patientId,
    bool justAdd = false,
    bool homeScreenRoute = false,
  }) async {
    debugPrint("-=-=-=--${box.read(ArgumentConstant.clinicId)}");

    Map<String, dynamic> dict = {};
    dict["date"] = DateFormat("yyyy-MM-dd").format(DateTime.now());
    dict["patientId"] = patientId;
    dict["clinicId"] = int.parse(box.read(ArgumentConstant.clinicId));
    if (justAdd) {
      getIt<CustomDialogs>().showCircularDialog(context);
    }
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.visitor,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          if (homeScreenRoute == true) {
            Get.offAllNamed(Routes.ADD_PATIENT_AND_HOME_SCREEN);
          } else {
            if (justAdd) {
              callGetPatientListApi(
                  context: context,
                  dateFilter:
                      "?day=Today&clinicId=${box.read(ArgumentConstant.clinicId)}",
                  // "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now())}&clinicId=${box.read(ArgumentConstant.clinicId)}",
                  isLoad: true);
            } else {
              callGetPatientListApi(
                context: context,
                dateFilter:
                    "?day=Today&clinicId=${box.read(ArgumentConstant.clinicId)}",
                // "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now())}&clinicId=${box.read(ArgumentConstant.clinicId)}",
              );
              Get.toNamed(Routes.INDIVIDUAL_PATIENT_SCREEN, arguments: {
                ArgumentConstant.patientId: patientId,
                ArgumentConstant.patientName: nameController.value.text,
                ArgumentConstant.patientAge: ageController.value.text,
                ArgumentConstant.patientGender: selectedGender.value,
                ArgumentConstant.patientNumber:
                    mobileNumberController.value.text,
              });
              nameController.value.clear();
              ageController.value.clear();
              mobileNumberController.value.clear();
              isAddPatientActive.value = false;
            }
          }
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  commonAddVisitorApi(
      {required BuildContext context,
      required int patientId,
      bool justAdd = false}) async {
    Map<String, dynamic> dict = {};
    dict["date"] = DateFormat("yyyy-MM-dd").format(DateTime.now());
    dict["patientId"] = patientId;
    dict["clinicId"] = int.parse(box.read(ArgumentConstant.clinicId));
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.visitor,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        if (response["status"] == 200 || response["status"] == "success") {
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  searchPatientApi(
      {required BuildContext context, required String text}) async {
    hasSearchData.value = false;
    searchPatientList.clear();
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.searchPatient + text,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        log("-=-=response-=-1=-$response");

        hasSearchData.value = true;
        if (response["status"] == 200 || response["status"] == "success") {
          GetPatientDataListModel res =
              GetPatientDataListModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.data)) {
            res.data!.forEach((element) {
              searchPatientList.add(element);
            });
          }
        } else {
          /*getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);*/
        }
      },
      failureCallback: (response, message) {
        hasSearchData.value = true;
        /*getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: "Something went wrong.");*/
        print(" error");
      },
    );
  }
}
