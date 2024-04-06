import 'dart:developer';

import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/controllers/add_patient_and_home_screen_controller.dart';
import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/views/bottom%20widget/role.dart';
import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/models/payment_history_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../global/data/NetworkClient.dart';
import '../../../../global/models/tratment_data_model.dart';
import '../../../../global/widgets/custom_dialogs.dart';
import '../../../../main.dart';
import '../../../../src/routes/app_pages.dart';

class IndividualPatientScreenController extends GetxController {
  AddPatientAndHomeScreenController addPatientAndHomeScreenController =
      AddPatientAndHomeScreenController();

  GlobalKey<FormState> addTreatmentFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addProcedureFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addRecordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editPatientFormKey = GlobalKey<FormState>();
  Rx<TextEditingController> treatmentName = TextEditingController().obs;
  Rx<TextEditingController> treatmentAmount = TextEditingController().obs;
  Rx<TextEditingController> treatmentToothNumber = TextEditingController().obs;
  Rx<TextEditingController> procedureName = TextEditingController().obs;
  Rx<TextEditingController> paymentAmount = TextEditingController().obs;
  Rx<TextEditingController> patientNameController = TextEditingController().obs;
  Rx<TextEditingController> patientAgeController = TextEditingController().obs;
  Rx<TextEditingController> patientNumberController =
      TextEditingController().obs;
  RxString treatmentNameEditValue = "".obs;
  RxString selectedGenderType = "M".obs;
  RxList<Treatment> activeTreatmentList = RxList<Treatment>([]);
  RxList<Treatment> completedTreatmentList = RxList<Treatment>([]);
  RxList<PaymentData> paymentHistoryList = RxList<PaymentData>([]);
  RxString pendingPayment = "0".obs;
  RxString treatmentId = "".obs;
  RxInt addProcedureIndex = 0.obs;
  String patientName = "";
  String lastVisitedDate = "";
  String patientNumber = "";
  String patientAge = "";
  String patientGender = "";
  String patientId = "";
  String clinicId = "";
  RxBool hasData = false.obs;
  RxBool autoFocus = false.obs;
  RxBool hasPaymentDataData = false.obs;
  RxBool isCashTrue = false.obs;
  RxBool isAddTreatmentActive = false.obs;
  RxBool isAddProcedureActive = false.obs;
  RxBool isAddRecordPaymentActive = false.obs;
  RxBool isAddPaymentHistoryActive = false.obs;
  RxBool isActionBottomActive = false.obs;
  RxBool isEditPatientActive = false.obs;
  RxBool isEditTreatmentActive = false.obs;

  RxList toothNumberListApi = [].obs;
  RxList<Map<String, dynamic>> toothNumberList = <Map<String, dynamic>>[].obs;
  RxInt toothNumberSelectTab = 0.obs;
  RxInt toothNumberSelectTabApi = 0.obs;

  RxList<TreatmentData> treatmentSuggestions = <TreatmentData>[].obs;
  Rx<TreatmentData> treatmentSuggestionsData = TreatmentData().obs;
  List treatmentNameList = [
    "Consultation",
    "Xray",
    "Metal Braces",
    "Ceramic Braces",
    "Lingual Braces",
    "Clear Aligners",
    "Complete Denture",
    "Removable Partial Denture",
    "Cast Partial Denture",
    "Crown",
    "Bridge",
    "Implant",
    "Root canal Treatment",
    "Composite Restoration",
    "GIC restoration",
    "Other restorations",
    "Post & Core",
    "Post RCT restoration",
    "Inlay",
    "Onlay",
    "Oral Surgery",
    "Extraction",
    "Disimpaction",
    "Minor Surgical procedure",
    "Pedodontics",
    "Pulpectomy",
    "Restorations",
  ];

  static String roleAssignSelectName(TreatmentData option) => option.treatment!;

