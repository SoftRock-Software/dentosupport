import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/teeth.dart';
import 'package:dento_support/features/patients/presentation/cubit/treatment_cubit.dart';
import 'package:dento_support/features/patients/presentation/views/choose_teeth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LowerLeftTeethWidget extends StatefulWidget {
  const LowerLeftTeethWidget({super.key, required this.controller});

  final ChooseTeethController controller;

  @override
  State<LowerLeftTeethWidget> createState() => _LowerLeftTeethWidgetState();
}

class _LowerLeftTeethWidgetState extends State<LowerLeftTeethWidget> {
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

    widget.controller.lowerRightSelect = _selectAllTeeth;
  }

  void _selectTeeth(int index) {
    setState(() {
      teeth[index].selected = !teeth[index].selected;
    });

    if (teeth[index].selected) {
      context.read<TreatmentCubit>().lowerLeftTeethNumber.add('3${index + 1}');
    } else {
      context
          .read<TreatmentCubit>()
          .lowerLeftTeethNumber
          .remove('3${index + 1}');
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
      context.read<TreatmentCubit>().lowerLeftTeethNumber.clear();
    } else {
      setState(() {
        for (final element in teeth) {
          element.selected = true;
        }
      });

      context.read<TreatmentCubit>().lowerLeftTeethNumber
        ..clear()
        ..addAll(['31', '32', '33', '34', '35', '36', '37', '38']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SizedBox(
        width: 142,
        height: 182,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 2,
              child: InkWell(
                onTap: () => _selectTeeth(0),
                child: SizedBox(
                  width: 30,
                  height: 35,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-50-3.svg',
                        semanticsLabel: 'Vector-50-3',
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
              right: 82,
              child: InkWell(
                onTap: () => _selectTeeth(1),
                child: SizedBox(
                  width: 26,
                  height: 28,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-51-2.svg',
                        semanticsLabel: 'Vector-51-2',
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
              right: 60,
              child: InkWell(
                onTap: () => _selectTeeth(2),
                child: SizedBox(
                  width: 30,
                  height: 27,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-52-2.svg',
                        semanticsLabel: 'Vector-52-2',
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
              right: 38,
              child: InkWell(
                onTap: () => _selectTeeth(3),
                child: SizedBox(
                  width: 36,
                  height: 26,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-53-2.svg',
                        semanticsLabel: 'Vector-53-2',
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
              right: 20,
              child: InkWell(
                onTap: () => _selectTeeth(4),
                child: SizedBox(
                  width: 39,
                  height: 24,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-54-2.svg',
                        semanticsLabel: 'Vector-54-2',
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
              right: 6,
              child: SizedBox(
                width: 38,
                height: 33,
                child: InkWell(
                  onTap: () => _selectTeeth(5),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-55-2.svg',
                        semanticsLabel: 'Vector-55-2',
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
              right: 1,
              child: InkWell(
                onTap: () => _selectTeeth(6),
                child: SizedBox(
                  width: 39,
                  height: 30,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-56-2.svg',
                        semanticsLabel: 'Vector-56-2',
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
              right: 0,
              child: InkWell(
                onTap: () => _selectTeeth(7),
                child: SizedBox(
                  width: 45,
                  height: 35,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-57-2.svg',
                        semanticsLabel: 'Vector-57-2',
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
