import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'DentoSupport Pro (Trial)',
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF1F2024),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Expires on January 07, 2024',
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Color(0xFF7B7B7B),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'View Plans',
              style: AppFontStyle.style4,
            ),
          ),
          // const Text(
          //   '₹ 749',
          //   style: TextStyle(
          //     fontFamily: AppFont.inter,
          //     fontWeight: FontWeight.w600,
          //     fontSize: 16,
          //     color: Color(0xFF1F2024),
          //   ),
          // ),
        ],
      ),
    );
  }
}
