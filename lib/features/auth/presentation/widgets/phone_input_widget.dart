import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputWidget extends StatelessWidget {
  const PhoneInputWidget({
    super.key,
    required this.onChanged,
  });

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 40,
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              readOnly: true,
              style: AppFontStyle.style2,
              decoration: InputDecoration(
                hintText: '+91',
                hintStyle: AppFontStyle.style2,
                helperText: ' ',
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 4,
            child: TextFormField(
              style: AppFontStyle.style2,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              decoration: const InputDecoration(
                hintText: 'Phone number',
                hintStyle: AppFontStyle.hintStyle,
                counterText: '',
                helperText: ' ',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a valid phone number';
                } else if (value.length != 10) {
                  return 'Mobile number should be valid 10 digits';
                } else {
                  return null;
                }
              },
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
