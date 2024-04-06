import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/next_schedule.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/models/treatment.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/presentation/cubit/payment_cubit.dart';
import 'package:dento_support/features/patients/presentation/views/calendar_list_view.dart';
import 'package:dento_support/features/patients/presentation/widgets/patient_scafold.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:dento_support/widgets/schedule_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddPaymentPage extends StatelessWidget {
  const AddPaymentPage({
    super.key,
    required this.patient,
    required this.pendingPayment,
    this.nextSchedule,
  });

  final Patient patient;
  final NextSchedule? nextSchedule;
  final int pendingPayment;

  static const hintStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w500,
    fontSize: 55,
    color: Color(0xFF969696),
    letterSpacing: 1,
  );

  static const style = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w500,
    fontSize: 55,
    color: AppColor.textColor,
  );

  String dateFormatter(DateTime? dateTime) {
    if (dateTime != null) {
      final dateFormat = DateFormat('dd MMMM, yyyy');
      return 'Scheduled on ${dateFormat.format(dateTime)}';
    } else {
      return 'No visit scheduled';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PatientScaffold(
      patient: patient,
      body: BlocListener<PaymentCubit, PaymentState>(
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
            // context.read<PatientListBloc>()
            //   ..add(const PatientsFetched())
            //   ..add(const UpdateVisitorCount());
            // Navigator.of(context).popUntil((route) => route.isFirst);
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
        child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  const Text(
                    'Choose Teeth',
                    style: TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColor.textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 30,
                    ),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: _teethSelection(state, context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Add your notes (Optional)',
                        hintStyle: AppFontStyle.hintStyle,
                      ),
                      textCapitalization: TextCapitalization.words,
                      style: AppFontStyle.textStyle,
                      onChanged: context.read<PaymentCubit>().onNotesChanged,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 1,
                    color: const Color(0xFFDCDCDC),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Enter today's payment",
                    style: TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColor.textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: '₹ 0',
                        hintStyle: hintStyle,
                        counterText: '',
                      ),
                      maxLength: 6,
                      textCapitalization: TextCapitalization.words,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: style,
                      onChanged: context.read<PaymentCubit>().onAmountChanged,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Balance : ₹ $pendingPayment',
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: AppColor.red,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: PaymentType.online,
                        groupValue: state.type,
                        onChanged: (value) => context
                            .read<PaymentCubit>()
                            .changePaymentType(PaymentType.online),
                      ),
                      const Text(
                        'Online',
                        style: AppFontStyle.style6,
                      ),
                      const SizedBox(width: 20),
                      Radio(
                        value: PaymentType.cash,
                        groupValue: state.type,
                        onChanged: (value) => context
                            .read<PaymentCubit>()
                            .changePaymentType(PaymentType.cash),
                      ),
                      const Text(
                        'Cash',
                        style: AppFontStyle.style6,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 1,
                    color: const Color(0xFFDCDCDC),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: state.marked,
                        onChanged: (value) => context
                            .read<PaymentCubit>()
                            .markComplete(value: value),
                      ),
                      const Text(
                        'Mark as Completed',
                        style: AppFontStyle.style6,
                      ),
                    ],
                  ),
                  if (!state.marked)
                    Column(
                      children: [
                        const Text(
                          'Schedule Patient for next visit',
                          style: TextStyle(
                            fontFamily: AppFont.inter,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColor.textColor,
                          ),
                        ),
                        const SizedBox(height: 25),
                        CalendarListView(
                          state.dates,
                          onDateSelect: (date) {
                            FocusScope.of(context).unfocus();

                            if (date.dayOff) {
                              showScheduleSheet(
                                context,
                                onSchedule: () async {
                                  context
                                      .read<PaymentCubit>()
                                      .onDateSelect(date);

                                  await _handleSave(
                                    state,
                                    context,
                                    visitorDate: date,
                                  );
                                },
                              );
                            } else {
                              context.read<PaymentCubit>().onDateSelect(date);
                            }
                          },
                        ),
                        Text(
                          dateFormatter(nextSchedule?.date),
                          style: const TextStyle(
                            fontFamily: AppFont.inter,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: AppPrimaryButton(
                      title: 'Save',
                      onPressed: () async {
                        await _handleSave(state, context);
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleSave(
    PaymentState state,
    BuildContext context, {
    VisitorCalendar? visitorDate,
  }) async {
    if (state.selectedTeeth.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Please select a tooth/teeth to proceed'),
            duration: Duration(seconds: 1),
          ),
        );

      return;
    }

    if (!state.marked && visitorDate == null) {
      if (state.dates.where((element) => element.selected).toList().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select date'),
            duration: Duration(seconds: 1),
          ),
        );
        return;
      }
    }

    if (state.amount > pendingPayment || state.amount > 1000000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid amount'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    debugPrint('Success');

    await context.read<PaymentCubit>().addPayment(visitorDate);
  }

  List<InkWell> _teethSelection(PaymentState state, BuildContext context) {
    final results = <InkWell>[];

    final toothList = getToothList(state.onProcessTeeth);

    for (final teethNumber in toothList) {
      final contained = state.selectedTeeth.contains(teethNumber);

      // Handle minor & major tooth
      var child = false;
      final toothNumber = int.tryParse(teethNumber);
      if (toothNumber != null && toothNumber > 50) {
        child = true;
      }

      results.add(
        InkWell(
          onTap: () => context.read<PaymentCubit>().selectTeeth(teethNumber),
          child: _buildChip(
            teethNumber,
            border: contained
                ? Border.all(
                    color: child
                        ? AppColor.childToothColor
                        : AppColor.primaryColor,
                  )
                : null,
            color: contained
                ? child
                    ? AppColor.childToothColor
                    : AppColor.primaryColor
                : const Color(0xFF1F2024),
          ),
        ),
      );
    }

    return results;
  }

  Container _buildChip(String number, {BoxBorder? border, Color? color}) {
    return Container(
      width: int.tryParse(number) == null ? 65 : 40,
      height: 31,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(17)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.09),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
        border: border,
      ),
      child: Center(
        child: Text(
          number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: color,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
