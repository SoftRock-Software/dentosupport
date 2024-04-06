import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinInputWidget extends StatelessWidget {
  const PinInputWidget({
    super.key,
    required String mobile,
    required TextEditingController controller,
    required void Function()? onResendPressed,
    required void Function()? onMobilePressed,
    required void Function(String)? onCompleted,
  })  : _mobile = mobile,
        _controller = controller,
        _onPressed = onResendPressed,
        _onMobilePressed = onMobilePressed,
        _onCompleted = onCompleted;

  final String _mobile;
  final void Function()? _onPressed;
  final void Function()? _onMobilePressed;
  final void Function(String)? _onCompleted;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 40,
      ),
      child: Column(
        children: [
          Pinput(
            controller: _controller,
            defaultPinTheme: const PinTheme(
              width: 56,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 5),
              textStyle: TextStyle(),
              decoration: BoxDecoration(),
            ),
            preFilledWidget: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 56,
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Color(0xFF969696),
                  ),
                ),
              ],
            ),
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 56,
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Color(0xFF969696),
                  ),
                ),
              ],
            ),
            androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsUserConsentApi,
            onCompleted: _onCompleted,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Code sent to ',
                style: AppFontStyle.style3,
              ),
              TextButton(
                onPressed: _onMobilePressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  '+91 $_mobile',
                  style: AppFontStyle.style4,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Didn't recieve code? ",
                style: AppFontStyle.style3,
              ),
              TextButton(
                onPressed: _onPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Resend',
                  style: AppFontStyle.style4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
