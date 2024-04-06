import 'package:Dentosupport_mini/app/modules/individual_patient_screen/controllers/individual_patient_screen_controller.dart';
import 'package:Dentosupport_mini/app/modules/individual_patient_screen/views/treatment_list_widget.dart';
import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/global/models/tratment_data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../global/constants/app_color.dart';
import '../../../../src/view/home/component/common_name_dot_colum.dart';

class ActiveTreatmentWidget extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();

  ActiveTreatmentWidget({required this.individualPatientScreenController});

  @override
  _ActiveTreatmentWidgetState createState() => _ActiveTreatmentWidgetState();
}

class _ActiveTreatmentWidgetState extends State<ActiveTreatmentWidget> {
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
      margin: EdgeInsets.only(
          // top: MySize.getHeight(27),
          left: MySize.getWidth(24),
          right: MySize.getWidth(24)),
      padding: EdgeInsets.only(
        top: 14,
        // left: 12,
        // right: 12,
        bottom: 1,
      ),
      /*padding: EdgeInsets.symmetric(
          horizontal: MySize.getWidth(12), vertical: MySize.getHeight(14)),*/
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: MySize.getHeight(1),
                spreadRadius: MySize.getHeight(1),
                offset: Offset(MySize.getHeight(1), MySize.getHeight(1)))
          ],
          color: AppColor.grayCardBackground,
          // color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(MySize.getHeight(10))),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Active Treatment",
                  style: TextStyle(
                      fontSize: MySize.getHeight(16),
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Spacer(),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.activeTreatmentList.length,
            padding: EdgeInsets.only(
                top: MySize.getHeight(10),
               ),
            itemBuilder: (BuildContext context, int index) {
              return TreatmentListWidget(
                individualPatientScreenController: controller,
                index: index,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox();
            },
          ),
          Spacing.height(0),
        ],
      ),
    );
  }
}
