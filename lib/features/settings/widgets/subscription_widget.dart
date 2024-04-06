import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppPage.subscriptionPlan.toPath),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEBF3FF),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            const Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Switch to ',
                        style: TextStyle(
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColor.primaryColor,
                          letterSpacing: 1,
                        ),
                      ),
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
                      TextSpan(
                        text: ' Pro',
                        style: TextStyle(
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColor.primaryColor,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: AppColor.textColor,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
