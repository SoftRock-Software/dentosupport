// App Colors

import 'package:flutter/material.dart';

class AppColor {
  static const transparent = Color(0x00FFFFFF);
  static const black = Color(0xff000000);
  static const blackText = Color(0xff1A202C);
  static const darkBlackText = Color(0xff34343F);
  static const white = Color(0xFFFFFFFF);
  static const lightWhite = Color(0xFFD3D3D3);
  static const whiteButton = Color(0xFFE3E3E3);
  static const whiteBackground = Color(0xFFF6F7F9);
  static const blue = Color(0xFF00419D);
  static const green = Colors.green;
  static const red = Color(0xFFE34F4F);
  static const grey = Colors.grey;
  static const greyLine =  Color(0xFFB6B6B6);
  static const greyBackground = Color(0xFFF3F3F3);
  static const grayDarkText = Color(0xFFF3C3C43);
  static const grayLightText = Color(0xFF8E8E92);
  static const grayCardBackground = Color(0xFFF5F5F5);
  static const grayLine = Color(0xFF757575);
  static const greyDarkBackground = Color(0xFFE5E5E5);
  static const darkGrey = Color(0xFF6F6F70);
  static const greyText = Color(0xFF90A3BF);
  static const lightGreyText = Color(0xFFCFCFCF);
  static const darkGreyText = Color(0xFF575757);
  static const greyLightBackground = Color(0xFFE6E6E6);
  static const navyGreyDarkBackground = Color(0xFF464665);
  static const textGrey = Color(0xFF3C4043);
  static const textGreyLight = Color(0xFF808080);
  static const shadowGrey = Color(0xFFB1A79D);
  static const grayBackground = Color(0xFFDADADA);
  static const blackDark = Color(0xFF1F2024);
  static const greyLight = Color(0xFFC5C6CC);
  static const lightWhiteShade = Color(0xffD4D6DD);
  static const textFieldColor = Color(0xffEFEFF0);
  static const textBlue = Color(0xff1F2544);
  static const grayDark = Color(0xffC5C5C7);

  // Hexadecimal Color
  static Color hexGrey = fromHex('#121212');

  static Color fromHex(
    String hexString,
  ) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write(
        'ff',
      );
    }
    buffer.write(
      hexString.replaceFirst(
        '#',
        '',
      ),
    );
    return Color(
      int.parse(
        buffer.toString(),
        radix: 16,
      ),
    );
  }
}
