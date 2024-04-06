import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

class StatusInfoWidget extends StatelessWidget {
  const StatusInfoWidget({
    super.key,
    required this.cash,
    required this.total,
    required this.pending,
    required this.visited,
  });

  final String cash;
  final String total;
  final String pending;
  final String visited;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: defaultTargetPlatform == TargetPlatform.android ? 24 : 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$pending Pending',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.red,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$visited Visited',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Cash',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    cash,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Total',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  Text(
                    total,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
