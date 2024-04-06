import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class SearchItemWidget extends StatelessWidget {
  const SearchItemWidget({
    super.key,
    required this.name,
    required this.mobile,
    this.onSchedule,
    this.fromSearch = false,
  });

  final String name;
  final String mobile;
  final VoidCallback? onSchedule;
  final bool fromSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: fromSearch ? AppColor.textColor : AppColor.red,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                mobile,
                style: const TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF898A8D),
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: onSchedule,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF3FF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Schedule',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
