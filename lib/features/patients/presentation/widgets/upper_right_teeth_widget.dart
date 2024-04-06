import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/teeth.dart';
import 'package:dento_support/features/patients/presentation/cubit/treatment_cubit.dart';
import 'package:dento_support/features/patients/presentation/views/choose_teeth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpperRightTeethWidget extends StatefulWidget {
  const UpperRightTeethWidget({super.key, required this.controller});

  final ChooseTeethController controller;

  @override
  State<UpperRightTeethWidget> createState() => _UpperRightTeethWidgetState();
}

class _UpperRightTeethWidgetState extends State<UpperRightTeethWidget> {
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

    widget.controller.upperLeftSelect = _selectAllTeeth;
  }

  void _selectTeeth(int index) {
    setState(() {
      teeth[index].selected = !teeth[index].selected;
    });

    if (teeth[index].selected) {
      context.read<TreatmentCubit>().upperRightTeethNumber.add('1${index + 1}');
    } else {
      context
          .read<TreatmentCubit>()
          .upperRightTeethNumber
          .remove('1${index + 1}');
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
      context.read<TreatmentCubit>().upperRightTeethNumber.clear();
    } else {
      setState(() {
        for (final element in teeth) {
          element.selected = true;
        }
      });

      context.read<TreatmentCubit>().upperRightTeethNumber
        ..clear()
        ..addAll(['11', '12', '13', '14', '15', '16', '17', '18']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        width: 142,
        height: 182,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 112,
              child: InkWell(
                onTap: () => _selectTeeth(0),
                child: SizedBox(
                  width: 30,
                  height: 35,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-50.svg',
                        semanticsLabel: 'Vector-50',
                        color: teeth[0].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 6,
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
              top: 7,
              left: 85,
              child: InkWell(
                onTap: () => _selectTeeth(1),
                child: SizedBox(
                  width: 26,
                  height: 28,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-51-3.svg',
                        semanticsLabel: 'Vector-51-3',
                        color: teeth[1].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 4,
                        left: 6,
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
              top: 19,
              left: 60,
              child: InkWell(
                onTap: () => _selectTeeth(2),
                child: SizedBox(
                  width: 30,
                  height: 27,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-52-3.svg',
                        semanticsLabel: 'Vector-52-3',
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
              top: 39,
              left: 39,
              child: InkWell(
                onTap: () => _selectTeeth(3),
                child: SizedBox(
                  width: 36,
                  height: 27,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-53-3.svg',
                        semanticsLabel: 'Vector-53-3',
                        color: teeth[3].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 6,
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
              top: 61,
              left: 22,
              child: InkWell(
                onTap: () => _selectTeeth(4),
                child: SizedBox(
                  width: 38,
                  height: 24,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-54-3.svg',
                        semanticsLabel: 'Vector-54-3',
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
              top: 83,
              left: 11,
              child: InkWell(
                onTap: () => _selectTeeth(5),
                child: SizedBox(
                  width: 38,
                  height: 33,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-55-3.svg',
                        semanticsLabel: 'Vector-55-3',
                        color: teeth[5].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 9,
                        left: 15,
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
              top: 119,
              left: 5,
              child: InkWell(
                onTap: () => _selectTeeth(6),
                child: SizedBox(
                  width: 39,
                  height: 30,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-56-3.svg',
                        semanticsLabel: 'Vector-56-3',
                        color: teeth[6].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 7,
                        left: 16,
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
              top: 151,
              left: 5,
              child: InkWell(
                onTap: () => _selectTeeth(7),
                child: SizedBox(
                  width: 45,
                  height: 35,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector-57-3.svg',
                        semanticsLabel: 'Vector-57-3',
                        color: teeth[7].selected ? AppColor.primaryColor : null,
                      ),
                      Positioned(
                        top: 6,
                        left: 17,
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
