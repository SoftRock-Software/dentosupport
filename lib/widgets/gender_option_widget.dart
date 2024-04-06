import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class GenderOptionWidget extends StatefulWidget {
  const GenderOptionWidget({
    super.key,
    this.onChanged,
    this.value = 'M',
  });

  final String value;
  final void Function(Gender?)? onChanged;

  @override
  State<GenderOptionWidget> createState() => _GenderOptionWidgetState();
}

class _GenderOptionWidgetState extends State<GenderOptionWidget> {
  late Gender _selected;

  @override
  void initState() {
    _selected = widget.value.gender;
    super.initState();
  }

  void _onGenderChanged(Gender? value) {
    if (value == null) return;
    widget.onChanged?.call(value);

    setState(() {
      _selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<Gender>(
            value: Gender.male,
            groupValue: _selected,
            onChanged: _onGenderChanged,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            title: Text(
              Gender.male.title,
              style: AppFontStyle.textStyle,
            ),
          ),
        ),
        Expanded(
          child: RadioListTile<Gender>(
            value: Gender.female,
            groupValue: _selected,
            onChanged: _onGenderChanged,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            title: Text(
              Gender.female.title,
              style: AppFontStyle.textStyle,
            ),
          ),
        ),
        Expanded(
          child: RadioListTile<Gender>(
            value: Gender.other,
            groupValue: _selected,
            onChanged: _onGenderChanged,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            title: Text(
              Gender.other.title,
              style: AppFontStyle.textStyle,
            ),
          ),
        ),
      ],
    );
  }
}

enum Gender { male, female, other }

extension GenderExtension on Gender {
  String get title {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }

  String get value {
    switch (this) {
      case Gender.male:
        return 'M';
      case Gender.female:
        return 'F';
      case Gender.other:
        return 'O';
    }
  }
}

extension _StringExtension on String {
  Gender get gender {
    switch (this) {
      case 'M':
        return Gender.male;
      case 'F':
        return Gender.female;
      default:
        return Gender.other;
    }
  }
}
