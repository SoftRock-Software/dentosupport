import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/presentation/cubit/medical_cubit.dart';
import 'package:dento_support/features/patients/presentation/widgets/patient_scafold.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalHistoryPage extends StatelessWidget {
  const MedicalHistoryPage({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return PatientScaffold(
      patient: patient,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 33),
        child: BlocListener<MedicalCubit, MedicalState>(
          listener: (context, state) {
            if (state.status.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            }

            if (state.status.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          child: BlocBuilder<MedicalCubit, MedicalState>(
            builder: (context, state) {
              final patientMedicalHistories = state.medicalHistories
                  .where((element) => element.selected)
                  .toList();

              final medicalHistories = state.medicalHistories
                  .where((element) => !element.selected)
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 33, bottom: 8),
                    child: Text(
                      'Medical History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: AppColor.textColor,
                      ),
                    ),
                  ),
                  if (patientMedicalHistories.isNotEmpty)
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 99 / 103,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 15,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      shrinkWrap: true,
                      itemCount: patientMedicalHistories.length,
                      itemBuilder: (context, index) {
                        final medicalHistory = patientMedicalHistories[index];

                        return Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              margin: const EdgeInsets.only(top: 8, right: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 4,
                                  )
                                ],
                                border: Border.all(
                                  color: const Color.fromRGBO(
                                    198,
                                    198,
                                    198,
                                    0.5,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  medicalHistory.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFont.inter,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: medicalHistory.selected
                                        ? AppColor.textColor
                                        : AppColor.hintColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -2,
                              top: -2,
                              child: IconButton(
                                onPressed: () {
                                  if (medicalHistory.selected) {
                                    context
                                        .read<MedicalCubit>()
                                        .removeMedicalHistory(
                                          medicalHistory.id,
                                        );
                                  } else {
                                    context.read<MedicalCubit>()
                                      ..onMedicalTitleChanged(
                                        medicalHistory.title,
                                      )
                                      ..addMedicalHistory();
                                  }
                                },
                                padding: EdgeInsets.zero,
                                iconSize: 28,
                                constraints: const BoxConstraints(),
                                icon: medicalHistory.selected
                                    ? const Icon(
                                        Icons.remove_circle,
                                        color: AppColor.red,
                                      )
                                    : const Icon(
                                        Icons.add_circle,
                                        color: AppColor.primaryColor,
                                      ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  if (patientMedicalHistories.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 10),
                      child: Divider(color: Color(0xFF898A8D), thickness: 1),
                    ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 99 / 103,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 15,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    shrinkWrap: true,
                    itemCount: medicalHistories.length,
                    itemBuilder: (context, index) {
                      final medicalHistory = medicalHistories[index];

                      if (medicalHistory.id == -1) {
                        return Container(
                          margin: const EdgeInsets.only(top: 8, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(15),
                            color: const Color.fromRGBO(0, 65, 157, 0.3),
                            dashPattern: const [7, 3],
                            padding: EdgeInsets.zero,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  final bloc = context.read<MedicalCubit>()
                                    ..onMedicalTitleChanged('');

                                  addMedicalHistory(context, bloc);

                                  // Navigator.push<bool>(
                                  //   context,
                                  //   _createRoute(context),
                                  // );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      size: 38,
                                      color: AppColor.primaryColor,
                                    ),
                                    Text(
                                      medicalHistory.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: AppFont.inter,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              margin: const EdgeInsets.only(top: 8, right: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 4,
                                  )
                                ],
                                border: Border.all(
                                  color: const Color.fromRGBO(
                                    198,
                                    198,
                                    198,
                                    0.5,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  medicalHistory.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppFont.inter,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: medicalHistory.selected
                                        ? AppColor.textColor
                                        : AppColor.hintColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -2,
                              top: -2,
                              child: IconButton(
                                onPressed: () {
                                  if (medicalHistory.selected) {
                                    context
                                        .read<MedicalCubit>()
                                        .removeMedicalHistory(
                                          medicalHistory.id,
                                        );
                                  } else {
                                    context.read<MedicalCubit>()
                                      ..onMedicalTitleChanged(
                                        medicalHistory.title,
                                      )
                                      ..addMedicalHistory();
                                  }
                                },
                                padding: EdgeInsets.zero,
                                iconSize: 28,
                                constraints: const BoxConstraints(),
                                icon: medicalHistory.selected
                                    ? const Icon(
                                        Icons.remove_circle,
                                        color: AppColor.red,
                                      )
                                    : const Icon(
                                        Icons.add_circle,
                                        color: AppColor.primaryColor,
                                      ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> addMedicalHistory(BuildContext context, MedicalCubit bloc) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: 30,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocBuilder<MedicalCubit, MedicalState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Add Medical History',
                          style: TextStyle(
                            fontFamily: AppFont.inter,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColor.textColor,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Enter medical history',
                      hintStyle: AppFontStyle.hintStyle,
                    ),
                    textCapitalization: TextCapitalization.words,
                    style: AppFontStyle.textStyle,
                    autofocus: true,
                    onChanged: (title) => bloc.onMedicalTitleChanged(title),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AppPrimaryButton(
                    title: 'Save',
                    onPressed: state.medicalTitle.isEmpty
                        ? null
                        : () async {
                            await bloc.addMedicalHistory();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
                          },
                  ),
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ),
    );
  }
}
