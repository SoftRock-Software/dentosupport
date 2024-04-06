import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/patients/models/transaction.dart';
import 'package:dento_support/features/patients/presentation/widgets/empty_patient_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({
    super.key,
    required this.transactions,
  });

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height / 8,
                left: 0,
                right: 0,
                child: const EmptyPatientWidget(),
              ),
            ],
          )
        : GroupedListView<Transaction, DateTime>(
            elements: transactions,
            groupBy: (element) => DateTime(
              element.createdAt.year,
              element.createdAt.month,
              element.createdAt.day,
            ),
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item2.createdAt.compareTo(item1.createdAt),
            padding: const EdgeInsets.only(bottom: 40),
            reverse: true,
            groupSeparatorBuilder: (DateTime value) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFDCDCDC),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        DateFormatUtils.format(value),
                        style: const TextStyle(
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColor.captionColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFDCDCDC),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemBuilder: (_, element) {
              final color = element.type.toLowerCase() == 'online'
                  ? AppColor.primaryColor
                  : Colors.black;

              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: const Color.fromRGBO(198, 198, 198, 0.5),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('hh:mm a')
                                    .format(element.createdAt.toLocal()),
                                style: const TextStyle(
                                  fontFamily: AppFont.inter,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Color(0xFF8C8C8C),
                                ),
                              ),
                              Text(
                                element.type.toLowerCase() == 'online'
                                    ? 'Paid Online'
                                    : 'Paid Cash',
                                style: TextStyle(
                                  fontFamily: AppFont.inter,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: color,
                                ),
                              ),
                              Text(
                                '₹ ${element.amount}',
                                style: TextStyle(
                                  fontFamily: AppFont.inter,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28,
                                  color: color,
                                  letterSpacing: -0.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: element.processedToothNumber
                                .map(
                                  (e) => Container(
                                    padding: const EdgeInsets.all(4),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE9F3FE),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      '${e.treatment} ${e.toothString}',
                                      style: const TextStyle(
                                        fontFamily: AppFont.inter,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            element.notes.isEmpty ? 'No Notes' : element.notes,
                            style: const TextStyle(
                              fontFamily: AppFont.inter,
                              color: Color(0xFF787878),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.navigate_next,
                            color: Color(0xFF787878),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
