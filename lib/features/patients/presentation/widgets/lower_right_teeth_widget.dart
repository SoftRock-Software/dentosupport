import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/teeth.dart';
import 'package:dento_support/features/patients/presentation/cubit/treatment_cubit.dart';
import 'package:dento_support/features/patients/presentation/views/choose_teeth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LowerRightTeethWidget extends StatefulWidget {
  const LowerRightTeethWidget({super.key, required this.controller});

  final ChooseTeethController controller;

  @override
  State<LowerRightTeethWidget> createState() => _LowerRightTeethWidgetState();
}

class _LowerRightTeethWidgetState extends State<LowerRightTeethWidget> {
  final teeth = [
    Teeth(1),
    Teeth(2),
    Teeth(3),
    Teeth(4),
    Teeth(5),
    Teeth(6),
    Teeth(7),
    Teeth(8),
  ];

  @override
  void initState() {
    super.initState();

    widget.controller.lowerLeftSelect = _selectAllTeeth;
  }

  void _selectTeeth(int index) {
    setState(() {
      teeth[index].selected = !teeth[index].selected;
    });

    if (teeth[index].selected) {
      context.read<TreatmentCubit>().lowerRightTeethNumber.add('4${index + 1}');
    } else {
      context
          .read<TreatmentCubit>()
          .lowerRightTeethNumber
          .remove('4${index + 1}');
    }
  }

  void _selectAllTeeth() {
    var allSelected = true;
    for (final element in teeth) {
      if (element.selected == false) {
        allSelected = false;
        break;
      }
    }

    if (allSelected) {
      setState(() {
        for (final element in teeth) {
          element.selected = false;
        }
      });
      context.read<TreatmentCubit>().lowerRightTeethNumber.clear();
    } else {
      setState(() {
        for (final element in teeth) {
          element.selected = true;
        }
      });

      context.read<TreatmentCubit>().lowerRightTeethNumber
        ..clear()
        ..addAll(['41', '42', '43', '44', '45', '46', '47', '48']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: 142,
        height: 182,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 2,
              child: InkWell(
                onTap: () => _selectTeeth(0),
                child: SizedBox(
                  width: 30,
                  height: 35,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-50-4.svg',
                        semanticsLabel: 'Vector-50-4',
                        color: teeth[0].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 12,
                        left: 10,
                        child: Text(
                          '1',
                          textAlign: TextAlign.left,
                          style: teeth[0].selected
                              ? AppFontStyle.toothSelectedStyle
                              : AppFontStyle.toothNormalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 82,
              child: InkWell(
                onTap: () => _selectTeeth(1),
                child: SizedBox(
                  width: 26,
                  height: 28,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-51-4.svg',
                        semanticsLabel: 'Vector-51-4',
                        color: teeth[1].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 8,
                        left: 10,
                        child: Text(
                          '2',
                          textAlign: TextAlign.left,
                          style: teeth[1].selected
                              ? AppFontStyle.toothSelectedStyle
                              : AppFontStyle.toothNormalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 60,
              child: InkWell(
                onTap: () => _selectTeeth(2),
                child: SizedBox(
                  width: 30,
                  height: 27,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-52-4.svg',
                        semanticsLabel: 'Vector-52-4',
                        color: teeth[2].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 5,
                        left: 11,
                        child: Text(
                          '3',
                          textAlign: TextAlign.left,
                          style: teeth[2].selected
                              ? AppFontStyle.toothSelectedStyle
                              : AppFontStyle.toothNormalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 31,
              left: 38,
              child: InkWell(
                onTap: () => _selectTeeth(3),
                child: SizedBox(
                  width: 36,
                  height: 27,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-53-4.svg',
                        semanticsLabel: 'Vector-53-4',
                        color: teeth[3].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 5,
                        left: 13,
                        child: Text(
                          '4',
                          textAlign: TextAlign.left,
                          style: teeth[3].selected
                              ? AppFontStyle.toothSelectedStyle
                              : AppFontStyle.toothNormalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 52,
              left: 20,
              child: InkWell(
                onTap: () => _selectTeeth(4),
                child: SizedBox(
                  width: 39,
                  height: 24,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-54-4.svg',
                        semanticsLabel: 'Vector-54-4',
                        color: teeth[4].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 5,
                        left: 15,
                        child: Text(
                          '5',
                          textAlign: TextAlign.left,
                          style: teeth[4].selected
                              ? AppFontStyle.toothSelectedStyle
                              : AppFontStyle.toothNormalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 74,
              left: 6,
              child: InkWell(
                onTap: () => _selectTeeth(5),
                child: SizedBox(
                  width: 38,
                  height: 33,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-55-4.svg',
                        semanticsLabel: 'Vector-55-4',
                        color: teeth[5].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 8,
                        left: 14,
                        child: Text(
                          '6',
                          textAlign: TextAlign.left,
                          style: teeth[5].selected
                              ? AppFontStyle.toothSelectedStyle
                              : AppFontStyle.toothNormalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 110,
              left: 1,
              child: InkWell(
                onTap: () => _selectTeeth(6),
                child: SizedBox(
                  width: 39,
                  height: 30,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-56-4.svg',
                        semanticsLabel: 'Vector-56-4',
                        color: teeth[6].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 6,
                        left: 15,
                        child: Text(
                          '7',
                          textAlign: TextAlign.left,
                          style: teeth[6].selected
                              ? AppFontStyle.toothSelectedStyle
                              : AppFontStyle.toothNormalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 0,
              child: InkWell(
                onTap: () => _selectTeeth(7),
                child: SizedBox(
                  width: 45,
                  height: 35,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-57-4.svg',
                        semanticsLabel: 'Vector-57-4',
                        color: teeth[7].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 6,
                        left: 16,
                        child: Text(
                          '8',
                          textAlign: TextAlign.left,
                          style: teeth[7].selected
                              ? AppFontStyle.toothSelectedStyle
                              : AppFontStyle.toothNormalStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
