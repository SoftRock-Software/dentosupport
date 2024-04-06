import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../global/constants/app_color.dart';
import '../../../../../global/constants/size_constant.dart';
import '../../../../../global/utils/uitilities.dart';
import '../../controllers/individual_patient_screen_controller.dart';

class BottomWidgetForAction extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();

  BottomWidgetForAction({required this.individualPatientScreenController});

  @override
  _BottomWidgetForActionState createState() => _BottomWidgetForActionState();
}

class _BottomWidgetForActionState extends State<BottomWidgetForAction> {
  IndividualPatientScreenController controller =
      IndividualPatientScreenController();

  @override
  void initState() {
    controller = widget.individualPatientScreenController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MySize.getHeight(120),
      // height: MySize.getHeight(175),
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: [
          /*InkWell(
            onTap: () {
              controller.isActionBottomActive.value = false;
              showConfirmationDialog(
                context: context,
                cancelText: "Cancel",
                submitText: "Terminate",
                cancelBackColor: Colors.transparent,
                submitBackColor: Colors.transparent,
                cancelTextColor: AppColor.blue,
                submitTextColor: Colors.red,
                cancelCallback: () {
                  Get.back();
                },
                submitCallBack: () {
                  Get.back();
                },
                contentWidget: Column(
                  children: [
                    Text(
                      "Terminate Patient",
                      style: TextStyle(
                        fontSize: MySize.getHeight(17),
                      ),
                    ),
                    Spacing.height(5),
                    Text(
                      "Patient not reporting",
                      style: TextStyle(
                        fontSize: MySize.getHeight(13),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              height: MySize.getHeight(57),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Terminate patient",
                    style: TextStyle(fontSize: MySize.getHeight(20)),
                  ),
                  Spacing.height(2),
                  Text(
                    "(Stop all treatments)",
                    style: TextStyle(fontSize: MySize.getHeight(12)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 0, child: Divider()),*/
          InkWell(
            onTap: () {
              controller.isActionBottomActive.value = false;
              showConfirmationDialog(
                context: context,
                cancelText: "Cancel",
                submitText: "Delete",
                cancelBackColor: AppColor.blue,
                submitBackColor: AppColor.blue,
                cancelTextColor: AppColor.white,
                submitTextColor: Colors.white,
                cancelCallback: () {
                  Get.back();
                },
                submitCallBack: () {
                  controller.callDeletePatientApi(
                      context: Get.context!, patientId: controller.patientId);
                },
                contentWidget: Column(
                  children: [
                    Text(
                      "Delete Patient",
                      style: TextStyle(
                        fontSize: MySize.getHeight(17),
                      ),
                    ),
                    Spacing.height(5),
                    Text(
                      "Are you sure?",
                      style: TextStyle(
                        fontSize: MySize.getHeight(13),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              height: MySize.getHeight(57),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Delete",
                    style: TextStyle(
                        fontSize: MySize.getHeight(20), color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 0, child: Divider()),
          InkWell(
            onTap: () {
              controller.isActionBottomActive.value = false;
              controller.isEditPatientActive.value = true;
            },
            child: Container(
              height: MySize.getHeight(57),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Edit",
                    style: TextStyle(fontSize: MySize.getHeight(20)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
