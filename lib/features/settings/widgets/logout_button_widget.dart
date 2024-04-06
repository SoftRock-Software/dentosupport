import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/main.dart';
import 'package:flutter/material.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({
    super.key,
    required void Function()? onPressed,
  }) : _onPressed = onPressed;

  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(top: 25),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.102),
                    blurRadius: 8,
                    offset: Offset(0, -3),
                  )
                ],
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 34),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'At your service, '),
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'dento',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: 'support',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          TextSpan(text: ' team.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'App Version $versionName',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 9,
                      color: AppColor.textColor,
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FloatingActionButton.extended(
              elevation: 4,
              backgroundColor: AppColor.red,
              extendedPadding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              label: const Text(
                'LOGOUT',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              onPressed: _onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
