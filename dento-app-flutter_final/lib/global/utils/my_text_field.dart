import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/api_constant.dart';

/*class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(
        newValue.text,
      ),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}*/

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalizeAllWordsInFullSentence(newValue.text),
      // text: capitalizeAllWordsInFullSentence(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalizeAllWordsInFullSentence(String str) {
  int i;
  String constructedString = "";
  for (i = 0; i < str.length; i++) {
    if (i == 0) {
      constructedString += str[0].toUpperCase();
    } else if (str[i - 1] == ' ') {
      // mandatory to have index>1 !
      constructedString += str[i].toUpperCase();
    } else {
      constructedString += str[i];
    }
  }
  // print('constructed: $constructedString');
  return constructedString;
}

TextFormField getTextField({
  String? hintText,
  TextEditingController? textEditingController,
  Widget? prefixIcon,
  double? borderRadius,
  Widget? suffixIcon,
  double? size = 52,
  Widget? suffix,
  Color borderColor = Colors.transparent,
  Color fillColor = Colors.white,
  TextInputType textInputType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  bool textVisible = false,
  bool readOnly = false,
  VoidCallback? onTap,
  int maxLine = 1,
  int? maxLength = 32,
  String errorText = "",
  String prefixText = "",
  bool autoFocus = false,
  FocusNode? focusNode,
  Function(String)? onChange,
  FormFieldValidator<String>? validation,
  TextCapitalization textCapitalization = TextCapitalization.words,
  List<TextInputFormatter>? textInputFormatter,
  bool upperCaseTextFormatter = true,
  bool numberTextFormatter = false,
  bool numberText2Formatter = false,
  bool numberText3Formatter = false,
  bool numberText6Formatter = false,
  TextStyle? hintStyle,
  double? lcPadding,
  double? tcPadding,
  double? rcPadding,
  double? bcPadding,
  // bool numberText32TextFormatter = false,
}) {
  return TextFormField(
    controller: textEditingController,
    obscureText: textVisible,
    textInputAction: textInputAction,
    keyboardType: textInputType,
    cursorColor: AppColor.blue,
    readOnly: readOnly,
    validator: validation,
    textCapitalization: textCapitalization,
    onTap: onTap,
    autofocus: autoFocus,
    focusNode: focusNode,
    maxLines: maxLine,
    maxLength: maxLength,
    onChanged: onChange,

    // inputFormatters: textInputFormatter,
    inputFormatters: numberTextFormatter
        ? <TextInputFormatter>[maskFormatterForNumber]
        : numberText2Formatter
            ? <TextInputFormatter>[maskFormatterFor2Number]
            : numberText3Formatter
                ? <TextInputFormatter>[maskFormatterFor3Number]
                : numberText6Formatter
                    ? <TextInputFormatter>[maskFormatterFor6Number]
                    : /*numberText32TextFormatter
                        ? <TextInputFormatter>[maskFormatterFor32Text]
                        : */
                    /*upperCaseTextFormatter
                        ? <TextInputFormatter>[UpperCaseTextFormatter()]
                        :*/
                    <TextInputFormatter>[],
    decoration: InputDecoration(
      counterText: "",
      prefixText: prefixText,
      fillColor: fillColor,
      filled: true,
      prefixIconConstraints: BoxConstraints.tight(Size(30, 36)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius:
            BorderRadius.circular((borderRadius == null) ? 10 : borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular((borderRadius == null) ? 10 : borderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular((borderRadius == null) ? 10 : borderRadius),
        borderSide: BorderSide(color: borderColor),
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular((borderRadius == null) ? 10 : borderRadius),
      ),
      contentPadding: EdgeInsets.only(
        left: lcPadding ?? 20,
        right: rcPadding ?? 10,
        bottom: bcPadding ?? size! / 2, // HERE THE IMPORTANT PART
        top: tcPadding ?? 0,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: (isNullEmptyOrFalse(errorText)) ? null : errorText,
      hintText: hintText,
      hintStyle: hintStyle ??
          TextStyle(
            fontSize: 14,
          ),
    ),
  );
}
