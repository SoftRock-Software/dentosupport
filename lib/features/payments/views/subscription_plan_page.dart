import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SubscriptionPlanPage extends StatefulWidget {
  const SubscriptionPlanPage({super.key});

  @override
  State<SubscriptionPlanPage> createState() => _SubscriptionPlanPageState();
}

class _SubscriptionPlanPageState extends State<SubscriptionPlanPage> {
  var _yearly = true;

  final normalDecoration = BoxDecoration(
    color: const Color(0xFFF8F8F8),
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        offset: Offset(0, 5),
        blurRadius: 4,
        color: Color.fromRGBO(0, 0, 0, 0.15),
      ),
    ],
  );

  final selectedDecoration = BoxDecoration(
    color: AppColor.primaryColor,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 4,
        color: Color.fromRGBO(0, 0, 0, 0.15),
      ),
    ],
  );

  static const normalTitleStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColor.textColor,
  );

  static const normalSubtitleStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColor.primaryColor,
  );

  static const selectedTitleStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColor.backgroundColor,
  );

  static const selectedSubtitleStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColor.backgroundColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Subscription Plans'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
              },
              children: [
                const TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFD4D6DD)),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(''),
                    ),
                    Text(
                      'Free',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColor.captionColor,
                      ),
                    ),
                    Text(
                      'Pro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                ...subscriptions.map(
                  (e) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          e.title,
                          style: const TextStyle(
                            fontFamily: AppFont.inter,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColor.captionColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Icon(
                          e.free ? Icons.check : Icons.close,
                          color: e.free
                              ? AppColor.primaryColor
                              : AppColor.textColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Icon(
                          e.pro ? Icons.check : Icons.close,
                          color: e.free
                              ? AppColor.primaryColor
                              : AppColor.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 1,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD4D6DD)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _yearly = false;
                    });
                  },
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(20),
                    decoration:
                        !_yearly ? selectedDecoration : normalDecoration,
                    child: Column(
                      children: [
                        Text(
                          'Billed Monthly',
                          style:
                              !_yearly ? selectedTitleStyle : normalTitleStyle,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '₹ 749',
                          style: !_yearly
                              ? selectedSubtitleStyle
                              : normalSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    setState(() {
                      _yearly = true;
                    });
                  },
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(20),
                    decoration: _yearly ? selectedDecoration : normalDecoration,
                    child: Column(
                      children: [
                        Text(
                          'Billed Yearly',
                          style:
                              _yearly ? selectedTitleStyle : normalTitleStyle,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '₹ 7,999',
                          style: _yearly
                              ? selectedSubtitleStyle
                              : normalSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AppPrimaryButton(
                title: 'Pay ₹ ${_yearly ? '7,999' : '749'}',
                onPressed: () {},
              ),
            ),
            // const TestSuccessSheet(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Skip for now',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestSuccessSheet extends StatelessWidget {
  const TestSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showSuccessSheet(context),
      child: const Text(
        'Skip for now',
        style: TextStyle(
          fontFamily: AppFont.inter,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: AppColor.primaryColor,
        ),
      ),
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
                color: AppColor.primaryColor,
              ),
              const SizedBox(height: 20),
              const Text(
                'Successful',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Your pro plan is now active\n till January 07, 2024.',
                textAlign: TextAlign.center,
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
}

class Subscription {
  const Subscription({
    required this.title,
    required this.free,
    this.pro = true,
  });

  final String title;
  final bool free;
  final bool pro;
}

const subscriptions = [
  Subscription(title: 'Manage Patients', free: true),
  Subscription(title: 'Manage Payments', free: true),
  Subscription(title: 'Schedule Patients', free: false),
  Subscription(title: 'WhatsApp Reminders', free: false),
  Subscription(title: 'Multiple Clinics', free: false),
  Subscription(title: 'Treatment Insights', free: false),
  Subscription(title: 'Out Of Clinic Mode', free: false),
];
