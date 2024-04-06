import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/teeth.dart';
import 'package:dento_support/features/patients/presentation/cubit/treatment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChildTeethWidget extends StatefulWidget {
  const ChildTeethWidget({super.key});

  @override
  State<ChildTeethWidget> createState() => _ChildTeethWidgetState();
}

class _ChildTeethWidgetState extends State<ChildTeethWidget> {
  static const textStyle = TextStyle(
    color: Color.fromRGBO(232, 67, 147, 1),
    fontFamily: 'Nunito Sans',
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );

  // 51-55(UR), 61-65(UL), 71-75(LL), 81-85(LR)
  final teeth = [
    Teeth(51),
    Teeth(52),
    Teeth(53),
    Teeth(54),
    Teeth(55),
    Teeth(61),
    Teeth(62),
    Teeth(63),
    Teeth(64),
    Teeth(65),
    Teeth(71),
    Teeth(72),
    Teeth(73),
    Teeth(74),
    Teeth(75),
    Teeth(81),
    Teeth(82),
    Teeth(83),
    Teeth(84),
    Teeth(85),
  ];

  void _selectTeeth(int teethNumber) {
    final index = teeth.indexWhere((element) => element.number == teethNumber);

    setState(() {
      teeth[index].selected = !teeth[index].selected;
    });

    if (teeth[index].selected) {
      context.read<TreatmentCubit>().childTeethNumber.add('$teethNumber');
    } else {
      context.read<TreatmentCubit>().childTeethNumber.remove('$teethNumber');
    }
  }

