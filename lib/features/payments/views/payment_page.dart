import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/payments/widgets/active_plan_widget.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Subscriptions'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Active plan',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF1A202C),
                ),
              ),
            ),
            ActivePlanWidget(),
            // noActivePlan(
            //   onPressed: () => context.push(AppPage.subscriptionPlan.toPath),
            // ),
            SizedBox(height: 35),
            Divider(),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Transaction history',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF1A202C),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(16),
            //   child: TransactionListView(),
            // ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 130),
                child: Text(
                  'No previous transaction history',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF7B7B7B),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget noActivePlan({required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'No Active Plan',
            style: TextStyle(
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF1A202C),
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
        ],
      ),
    );
  }
}
