import 'package:dento_support/features/payments/widgets/transaction_item_widet.dart';
import 'package:flutter/material.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) => const TransactionItemWidget(),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
