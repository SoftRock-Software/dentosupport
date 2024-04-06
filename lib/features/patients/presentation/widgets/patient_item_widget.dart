import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:flutter/material.dart';

class PatientItemWidget extends StatelessWidget {
  const PatientItemWidget(this.patient, {super.key, this.isVisited = false});

  final Patient patient;
  final bool isVisited;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.name,
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: isVisited ? AppColor.textColor : AppColor.red,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                patient.lastTreatmentName ?? 'No Active Treatment',
                style: patient.lastTreatmentName == null
                    ? const TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColor.primaryColor,
                        letterSpacing: 0.8,
                      )
                    : const TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColor.hintColor,
                        letterSpacing: 0.8,
                      ),
              ),
            ],
          ),
          const Spacer(),
          if (patient.transactions.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Balance',
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                    color: Color(0xFF555555),
                  ),
                ),
                Text(
                  patient.remainBill.toString(),
                  style: const TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColor.red,
                    // color: Color(0xFF555555),
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Paid ${patient.lastPaymentType}',
                  style: const TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  patient.lastPaymentAmount.toString(),
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: patient.lastPaymentType.toLowerCase() == 'online'
                        ? AppColor.primaryColor
                        : const Color(0xFF101623),
                  ),
                ),
              ],
            ),
          const SizedBox(width: 6),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12,
            color: Color(0xFF8F9098),
          ),
        ],
      ),
    );
  }
}
