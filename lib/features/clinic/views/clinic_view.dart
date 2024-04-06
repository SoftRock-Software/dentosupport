import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClinicView extends StatelessWidget {
  const ClinicView({
    super.key,
    required this.nameController,
    required this.mobileController,
    required this.locationController,
    this.onChanged,
    this.selectedItems = const [],
  });

  final TextEditingController nameController;
  final TextEditingController mobileController;
  final TextEditingController locationController;
  final ValueChanged<List<String>>? onChanged;
  final List<String> selectedItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[A-Za-z 0-9]'))
          ],
          decoration: const InputDecoration(
            hintText: 'Clinic Name',
            hintStyle: AppFontStyle.hintStyle,
          ),
          style: AppFontStyle.textStyle,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a clinic name';
            }
            return null;
          },
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const Expanded(
              child: TextField(
                readOnly: true,
                style: AppFontStyle.style2,
                decoration: InputDecoration(
                  hintText: '+91',
                  hintStyle: AppFontStyle.style2,
                  helperText: ' ',
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: mobileController,
                style: AppFontStyle.style2,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: AppFontStyle.hintStyle,
                  counterText: '',
                  helperText: ' ',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid phone number';
                  } else if (value.length != 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        TextFormField(
          controller: locationController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: 'Clinic Location',
            hintStyle: AppFontStyle.hintStyle,
          ),
          style: AppFontStyle.textStyle,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a clinic location';
            }
            return null;
          },
        ),
        const SizedBox(height: 50),
        ClinicOffDaySelection(
          onChanged: onChanged,
          selectedItems: selectedItems,
        ),
      ],
    );
  }
}

class ClinicOffDaySelection extends StatefulWidget {
  const ClinicOffDaySelection({
    super.key,
    this.onChanged,
    this.selectedItems = const [],
  });

  final List<String> selectedItems;
  final ValueChanged<List<String>>? onChanged;

  @override
  State<ClinicOffDaySelection> createState() => _ClinicOffDaySelectionState();
}

class _ClinicOffDaySelectionState extends State<ClinicOffDaySelection> {
  final days = [
    TestDays(initial: 'M', name: 'Monday'),
    TestDays(initial: 'T', name: 'Tuesday'),
    TestDays(initial: 'W', name: 'Wednesday'),
    TestDays(initial: 'T', name: 'Thursday'),
    TestDays(initial: 'F', name: 'Friday'),
    TestDays(initial: 'S', name: 'Saturday'),
    TestDays(initial: 'S', name: 'Sunday'),
  ];
  final localSelectedItems = <String>[];

  @override
  void initState() {
    for (final element in days) {
      if (widget.selectedItems.contains(element.name)) {
        element.selected = true;
        localSelectedItems.add(element.name);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Clinic’s Day Off',
          style: AppFontStyle.textStyle,
        ),
        const SizedBox(height: 13),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: days.map(_buildChip).toList(),
        ),
      ],
    );
  }

  Widget _buildChip(TestDays e) {
    return InkWell(
      onTap:
          localSelectedItems.length == 6 && !localSelectedItems.contains(e.name)
              ? null
              : () {
                  final index =
                      days.indexWhere((element) => element.name == e.name);

                  setState(() {
                    if (days[index].selected) {
                      days[index].selected = false;
                      localSelectedItems.remove(e.name);
                    } else {
                      days[index].selected = true;
                      localSelectedItems.add(e.name);
                    }
                  });

                  widget.onChanged?.call(localSelectedItems);
                },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: e.selected ? AppColor.primaryColor : const Color(0xFFDEDEDE),
          borderRadius: const BorderRadius.all(Radius.circular(18)),
        ),
        child: Center(
          child: Text(
            e.initial,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFont.inter,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: e.selected ? AppColor.backgroundColor : AppColor.textColor,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class TestDays {
  TestDays({required this.initial, required this.name, this.selected = false});

  String initial;
  String name;
  bool selected;
}
