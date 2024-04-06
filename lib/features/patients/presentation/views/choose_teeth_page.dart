import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/presentation/widgets/child_teeth_widget.dart';
import 'package:dento_support/features/patients/presentation/widgets/lower_left_teeth_widget.dart';
import 'package:dento_support/features/patients/presentation/widgets/lower_right_teeth_widget.dart';
import 'package:dento_support/features/patients/presentation/widgets/upper_left_teeth_widget.dart';
import 'package:dento_support/features/patients/presentation/widgets/upper_right_teeth_widget.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ChooseTeethController {
  void Function()? upperLeftSelect;
  void Function()? upperRightSelect;
  void Function()? lowerLeftSelect;
  void Function()? lowerRightSelect;
}

class ChooseTeethView extends StatelessWidget {
  ChooseTeethView({
    required this.patientAge,
    this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;
  final int patientAge;

  static const decoration = BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
    color: Color.fromRGBO(247, 247, 247, 1),
  );

  final controller = ChooseTeethController();

  @override
  Widget build(BuildContext context) {
    final showChild = patientAge < 18;
    final showAdult = patientAge > 5;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Container(
            width: 341,
            height: 427,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              border: Border.all(
                color: const Color.fromRGBO(
                  221,
                  221,
                  221,
                  1,
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: SizedBox(
                    width: 341,
                    height: 427,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: SizedBox(
                            width: 341,
                            height: 427,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 25,
                                  left: 22,
                                  child: SizedBox(
                                    width: 290,
                                    height: 386,
                                    child: Stack(
                                      children: [
                                        if (showChild)
                                          const Positioned(
                                            top: 80,
                                            left: 45,
                                            child: ChildTeethWidget(),
                                          ),
                                        if (showAdult)
                                          UpperLeftTeethWidget(
                                            controller: controller,
                                          ),
                                        if (showAdult)
                                          UpperRightTeethWidget(
                                            controller: controller,
                                          ),
                                        if (showAdult)
                                          LowerRightTeethWidget(
                                            controller: controller,
                                          ),
                                        if (showAdult)
                                          LowerLeftTeethWidget(
                                            controller: controller,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (showAdult)
                  Positioned(
                    top: 66,
                    left: 141,
                    child: InkWell(
                      onTap: () {
                        controller.upperLeftSelect?.call();
                        controller.upperRightSelect?.call();
                      },
                      child: SizedBox(
                        width: 58,
                        height: 27,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 58,
                                height: 27,
                                decoration: decoration,
                              ),
                            ),
                            const Positioned(
                              top: 6,
                              left: 11,
                              child: Text(
                                'Upper',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (showAdult)
                  Positioned(
                    top: 345,
                    left: 141,
                    child: InkWell(
                      onTap: () {
                        controller.lowerLeftSelect?.call();
                        controller.lowerRightSelect?.call();
                      },
                      child: SizedBox(
                        width: 58,
                        height: 27,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 58,
                                height: 27,
                                decoration: decoration,
                              ),
                            ),
                            const Positioned(
                              top: 6,
                              left: 11,
                              child: Text(
                                'Lower',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const QuadrantWidget(name: 'Upper Right', top: 18, left: 11),
                const QuadrantWidget(name: 'Upper Left', top: 18, right: 22),
                const QuadrantWidget(name: 'Lower Right', bottom: 16, left: 11),
                const QuadrantWidget(name: 'Lower Left', bottom: 16, right: 22),
                const Align(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Choose tooth to proceed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w600,
                        fontSize: 8,
                        color: Color(0xFFB1B1B1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: AppPrimaryButton(
              title: 'Next',
              onPressed: onPressed,
            ),
          )
        ],
      ),
    );
  }
}

/// Display Quardrant Name
class QuadrantWidget extends StatelessWidget {
  const QuadrantWidget({
    super.key,
    required this.name,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  final String name;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: AppFont.inter,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Color(0xFF1E4BE8),
        ),
      ),
    );
  }
}