  @override
  void onInit() {
    treatmentNameList.asMap().forEach(
      (index, element) {
        treatmentSuggestions.add(
          TreatmentData(
            id: index,
            treatment: "${element}",
          ),
        );
      },
    );
    if (!isNullEmptyOrFalse(Get.arguments)) {
      debugPrint(
          "-=-=lastVisitedDate-=-${Get.arguments[ArgumentConstant.lastVisitedDate].toString()}");

      patientId = Get.arguments[ArgumentConstant.patientId].toString();
      patientName = Get.arguments[ArgumentConstant.patientName].toString();
      lastVisitedDate =
          Get.arguments[ArgumentConstant.lastVisitedDate].toString();
      patientNumber = Get.arguments[ArgumentConstant.patientNumber].toString();
      patientAge = Get.arguments[ArgumentConstant.patientAge].toString();
      patientGender = Get.arguments[ArgumentConstant.patientGender].toString();
      clinicId = box.read(ArgumentConstant.clinicId).toString();
      print(
          "Clinic Id : = ${box.read(ArgumentConstant.clinicId)}  Patient Id : =  $patientId}");
      callGetTreatmentListApi(
          context: Get.context!, patientId: patientId, isFirst: true);
    }
    super.onInit();
  }

  callGetTreatmentListApi(
      {required BuildContext context,
      required String patientId,
      bool isFirst = false}) async {
    hasData.value = false;
    activeTreatmentList.clear();
    completedTreatmentList.clear();
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.treatment + "?clinicId=${clinicId}&patientId=${patientId}",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=GetTreatmentList-=-$response");

        if (response["status"] == 200 || response["status"] == "success") {
          callGetTreatmentBillApi(context: context, patientId: patientId);
          TreatmentDataModel res = TreatmentDataModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.data)) {
            res.data!.forEach(
              (element) {
                if (!isNullEmptyOrFalse(element.status)) {
                  if (element.status == "OnGoing") {
                    activeTreatmentList.add(element);
                  } else {
                    completedTreatmentList.add(element);
                  }
                }
              },
            );

            if (activeTreatmentList.isNotEmpty) {
              if (isFirst) {
                activeTreatmentList[0].isExpanded!.value = true;
              } else {
                activeTreatmentList[addProcedureIndex.value].isExpanded!.value =
                    true;
              }
            }
          }
          if (!isFirst) {
            Get.find<AddPatientAndHomeScreenController>().selectedFilter.value =
                "Today";
            Get.find<AddPatientAndHomeScreenController>().callGetPatientListApi(
              context: context,
              dateFilter:
                  "?day=Today&clinicId=${box.read(ArgumentConstant.clinicId)}",
              // "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now())}&clinicId=${box.read(ArgumentConstant.clinicId)}",
            );
          }

