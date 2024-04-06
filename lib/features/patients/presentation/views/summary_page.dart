import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/models/treatment.dart';
import 'package:dento_support/features/patients/presentation/cubit/medical_cubit.dart';
import 'package:dento_support/features/patients/presentation/views/medical_history_page.dart';
import 'package:dento_support/features/patients/presentation/widgets/empty_patient_widget.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:dento_support/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({
    super.key,
    required this.treatmets,
    required this.patient,
  });

  final List<Treatment> treatmets;
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return treatmets.isEmpty
        ? Stack(
            children: [
              _buildPreviousMedicalHistory(
                context,
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) =>
                            MedicalCubit(patientRepository: getIt()),
                        child: MedicalHistoryPage(patient: patient),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 8,
                left: 0,
                right: 0,
                child: const EmptyPatientWidget(),
              ),
            ],
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                _buildPreviousMedicalHistory(
                  context,
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) =>
                              MedicalCubit(patientRepository: getIt()),
                          child: MedicalHistoryPage(patient: patient),
                        ),
                      ),
                    );
                  },
                ),
                GroupedListView<Treatment, String>(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  elements: treatmets,
                  groupBy: (element) => element.status,
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item2.createdAt.compareTo(item1.createdAt),
                  // useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      child: Text(
                        value == 'Done'
                            ? 'Completed treatments'
                            : 'Active Treatments',
                        style: const TextStyle(
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColor.captionColor,
                        ),
                      ),
                    );
                  },
                  itemBuilder: (_, element) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        color: element.status == 'Done'
                            ? const Color(0xFFF5F5F5)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(
                          color: const Color.fromRGBO(198, 198, 198, 0.5),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 7,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${element.name} ${element.tooths}',
                              style: const TextStyle(
                                fontFamily: AppFont.inter,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColor.captionColor,
                              ),
                            ),
                          ),
                          Text(
                            '₹ ${element.amount}',
                            style: const TextStyle(
                              fontFamily: AppFont.inter,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: AppColor.captionColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }

  Widget _buildPreviousMedicalHistory(
    BuildContext context, {
    required void Function()? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: getIt<PatientRepository>().medicalHistories,
            builder: (_, __) {
              return Flexible(
                child: Text(
                  getIt<PatientRepository>().medicalHistoryLength == 0
                      ? 'No previous medical history.'
                      : getIt<PatientRepository>().medicalHistoriesString,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF979797),
                  ),
                ),
              );
            },
          ),
          IconButton(
            onPressed: onPressed,
            padding: const EdgeInsets.only(left: 8),
            iconSize: 14,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.edit,
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
