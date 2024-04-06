import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/widgets/app_button.dart';
import 'package:Dentosupport_mini/src/view/editclinics/controller/edit_clinic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/app_string.dart';
import '../../../../global/widgets/text_field.dart';

class EditClinicScreen extends StatelessWidget {
  EditClinicScreen({Key? key}) : super(key: key);
  EditClinicController editClinicController = Get.put(EditClinicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.blue,
            )),
        centerTitle: true,
        title: Text(
          "Edit Clinics",
          style: TextStyle(
              color: AppColor.blue, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(1, 1))
                  ]),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Clinic Details",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.blackText),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Please enter your clinic details",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.greyText),
                    ),
                    commonTextField(
                      hintText: AppString.enterClinicName,
                      labelText: AppString.enterClinicName,
                      isActive: editClinicController.isActiveClinicName.value,
                      onPressed: () {
                        editClinicController.isActiveClinicName.value = true;
                      },
                      controller: editClinicController.clinicName,
                      hintTextBold: true,
                      titleTextBold: true,
                      needValidation: true,
                      validationMessage: "Clinic Name",
                      maxLength: 22,
                    ),
                    commonTextField(
                      hintText: AppString.clinicPhoneName,
                      labelText: AppString.clinicPhoneName,
                      isActive: editClinicController.isActivePhoneName.value,
                      onPressed: () {
                        editClinicController.isActivePhoneName.value = true;
                      },
                      controller: editClinicController.clinicPhoneNumber,
                      hintTextBold: true,
                      titleTextBold: true,
                      needValidation: true,
                      isPhoneValidation: true,
                      showNumber: true,
                      validationMessage: "Clinic Phone",
                    ),
                    commonTextField(
                      hintText: AppString.locationOfTheClinic,
                      labelText: AppString.locationOfTheClinic,
                      isActive: editClinicController.isActiveLocation.value,
                      onPressed: () {
                        editClinicController.isActiveLocation.value = true;
                      },
                      controller: editClinicController.clinicLocation,
                      hintTextBold: true,
                      titleTextBold: true,
                      needValidation: true,
                      validationMessage: "Location",
                    ),
                    daySelectView(),
                    Center(
                      child: Text(
                        "Add New Clinic",
                        style: TextStyle(
                            color: AppColor.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        AppButton(onPressed: () {}, text: "Save"),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding daySelectView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
        bottom: 58.0,
      ),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: AppColor.blackText,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 16.0,
              ),
              contentPadding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              filled: true,
              fillColor: AppColor.whiteBackground,
              label: Container(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                    color:
                        editClinicController.isActiveClinicsOff.value == true ||
                                editClinicController.daySelect.value != ""
                            ? AppColor.white
                            : AppColor.transparent,
                    borderRadius: BorderRadius.circular(100)),
                child: const Text(
                  AppString.clinicsDayOff,
                  style: TextStyle(
                    color: AppColor.greyText,
                    /*  backgroundColor:
                        isActive == true ? AppColor.red : AppColor.transparent,*/
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
              // hintText: 'Please select expense',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                borderSide: const BorderSide(
                  color: AppColor.whiteBackground,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.whiteBackground,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.whiteBackground,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            isEmpty: editClinicController.daySelect.value == '',
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: editClinicController.daySelect.value == ""
                      ? null
                      : editClinicController.daySelect.value,
                  isDense: true,
                  onTap: () {
                    editClinicController.isActiveClinicsOff.value = true;
                  },
                  onChanged: (String? newValue) {
                    editClinicController.daySelect.value = newValue.toString();
                    state.didChange(newValue);
                    /*setState(() {
                                      _currentSelectedValue = newValue;
                                      state.didChange(newValue);
                                    });*/
                  },
                  items: editClinicController.offDays.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: AppColor.greyText,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
