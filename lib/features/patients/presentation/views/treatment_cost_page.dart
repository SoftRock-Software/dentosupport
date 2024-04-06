import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/presentation/cubit/treatment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreatmentCostView extends StatelessWidget {
  const TreatmentCostView({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          TextField(
            textAlign: TextAlign.center,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '₹ 0',
              hintStyle: hintStyle,
              counterText: '',
            ),
            maxLength: 6,
            textCapitalization: TextCapitalization.words,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: style,
            onChanged: context.read<TreatmentCubit>().onTreatmentCostChanged,
          ),
          const SizedBox(height: 50),
          BlocBuilder<TreatmentCubit, TreatmentState>(
            builder: (context, state) {
              return SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      state.tratmentCost > 0 && state.tratmentCost < 1000000
                          ? () {
                              onPressed?.call();
                            }
                          : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return AppColor.primaryColor;
                        } else if (states.contains(MaterialState.disabled)) {
                          return const Color(0xFF00419D).withOpacity(0.25);
                        }
                        return AppColor.primaryColor;
                      },
                    ),
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '''
Add Rx ${context.read<TreatmentCubit>().treatmentName()} ${context.read<TreatmentCubit>().teethNumberString}''',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColor.backgroundColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
