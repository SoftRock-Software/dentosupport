import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../global/constants/app_color.dart';
import '../../../../../global/constants/size_constant.dart';
import '../../../../../global/utils/my_text_field.dart';
import '../../../../../global/utils/uitilities.dart';
import '../../../individual_patient_screen/controllers/individual_patient_screen_controller.dart';
import '../../controllers/add_patient_and_home_screen_controller.dart';

class HomeAddNewPatientBottom extends StatefulWidget {
  AddPatientAndHomeScreenController? addPatientAndHomeScreenController =
      AddPatientAndHomeScreenController();
  bool isEdit = false;
  IndividualPatientScreenController? individualPatientScreenController =
      IndividualPatientScreenController();

  HomeAddNewPatientBottom(
      {this.addPatientAndHomeScreenController,
      this.individualPatientScreenController,
      this.isEdit = false});

  @override
  _HomeAddNewPatientBottomState createState() =>
      _HomeAddNewPatientBottomState();
}

class _HomeAddNewPatientBottomState extends State<HomeAddNewPatientBottom> {
  AddPatientAndHomeScreenController controller =
      AddPatientAndHomeScreenController();
  IndividualPatientScreenController editController =
      IndividualPatientScreenController();
  bool isEdit = false;

  @override
  void initState() {
    isEdit = widget.isEdit;
    if (isEdit) {
      editController = widget.individualPatientScreenController!;
      editController.patientNameController.value.text =
          editController.patientName;
      editController.patientAgeController.value.text =
          editController.patientAge;
      editController.patientNumberController.value.text =
          editController.patientNumber;
      editController.selectedGenderType.value = editController.patientGender;
      controller.selectedGender.value = editController.patientGender;
      controller.addPatientNameOnChange.value = editController.patientName;
      controller.addPatientPhoneNumberOnChange.value =
          editController.patientNumber;
    } else {
      controller = widget.addPatientAndHomeScreenController!;
      // controller.nameController.value.clear();
      controller.ageController.value.clear();
      // controller.mobileNumberController.value.clear();
      controller.selectedGender.value = "M";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: MySize.getHeight(10)),
        child: Obx(
          () => Form(
            key: (isEdit)
                ? editController.editPatientFormKey
                : controller.addPatientFormKey,
            child: Column(
              children: [
                Container(
                  height: 2,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColor.grayLine.withOpacity(0.5),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding:
                                    EdgeInsets.only(left: MySize.getWidth(25)),
                                child: InkWell(
                                  onTap: () {
                                    controller.searchController.value.clear();
                                    controller.searchPatientsOnChange.value =
                                        "";
                                    controller.isSearchStarted.value = false;
                                    if (isEdit) {
                                      editController.isEditPatientActive.value =
                                          false;
                                    } else {
                                      controller.isAddPatientActive.value =
                                          false;
                                    }
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColor.blue,
                                  ),
                                )),
                          )),
                      Text(
                        (isEdit) ? "Edit Patient" : "Add New Patient",
                        style: TextStyle(
                          fontSize: MySize.getHeight(18),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MySize.getHeight(22)),
                Padding(
                  padding: EdgeInsets.only(left: MySize.getWidth(18)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MySize.getWidth(242),
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            debugPrint("-=-=-hasFocus=-=-$hasFocus");
                            controller.addPatientNameOnFocus.value = hasFocus;
                            if (hasFocus) {
                              // do stuff
                            }
                          },
                          child: getTextField(
                              textEditingController: (isEdit)
                                  ? editController.patientNameController.value
                                  : controller.nameController.value,
                              fillColor: AppColor.textFieldColor,
                              hintText: "Name",
                              autoFocus: controller.addSearchPatient.value == ""
                                  ? true
                                  : controller.addSearchPatient.value == "Name"
                                      ? true
                                      : false,
                              // textCapitalization: TextCapitalization.sentences,
                              // numberText32TextFormatter: true,
                              onChange: (value) {
                                controller.addPatientNameOnChange.value = value;

                                // if (value.length > 3) {
                                  // SearchList Open
                                  if (!isNullEmptyOrFalse(value.trim())) {
                                    controller.isSearchStarted.value = true;
                                    controller.searchPatientApi(
                                        context: context, text: value);
                                  } else {
                                    controller.isSearchStarted.value = false;
                                  }
                                // }
                              },
                              validation: (val) {
                                if (isNullEmptyOrFalse(val)) {
                                  return "Please enter name";
                                } /*else if (!RegExp(r"^[A-Za-z ]+$")
                                    // else if (!RegExp(r'^[\ a-zA-Z0-9]+$')
                                    .hasMatch(val!.trim())) {
                                  return "Please enter a valid name";
                                }*/
                                return null;
                              },
                              suffixIcon: controller.addPatientNameOnChange
                                          .value.isEmpty ||
                                      controller.addPatientNameOnFocus.value ==
                                          false
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        if (isEdit) {
                                          editController
                                              .patientNameController.value
                                              .clear();
                                        } else {
                                          controller.nameController.value
                                              .clear();
                                        }
                                        controller
                                            .addPatientNameOnChange.value = "";
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: MySize.getHeight(25),
                                        width: MySize.getHeight(25),
                                        child: SvgPicture.asset(
                                            imageSvgPath +
                                                "cancel_button_pic.svg",
                                            height: MySize.getHeight(25),
                                            width: MySize.getHeight(25)),
                                      ),
                                    )
                              // : SizedBox(),
                              ),
                        ),
                      ),
                      Spacing.width(12),
                      Container(
                        width: MySize.getWidth(86),
                        child: getTextField(
                          textEditingController: (isEdit)
                              ? editController.patientAgeController.value
                              : controller.ageController.value,
                          textInputType: TextInputType.number,
                          fillColor: AppColor.textFieldColor,
                          numberText3Formatter: true,
                          hintText: "Age",
                          maxLength: 3,
                          validation: (val) {
                            debugPrint(
                                "-=-=-=-=${controller.ageController.value.text}");
                            if (isNullEmptyOrFalse(val)) {
                              return "Enter age";
                            } else if (!RegExp(r'^[0-9]+$')
                                .hasMatch(val!.trim())) {
                              return "Please enter a valid number";
                            } else if (isEdit) {
                              if (int.parse(editController
                                          .patientAgeController.value.text
                                          .toString()) <
                                      2 ||
                                  int.parse(editController
                                          .patientAgeController.value.text
                                          .toString()) >
                                      110) {
                                return "Wrong age";
                              }
                            } else if (!isEdit) {
                              if (int.parse(controller.ageController.value.text
                                          .toString()) <
                                      2 ||
                                  int.parse(controller.ageController.value.text
                                          .toString()) >
                                      110) {
                                return "Wrong age";
                              }
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MySize.getWidth(18),
                    top: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MySize.getWidth(242),
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            debugPrint("-=-=-hasFocus=-=-$hasFocus");
                            controller.addPatientPhoneNumberOnFocus.value =
                                hasFocus;
                            if (hasFocus) {
                              // do stuff
                            }
                          },
                          child: getTextField(
                            textEditingController: (isEdit)
                                ? editController.patientNumberController.value
                                : controller.mobileNumberController.value,
                            fillColor: AppColor.textFieldColor,
                            hintText: "Enter Phone Number",
                            textInputType: TextInputType.number,
                            autoFocus:
                                controller.addSearchPatient.value == "Number"
                                    ? true
                                    : false,
                            // numberTextFormatter: true,
                            maxLength: 10,
                            /*onChange: (value) {
                              controller.addPatientPhoneNumberOnChange.value =
                                  value;
                            },*/
                            onChange: (value) {
                              controller.addPatientPhoneNumberOnChange.value =
                                  value;

                              // if (value.length > 3) {
                                // SearchList Open
                                if (!isNullEmptyOrFalse(value.trim())) {
                                  controller.isSearchStarted.value = true;
                                  controller.searchPatientApi(
                                      context: context, text: value);
                                } else {
                                  controller.isSearchStarted.value = false;
                                }
                              // }
                            },
                            // textInputFormatter: [maskFormatterForMobileNumber],
                            validation: (val) {
                              if (isNullEmptyOrFalse(val!.trim())) {
                                return "Please enter phone number";
                              } else if (val.length != 10) {
                                return 'Mobile Number must be of 10 digit';
                              } else if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                                return "Please enter a valid number";
                              } else {
                                return null;
                              }
                              return null;
                            },
                            suffixIcon: controller.addPatientPhoneNumberOnChange
                                        .value.isEmpty ||
                                    controller.addPatientPhoneNumberOnFocus
                                            .value ==
                                        false
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      if (isEdit) {
                                        editController
                                            .patientNumberController.value
                                            .clear();
                                      } else {
                                        controller.mobileNumberController.value
                                            .clear();
                                      }
                                      controller.addPatientPhoneNumberOnChange
                                          .value = "";
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: MySize.getHeight(25),
                                      width: MySize.getHeight(25),
                                      child: SvgPicture.asset(
                                        imageSvgPath + "cancel_button_pic.svg",
                                        height: MySize.getHeight(25),
                                        width: MySize.getHeight(25),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Spacing.width(13),
                      Container(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 4,
                          right: 4,
                        ),
                        // height: MySize.getHeight(43),
                        // width: MySize.getWidth(87),
                        decoration: BoxDecoration(
                          color: AppColor.textFieldColor,
                          borderRadius: BorderRadius.circular(
                            MySize.getHeight(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            genderView(gender: "Male", genderCode: "M"),
                            Container(
                              height: 10,
                              width: 1,
                              color: AppColor.greyLight,
                            ),
                            genderView(gender: "Female", genderCode: "F"),
                            Container(
                              height: 10,
                              width: 1,
                              color: AppColor.greyLight,
                            ),
                            genderView(gender: "Other", genderCode: "O"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.height(16),
                InkWell(
                  onTap: () {
                    print(box.read(ArgumentConstant.token));

                    debugPrint("-=-=1-=--edit");
                    if (isEdit) {
                      debugPrint("-=-=2-=--edit");
                      if (editController.editPatientFormKey.currentState!
                          .validate()) {
                        debugPrint("-=-=3-=--edit");
                        editController.callEditPatientApi(
                          context: context,
                          patientId: editController.patientId,
                          gender: controller.selectedGender.value,
                        );
                        controller.isSearchStarted.value = false;
                        controller.searchController.value.clear();
                        controller.searchPatientsOnChange.value = "";
                      }
                    } else {
                      if (controller.addPatientFormKey.currentState!
                          .validate()) {
                        controller.callAddPatientApi(context: context);
                        controller.isSearchStarted.value = false;
                        controller.searchController.value.clear();
                        controller.searchPatientsOnChange.value = "";
                      }
                    }
                  },
                  child: getButton(
                      height: 43,
                      width: 162,
                      color: Colors.white,
                      borderRadius: 25,
                      fontSize: 14,
                      title: (isEdit) ? "Save" : 'Add New Patient'),
                ),
                SizedBox(
                  height: MySize.getHeight(10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  genderView({
    required String gender,
    required String genderCode,
  }) {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.selectedGender.value = genderCode;
        },
        child: Container(
          height: MySize.getHeight(31),
          width: MySize.getWidth(27),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.selectedGender.value == genderCode
                ? AppColor.blue
                : AppColor.transparent,
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: Text(
            "$genderCode",
            style: TextStyle(
              color: (controller.selectedGender.value != genderCode)
                  ? Colors.grey
                  : AppColor.white,
              fontSize: MySize.getHeight(12),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    });
  }
}
