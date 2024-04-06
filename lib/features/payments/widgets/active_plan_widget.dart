import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/payments/widgets/transaction_item_widet.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActivePlanWidget extends StatelessWidget {
  const ActivePlanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TransactionItemWidget(
            onPressed: () => context.push(AppPage.subscriptionPlan.toPath),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: null,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Change Plan',
                  style: AppFontStyle.style4.copyWith(
                    color: const Color(0xFFDDDDDD),
                  ),
                ),
              ),
              TextButton(
                onPressed: null,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Cancel Subscription',
                  style: AppFontStyle.style4.copyWith(
                    color: const Color(0xFFDDDDDD),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showSuccessSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 4,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                height: 4,
                width: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFAAAAAA),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 60),
              const Icon(
                Icons.check_circle,
                size: 40,
                color: AppColor.red,
              ),
              const SizedBox(height: 20),
              const Text(
                'Subscription Cancelled',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: AppColor.red,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'We are sad to see you go!',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF1A202C),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showCancelSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 4,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                height: 4,
                width: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFAAAAAA),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Are you sure you want to cancel?',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColor.red,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'You will not be able to enjoy services anymore.',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Color(0xFF1A202C),
                ),
              ),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: AppPrimaryButton(
                  title: 'Yes, Cancel My Subscription',
                  onPressed: () => context.pop(),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: AppPrimaryButton(
                  title: 'Go Back',
                  onPressed: () => context.pop(),
                ),
              ),
              const SizedBox(height: 39),
            ],
          ),
        );
      },
    );
  }
}
