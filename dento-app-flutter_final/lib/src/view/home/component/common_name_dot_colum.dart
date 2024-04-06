import 'package:Dentosupport_mini/app/modules/individual_patient_screen/controllers/individual_patient_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../global/constants/api_constant.dart';
import '../../../../global/constants/app_color.dart';
import '../../../../global/constants/size_constant.dart';

Widget commonNameColum(
    {Color? dotColor,
    Color? nameColor,
    Color? clinicNameColor,
    bool isForComplete = false,
    String treatmentId = "",
    IndividualPatientScreenController? controller,
    String? amount,
    required String name,
    required String clinicName}) {
  return Row(
    children: [
      Row(children: [
        if (!isForComplete)
          Container(
            height: MySize.getHeight(10),
            width: MySize.getWidth(10),
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
        if (!isForComplete)
          SizedBox(
            width: MySize.getWidth(8),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MySize.getWidth(150),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      name,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: MySize.getHeight(16),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          color: nameColor),
                    ),
                  ),
                  Spacing.width(5),
                  if (!isForComplete)
                    InkWell(
                      onTap: () {
                        controller!.closeAllBottoms();
                        controller.treatmentId.value = treatmentId;
                        controller.treatmentName.value.text = name;
                        controller.treatmentNameEditValue.value = name;
                        controller.treatmentAmount.value.text = amount!;
                        controller.isAddTreatmentActive.value = true;
                        controller.isEditTreatmentActive.value = true;
                      },
                      child: Container(
                        height: MySize.getHeight(20),
                        width: MySize.getWidth(20),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          imageSvgPath + "edit_icon.svg",
                          height: MySize.getHeight(13),
                          width: MySize.getWidth(13),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Text(
              clinicName,
              style: TextStyle(
                  fontSize: MySize.getHeight(12),
                  fontWeight: FontWeight.w400,
                  color: clinicNameColor),
            )
          ],
        ),
      ])
    ],
  );
}
