import 'package:Dentosupport_mini/app/modules/add_patient_and_home_screen/views/bottom%20widget/role.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/bottomWidget/select_tooth_number.dart';
import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/utils/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/individual_patient_screen_controller.dart';
import '../../../../../global/constants/size_constant.dart';
import '../../../../../global/utils/uitilities.dart';

class BottomWidgetAddTreatment extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();

  BottomWidgetAddTreatment({required this.individualPatientScreenController});

  @override
  _BottomWidgetAddTreatmentState createState() =>
      _BottomWidgetAddTreatmentState();
}

class _BottomWidgetAddTreatmentState extends State<BottomWidgetAddTreatment> {
  IndividualPatientScreenController controller =
      IndividualPatientScreenController();

  final focus = FocusNode();

  @override
  void initState() {
    focus.requestFocus();
    controller = widget.individualPatientScreenController;
    if (controller.isEditTreatmentActive.isFalse) {
      controller.autoFocus.value = true;
      controller.treatmentName.value.clear();
      controller.treatmentAmount.value.clear();
      controller.treatmentToothNumber.value.clear();
    } else {
      controller.autoFocus.value = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addTreatmentFormKey,
      child: Container(
        height: MySize.getHeight(220),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.width(10),
                InkWell(
                    onTap: () {
                      controller.closeAllBottoms();
                      controller.isAddTreatmentActive.value = false;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: MySize.getHeight(10)),
                      child: Icon(Icons.arrow_back_ios,
                          size: MySize.getHeight(25), color: AppColor.blue),
                    )),
                Spacing.width(5),
                Container(
                    width: MySize.getWidth(197),
                    height: MySize.getHeight(70),
                    child: getTextField(
                        textEditingController: controller.treatmentName.value,
                        textCapitalization: TextCapitalization.sentences,
                        focusNode: focus,
                        hintText: "Enter Treatment",
                        validation: (val) {
                          if (isNullEmptyOrFalse(val)) {
                            return "Enter name";
                          } else if (!RegExp(r'^[\ a-zA-Z0-9]+$')
                              .hasMatch(val!)) {
                            return "Please enter a valid name";
                          }
                          return null;
                        },
                        fillColor: Color(0xffEFEFF0))),
                Spacing.width(8),
                Container(
                    width: MySize.getWidth(115),
                    height: MySize.getHeight(70),
                    child: getTextField(
                        textEditingController: controller.treatmentAmount.value,
                        textInputType: TextInputType.numberWithOptions(),
                        numberTextFormatter: true,
                        maxLength: 6,
                        hintText: "Amount",
                        validation: (val) {
                          if (isNullEmptyOrFalse(val)) {
                            return "Enter amount";
                          } else if (controller
                                      .treatmentAmount.value.text.length <
                                  2 ||
                              controller.treatmentAmount.value.text.length >
                                  6) {
                            return "Wrong amount";
                          } else if (int.parse(controller
                                  .treatmentAmount.value.text
                                  .toString()) <
                              50) {
                            return "Wrong amount";
                          }
                          return null;
                        },
                        fillColor: Color(0xffEFEFF0))),
              ],
            ),*/
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.width(10),
                InkWell(
                    onTap: () {
                      controller.closeAllBottoms();
                      controller.isAddTreatmentActive.value = false;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: MySize.getHeight(10)),
                      child: Icon(Icons.arrow_back_ios,
                          size: MySize.getHeight(25), color: AppColor.blue),
                    )),
                Spacing.width(5),
                Expanded(
                  child: Container(
                    height: MySize.getHeight(70),
                    child: controller.treatmentSuggestions.isEmpty
                        ? SizedBox()
                        : Autocomplete<TreatmentData>(
                            displayStringForOption:
                                IndividualPatientScreenController
                                    .roleAssignSelectName,
                            initialValue: TextEditingValue(
                                text: controller.treatmentName.value.text),
                            fieldViewBuilder: (
                              _,
                              textController,
                              focus2,
                              fun,
                            ) {
                              return getTextField(
                                  textEditingController: textController,
                                  // controller.treatmentName.value,
                                  // textCapitalization: TextCapitalization.sentences,
                                  autoFocus: /*controller.autoFocus.value == false
                                      ? false
                                      : */
                                      true,
                                  focusNode: focus2,
                                  hintText: "Enter Treatment",
                                  onChange: (value) {
                                    controller.treatmentName.value.text = value;
                                  },
                                  validation: (val) {
                                    if (isNullEmptyOrFalse(val)) {
                                      return "Enter name";
                                    } else if (!RegExp(r"^[A-Za-z ]+$")
                                        // } else if (!RegExp(r'^[\ a-zA-Z0-9]+$')
                                        .hasMatch(val!.trim())) {
                                      return "Please enter a valid name";
                                    }
                                    return null;
                                  },
                                  fillColor: Color(0xffEFEFF0));
                            },
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              debugPrint(
                                  "-=-=-empty-=${controller.treatmentNameEditValue.value} == ${textEditingValue.text}");
                              if (textEditingValue.text == '') {
                                return Iterable<TreatmentData>.empty();
                                // return controller.treatmentSuggestions;
                              } else if (controller
                                      .treatmentNameEditValue.value ==
                                  textEditingValue.text) {
                                debugPrint("-=-=-empty-=");
                                return Iterable<TreatmentData>.empty();
                                // return controller.treatmentSuggestions;
                              }
                              return controller.treatmentSuggestions.where(
                                (option) {
                                  return option.treatment
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(
                                        textEditingValue.text.toLowerCase(),
                                      ); /*return option.treatment
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                        textEditingValue.text.toLowerCase(),
                                      );*/
                                },
                              );
                            },
                            onSelected: (
                              TreatmentData selection,
                            ) {
                              controller.treatmentSuggestionsData.value =
                                  selection;
                              controller.treatmentName.value.text =
                                  selection.treatment!;
                            },
                          ),
                  ),
                ),
                /*Expanded(
                  child: Container(
                      height: MySize.getHeight(70),
                      child: getTextField(
                          textEditingController: controller.treatmentName.value,
                          // textCapitalization: TextCapitalization.sentences,
                          focusNode: focus,
                          hintText: "Enter Treatment",
                          validation: (val) {
                            if (isNullEmptyOrFalse(val)) {
                              return "Enter name";
                            } else if (!RegExp(r"^[A-Za-z ]+$")
                            // } else if (!RegExp(r'^[\ a-zA-Z0-9]+$')
                                .hasMatch(val!.trim())) {
                              return "Please enter a valid name";
                            }
                            return null;
                          },
                          fillColor: Color(0xffEFEFF0))),
                ),*/
                Spacing.width(20),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                right: 20.0,
                bottom: 10.0,
                top: 4.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                        height: MySize.getHeight(70),
                        child: getTextField(
                            textEditingController:
                                controller.treatmentToothNumber.value,
                            // textInputType: TextInputType.numberWithOptions(),
                            // numberText2Formatter: true,
                            // maxLength: 2,
                            hintText: "Tooth Number",
                            readOnly: true,
                            onTap: () {
                              controller.toothNumberSelectTab.value = 0;
                              Get.bottomSheet(
                                SelectToothNumber(),
                              );
                            },
                            /*validation: (val) {
                              if (isNullEmptyOrFalse(val)) {
                                return "Enter Tooth Number";
                              }
                              */ /*else
                              if (val!.isNotEmpty &&
                                  !RegExp(r"11|12|13|14|15|16|17|18|21|22|23|24|25|26|27|28|31|32|33|34|35|36|37|38|41|42|43|44|45|46|47|48")
                                      .hasMatch(val)) {
                                return 'Enter Valid Tooth Number';
                              }*/ /*
                              return null;
                            },*/
                            fillColor: Color(0xffEFEFF0))),
                  ),
                  Spacing.width(10),
                  Expanded(
                    child: Container(
                        height: MySize.getHeight(70),
                        child: getTextField(
                            textEditingController:
                                controller.treatmentAmount.value,
                            textInputType: TextInputType.numberWithOptions(),
                            numberText6Formatter: true,
                            maxLength: 6,
                            hintText: "Amount",
                            validation: (val) {
                              if (isNullEmptyOrFalse(val)) {
                                return "Enter amount";
                              } else if (controller
                                          .treatmentAmount.value.text.length <
                                      2 ||
                                  controller.treatmentAmount.value.text.length >
                                      6) {
                                return "Wrong amount";
                              } else if (double.parse(controller
                                      .treatmentAmount.value.text
                                      .toString()) <
                                  50) {
                                return "Wrong amount";
                              }
                              return null;
                            },
                            fillColor: Color(0xffEFEFF0))),
                  ),
                ],
              ),
            ),
            // Spacing.height(10),
            Center(
              child: InkWell(
                onTap: () {
                  /*String abhi =
                      "11,12,13,14,15,16,17,18,21,22,23,24,25,26,27,28,31,32,33,34,35,36,37,38,41,42,43,44,45,46,47,48";

                  abhi.replaceAll(",", "|");

                  debugPrint("-=-${abhi.replaceAll(",", "|")}");*/

                  if (controller.addTreatmentFormKey.currentState!.validate()) {
                    if (controller.isEditTreatmentActive.isTrue) {
                      controller.callEditTreatmentApi(
                        context: context,
                        patientId: controller.patientId,
                        treatmentId: controller.treatmentId.value,
                      );
                    } else {
                      controller.callAddTreatmentApi(
                        context: context,
                        patientId: controller.patientId,
                      );
                    }
                  }
                },
                child: getButton(
                    title: controller.isEditTreatmentActive.isFalse
                        ? "Add Treatment"
                        : "Edit Treatment",
                    height: 43,
                    width: 162,
                    fontSize: 15,
                    borderRadius: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
