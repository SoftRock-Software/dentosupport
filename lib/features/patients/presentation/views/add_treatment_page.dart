import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/presentation/cubit/treatment_cubit.dart';
import 'package:dento_support/features/patients/presentation/views/choose_teeth_page.dart';
import 'package:dento_support/features/patients/presentation/views/choose_treatment_page.dart';
import 'package:dento_support/features/patients/presentation/views/treatment_cost_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTreatmentPage extends StatefulWidget {
  const AddTreatmentPage({super.key, required this.patientAge});

  final int patientAge;

  @override
  State<AddTreatmentPage> createState() => _AddTreatmentPageState();
}

class _AddTreatmentPageState extends State<AddTreatmentPage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TreatmentCubit, TreatmentState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          FocusScope.of(context).unfocus();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );

          Navigator.pop(context, true);
        }

        if (state.status.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: BlocBuilder<TreatmentCubit, TreatmentState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.title,
                style: const TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColor.textColor,
                ),
              ),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                )
              ],
            ),
            body: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ChooseTreatmentView(
                  onPressed: () {
                    if (context
                        .read<TreatmentCubit>()
                        .treatmentName()
                        .isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please Select a Treatment'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }
                    context
                        .read<TreatmentCubit>()
                        .updateAppTitle('Choose Teeth');
                    _controller.animateToPage(
                      1,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                ChooseTeethView(
                  patientAge: widget.patientAge,
                  onPressed: () {
                    context.read<TreatmentCubit>().teethNumber
                      ..clear()
                      ..addAll(
                        context.read<TreatmentCubit>().upperLeftTeethNumber,
                      )
                      ..addAll(
                        context.read<TreatmentCubit>().upperRightTeethNumber,
                      )
                      ..addAll(
                        context.read<TreatmentCubit>().lowerLeftTeethNumber,
                      )
                      ..addAll(
                        context.read<TreatmentCubit>().lowerRightTeethNumber,
                      )
                      ..addAll(
                        context.read<TreatmentCubit>().childTeethNumber,
                      );
                    if (context.read<TreatmentCubit>().teethNumber.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please select a tooth/teeth to proceed'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }

                    context
                        .read<TreatmentCubit>()
                        .updateAppTitle('Treatment Cost');
                    _controller.animateToPage(
                      2,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                TreatmentCostView(
                  onPressed: () async {
                    await context.read<TreatmentCubit>().addTreatment();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
