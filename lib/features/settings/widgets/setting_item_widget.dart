import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({
    super.key,
    required this.title,
    this.color,
    this.onTap,
  });

  final String title;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          onTap: onTap,
          title: Text(
            title,
            style: TextStyle(
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: color ?? AppColor.captionColor,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12,
            color: color ?? const Color(0xFF8F9098),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            color: Color(0xFFD4D6DD),
          ),
        ),
      ],
    );
  }
}