  bool _isTeethSelected(int teethNumber) {
    final index = teeth.indexWhere((element) => element.number == teethNumber);
    return teeth[index].selected;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 197.28167724609375,
      height: 233.25180053710938,
      child: Stack(
        children: [
          // Start - Upper left 61-65(UL)
          // 1
          Positioned(
            top: 0,
            left: 99,
            child: InkWell(
              onTap: () => _selectTeeth(61),
              child: SizedBox(
                width: 27,
                height: 31,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-50.svg',
                        semanticsLabel: 'child-vector-50',
                        color: _isTeethSelected(61)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 10,
                      child: Text(
                        '1',
                        textAlign: TextAlign.center,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(61)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 2
          Positioned(
            top: 11,
            left: 129,
            child: InkWell(
              onTap: () => _selectTeeth(62),
              child: SizedBox(
                width: 24.5,
                height: 25.5,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-51.svg',
                        semanticsLabel: 'child-vector-51',
                        color: _isTeethSelected(62)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 6,
                      child: Text(
                        '2',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(62)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 3
          Positioned(
            top: 27,
            left: 146,
            child: InkWell(
              onTap: () => _selectTeeth(63),
              child: SizedBox(
                width: 27,
                height: 25,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-52.svg',
                        semanticsLabel: 'child-vector-52',
                        color: _isTeethSelected(63)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 11,
                      child: Text(
                        '3',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(63)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 4
          Positioned(
            top: 50,
            left: 156,
            child: InkWell(
              onTap: () => _selectTeeth(64),
              child: SizedBox(
                width: 35,
                height: 30,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-55.svg',
                        semanticsLabel: 'child-vector-55',
                        color: _isTeethSelected(64)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 14,
                      child: Text(
                        '4',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(64)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 5
          Positioned(
            top: 82,
            left: 160,
            child: InkWell(
              onTap: () => _selectTeeth(65),
              child: SizedBox(
                width: 36,
                height: 28,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-56.svg',
                        semanticsLabel: 'child-vector-56',
                        color: _isTeethSelected(65)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 15,
                      child: Text(
                        '5',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(65)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // End - Upper left

          // Start - Upper right 51-55(UR)
          // 1
          Positioned(
            top: 0,
            left: 69,
            child: InkWell(
              onTap: () => _selectTeeth(51),
              child: SizedBox(
                width: 27,
                height: 31,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-50-2.svg',
                        semanticsLabel: 'child-vector-50-2',
                        color: _isTeethSelected(51)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 10,
                      child: Text(
                        '1',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(51)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 2
          Positioned(
            top: 10.5,
            left: 44.5,
            child: InkWell(
              onTap: () => _selectTeeth(52),
              child: SizedBox(
                width: 24.5,
                height: 25.5,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-51-2.svg',
                        semanticsLabel: 'child-vector-51-2',
                        color: _isTeethSelected(52)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 10,
                      child: Text(
                        '2',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(52)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 3
          Positioned(
            top: 27,
            left: 20,
            child: InkWell(
              onTap: () => _selectTeeth(53),
              child: SizedBox(
                width: 27,
                height: 25,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-52-2.svg',
                        semanticsLabel: 'child-vector-52-2',
                        color: _isTeethSelected(53)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 4.8,
                      left: 10.25,
                      child: Text(
                        '3',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(53)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 4
          Positioned(
            top: 50,
            left: 7,
            child: InkWell(
              onTap: () => _selectTeeth(54),
              child: SizedBox(
                width: 35,
                height: 30,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-55-2.svg',
                        semanticsLabel: 'child-vector-55-2',
                        color: _isTeethSelected(54)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 14,
                      child: Text(
                        '4',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(54)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 5
          Positioned(
            top: 82,
            left: 6,
            child: InkWell(
              onTap: () => _selectTeeth(55),
              child: SizedBox(
                width: 36,
                height: 28,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-56-2.svg',
                        semanticsLabel: 'child-vector-56-2',
                        color: _isTeethSelected(55)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 15,
                      child: Text(
                        '5',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(55)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // End - Upper right

          // Start - Lower right 81-85(LR)
          // 1
          Positioned(
            bottom: 0,
            left: 72,
            child: InkWell(
              onTap: () => _selectTeeth(81),
              child: SizedBox(
                width: 27,
                height: 31,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-50-3.svg',
                        semanticsLabel: 'child-vector-50-3',
                        color: _isTeethSelected(81)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 10,
                      child: Text(
                        '1',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(81)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 2
          Positioned(
            bottom: 5,
            left: 44,
            child: InkWell(
              onTap: () => _selectTeeth(82),
              child: SizedBox(
                width: 24.5,
                height: 26,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-51-3.svg',
                        semanticsLabel: 'child-vector-51-3',
                        color: _isTeethSelected(82)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 11,
                      child: Text(
                        '2',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(82)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 3
          Positioned(
            top: 190,
            left: 23,
            child: InkWell(
              onTap: () => _selectTeeth(83),
              child: SizedBox(
                width: 27,
                height: 25,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-52-3.svg',
                        semanticsLabel: 'child-vector-52-3',
                        color: _isTeethSelected(83)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 10.25,
                      child: Text(
                        '3',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(83)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 4
          Positioned(
            top: 160,
            left: 7,
            child: InkWell(
              onTap: () => _selectTeeth(84),
              child: SizedBox(
                width: 35,
                height: 30,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-55-3.svg',
                        semanticsLabel: 'child-vector-55-3',
                        color: _isTeethSelected(84)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 14,
                      child: Text(
                        '4',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(84)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 5
          Positioned(
            top: 130,
            left: 6,
            child: InkWell(
              onTap: () => _selectTeeth(85),
              child: SizedBox(
                width: 36,
                height: 28,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-56-3.svg',
                        semanticsLabel: 'child-vector-56-3',
                        color: _isTeethSelected(85)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 15,
                      child: Text(
                        '5',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(85)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // End - Lower right

          // Start - Lower left 71-75(LL)
          // 1
          Positioned(
            bottom: 0,
            left: 102,
            child: InkWell(
              onTap: () => _selectTeeth(71),
              child: SizedBox(
                width: 27,
                height: 31,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-58.svg',
                        semanticsLabel: 'child-vector-58',
                        color: _isTeethSelected(71)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        '1',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(71)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 2
          Positioned(
            bottom: 5,
            right: 40,
            child: InkWell(
              onTap: () => _selectTeeth(72),
              child: SizedBox(
                width: 24.5,
                height: 25.5,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-59.svg',
                        semanticsLabel: 'child-vector-59',
                        color: _isTeethSelected(72)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 6.5,
                      child: Text(
                        '2',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(72)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 3
          Positioned(
            top: 190,
            right: 20,
            child: InkWell(
              onTap: () => _selectTeeth(73),
              child: SizedBox(
                width: 27,
                height: 25,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-60.svg',
                        semanticsLabel: 'child-vector-60',
                        color: _isTeethSelected(73)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 10.25,
                      child: Text(
                        '3',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(73)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 4
          Positioned(
            top: 160,
            left: 156,
            child: InkWell(
              onTap: () => _selectTeeth(74),
              child: SizedBox(
                width: 35,
                height: 30,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-61.svg',
                        semanticsLabel: 'child-vector-61',
                        color: _isTeethSelected(74)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 14,
                      child: Text(
                        '4',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(74)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 5
          Positioned(
            top: 130,
            left: 158,
            child: InkWell(
              onTap: () => _selectTeeth(75),
              child: SizedBox(
                width: 36,
                height: 28,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/child-vector-57.svg',
                        semanticsLabel: 'child-vector-57',
                        color: _isTeethSelected(75)
                            ? AppColor.childToothColor
                            : null,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 15,
                      child: Text(
                        '5',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                          color: _isTeethSelected(75)
                              ? Colors.white
                              : AppColor.childToothColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // End - Lower left
        ],
      ),
    );
  }
}