          log("-=-=-response=-$response");
        } else {
          hasData.value = true;
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        hasData.value = true;
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callGetTreatmentBillApi(
      {required BuildContext context, required String patientId}) async {
    hasData.value = false;
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.treatmentBill +
          "?clinicId=${clinicId}&patientId=${patientId}",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=GetTreatmentBill-response=-$response");

        hasData.value = true;
        if (response["status"] == 200 || response["status"] == "success") {
          if (!isNullEmptyOrFalse(response["data"])) {
            if (!isNullEmptyOrFalse(response["data"][0])) {
              if (!isNullEmptyOrFalse(response["data"][0]["totalAmount"])) {
                pendingPayment.value =
                    response["data"][0]["totalAmount"].toString();
                callGetTransactionBillApi(
                    context: context,
                    patientId: patientId,
                    amount: response["data"][0]["totalAmount"].toString());
              }
            }
          }
        } else {
          hasData.value = true;
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        hasData.value = true;
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callGetTransactionBillApi(
      {required BuildContext context,
      required String patientId,
      required String amount}) async {
    hasData.value = false;
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.transactionBill +
          "?clinicId=${clinicId}&patientId=${patientId}",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=GetTransactionBill-response=-=-$response");

        hasData.value = true;
        if (response["status"] == 200 || response["status"] == "success") {
          if (!isNullEmptyOrFalse(response["data"])) {
            if (!isNullEmptyOrFalse(response["data"][0])) {
              if (!isNullEmptyOrFalse(response["data"][0]["totalAmount"])) {
                double remainingAmount = double.parse(amount) -
                    double.parse(response["data"][0]["totalAmount"]);
                pendingPayment.value = remainingAmount.toString();
              }
            }
          }
        } else {
          hasData.value = true;
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        hasData.value = true;
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callAddTreatmentApi(
      {required BuildContext context, required String patientId}) async {
    FocusScope.of(context).unfocus();
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["name"] = treatmentName.value.text.trim();
    dict["amount"] = double.parse(treatmentAmount.value.text);
    treatmentToothNumber.value.text.isEmpty
        ? null
        : dict["toothNumber"] = treatmentToothNumber.value.text;
    // : dict["toothNumber"] = int.parse(treatmentToothNumber.value.text);
    /*dict["toothNumber"] = toothNumberList
        .map((element) => element["numberApi"])
        .toList()
        .join(", ");*/
    dict["clinicId"] = int.parse(clinicId);
    dict["patientId"] = int.parse(patientId);

    debugPrint("-=-dict=-=-$dict");

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.treatment,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);

        debugPrint("-=-response=-=-${response}");
        debugPrint("-=-=dict-=-${dict}");
        debugPrint("-=-=toothNumber-=-${dict["toothNumber"]}");
        debugPrint("-=-=toothNumber-=-${toothNumberList}");

        if (response["status"] == 200 || response["status"] == "success") {
          closeAllBottoms();
          callGetTreatmentListApi(context: context, patientId: patientId);
          addPatientAndHomeScreenController.commonAddVisitorApi(
            context: context,
            patientId: int.parse(patientId),
            justAdd: true,
          );
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);

        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callEditTreatmentApi({
    required BuildContext context,
    required String patientId,
    required String treatmentId,
  }) async {
    FocusScope.of(context).unfocus();
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["name"] = treatmentName.value.text.trim();
    dict["amount"] = double.parse(treatmentAmount.value.text);

    treatmentToothNumber.value.text.isNotEmpty ?
    dict["toothNumber"] = treatmentToothNumber.value.text : dict["toothNumber"] = "";
    // dict["toothNumber"] = int.parse(treatmentToothNumber.value.text);
    dict["clinicId"] = int.parse(clinicId);
    dict["patientId"] = int.parse(patientId);

    debugPrint("-=-=-dict=--=${dict}");

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.treatment + "/$treatmentId",
      MethodType.Patch,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          closeAllBottoms();
          callGetTreatmentListApi(context: context, patientId: patientId);
          addPatientAndHomeScreenController.commonAddVisitorApi(
            context: context,
            patientId: int.parse(patientId),
            justAdd: true,
          );
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);

        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callCompleteTreatmentApi(
      {required BuildContext context, required String treatmentId}) async {
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["status"] = "Done";

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.treatment + "/$treatmentId",
      MethodType.Patch,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          callGetTreatmentListApi(context: context, patientId: patientId);
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);

        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callAddProcedureApi(
      {required BuildContext context, required String treatmentId}) async {
    FocusScope.of(context).unfocus();
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["name"] = procedureName.value.text.trim();
    dict["treatmentId"] = treatmentId;

    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.procedure,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          isAddTreatmentActive.value = false;
          isAddProcedureActive.value = false;
          callGetTreatmentListApi(context: context, patientId: patientId);
          addPatientAndHomeScreenController.commonAddVisitorApi(
            context: context,
            patientId: int.parse(patientId),
            justAdd: true,
          );
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);

        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callGetPaymentHistoryListApi(
      {required BuildContext context, required String patientId}) async {
    hasPaymentDataData.value = false;
    paymentHistoryList.clear();
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.transaction + "?clinicId=${clinicId}&patientId=${patientId}",
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        hasPaymentDataData.value = true;
        if (response["status"] == 200 || response["status"] == "success") {
          PaymentHistoryDataModel res =
              PaymentHistoryDataModel.fromJson(response);
          if (!isNullEmptyOrFalse(res.data)) {
            res.data!.forEach((element) {
              paymentHistoryList.add(element);
            });
          }
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        hasPaymentDataData.value = true;
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callAddPaymentApi(
      {required BuildContext context, required String patientId}) async {
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["type"] = (isCashTrue.isTrue) ? "Cash" : "Online";
    dict["amount"] = double.parse(paymentAmount.value.text.trim());
    dict["clinicId"] = int.parse(clinicId);
    dict["patientId"] = int.parse(patientId);
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.transaction,
      MethodType.Post,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        getIt<CustomDialogs>().hideCircularDialog(context);

        if (response["status"] == 200 || response["status"] == "success") {
          closeAllBottoms();
          isAddRecordPaymentActive.value = false;
          paymentAmount.value.clear();
          callGetTreatmentListApi(context: context, patientId: patientId);

          addPatientAndHomeScreenController.commonAddVisitorApi(
            context: context,
            patientId: int.parse(patientId),
            justAdd: true,
          );
        } else {
          paymentAmount.value.clear();
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {
        paymentAmount.value.clear();
        getIt<CustomDialogs>().hideCircularDialog(context);
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  callDeletePatientApi(
      {required BuildContext context, required String patientId}) async {
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patient + "/$patientId",
      MethodType.Delete,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=-=-$response");
        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          Get.offAllNamed(Routes.ADD_PATIENT_AND_HOME_SCREEN);
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

  callEditPatientApi(
      {required BuildContext context,
      required String patientId,
      String? gender}) async {
    debugPrint("-=-=-=-");
    FocusScope.of(context).unfocus();
    getIt<CustomDialogs>().showCircularDialog(context);
    Map<String, dynamic> dict = {};
    dict["name"] = patientNameController.value.text.trim();
    dict["mobile"] = int.parse(patientNumberController.value.text);
    dict["gender"] = gender;
    // dict["gender"] = selectedGenderType.value;
    dict["age"] = int.parse(patientAgeController.value.text);

    debugPrint("-=-=-selectedGenderType=-${selectedGenderType.value}");
    debugPrint("-=-=dict-=-$dict");
    return NetworkClient.getInstance.callApi(
      context,
      baseUrl,
      ApiConstant.patient + "/$patientId",
      MethodType.Patch,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=-=-$response");

        getIt<CustomDialogs>().hideCircularDialog(context);
        if (response["status"] == 200 || response["status"] == "success") {
          patientName = patientNameController.value.text;
          patientNumber = patientNumberController.value.text;
          patientAge = patientAgeController.value.text;
          patientGender = gender!;
          // patientGender = selectedGenderType.value;
          isEditPatientActive.value = false;
          Get.find<AddPatientAndHomeScreenController>().callGetPatientListApi(
            context: context,
            dateFilter:
                "?day=Today&clinicId=${box.read(ArgumentConstant.clinicId)}",
            // "?date=${DateFormat("yyyy-MM-dd").format(DateTime.now())}&clinicId=${box.read(ArgumentConstant.clinicId)}",
          );
          Get.find<AddPatientAndHomeScreenController>().selectedFilter.value =
              "Today";
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

  closeAllBottoms() {
    isAddTreatmentActive.value = false;
    isAddProcedureActive.value = false;
    isAddRecordPaymentActive.value = false;
    isAddPaymentHistoryActive.value = false;
    isActionBottomActive.value = false;
    isEditPatientActive.value = false;
    isEditTreatmentActive.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
