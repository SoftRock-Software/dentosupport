import 'package:flutter/material.dart';
import '../../../../../global/constants/api_constant.dart';
import '../../../../../global/constants/app_color.dart';
import '../../../../../global/constants/size_constant.dart';
import '../../../../../global/utils/my_text_field.dart';
import '../../../../../global/utils/uitilities.dart';
import '../../controllers/individual_patient_screen_controller.dart';

class BottomWidgetForAddNewProcedure extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();
  String treatmentId = "";

  BottomWidgetForAddNewProcedure(
      {required this.individualPatientScreenController,
      required this.treatmentId});

  @override
  _BottomWidgetForAddNewProcedureState createState() =>
      _BottomWidgetForAddNewProcedureState();
}

class _BottomWidgetForAddNewProcedureState
    extends State<BottomWidgetForAddNewProcedure> {
  IndividualPatientScreenController controller =
      IndividualPatientScreenController();

  @override
  void initState() {
    controller = widget.individualPatientScreenController;
    controller.procedureName.value.clear();
    print(widget.treatmentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addProcedureFormKey,
      child: Container(
        height: MySize.getHeight(170),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacing.width(10),
                InkWell(
                    onTap: () {
                      controller.isAddProcedureActive.value = false;
                      controller.isAddTreatmentActive.value = false;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: MySize.getHeight(10)),
                      child: Icon(Icons.arrow_back_ios,
                          size: MySize.getHeight(25), color: AppColor.blue),
                    )),
                Spacing.width(5),
                Container(
                    width: MySize.getWidth(315),
                    height: MySize.getHeight(70),
                    child: getTextField(
                        textEditingController: controller.procedureName.value,
                        // textCapitalization: TextCapitalization.sentences,
                        autoFocus: true,
                        hintText: "Enter Procedure",
                        validation: (val) {
                          if (isNullEmptyOrFalse(val)) {
                            return "Enter name";
                          } else if (!RegExp(r"^[A-Za-z ]+$")
                              .hasMatch(val!.trim())) {
                            // } else if (!RegExp(r'^[\ a-zA-Z0-9]+$').hasMatch(val!)) {
                            return "Please enter a valid name";
                          }
                          return null;
                        },
                        fillColor: Color(0xffEFEFF0))),
              ],
            ),
            Spacing.height(20),
            Center(
              child: InkWell(
                onTap: () {
                  if (controller.addProcedureFormKey.currentState!.validate()) {
                    controller.callAddProcedureApi(
                        context: context, treatmentId: widget.treatmentId);
                  }
                },
                child: getButton(
                    title: "Add Procedure",
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
