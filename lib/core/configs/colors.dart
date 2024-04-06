import 'package:flutter/material.dart';

class AppFont {
  static const inter = 'Inter';
  static const nunitoSans = 'Nunito Sans';
  static const plusJakartaSans = 'Plus Jakarta Sans';
}

abstract class AppAssets {
  static const appIcon = 'assets/svgs/AppIcon.png';
  static const empty = 'assets/svgs/empty.png';
  static const todayAndOff = 'assets/svgs/today_off.png';
  static const yesterday = 'assets/svgs/yesterday.png';
  static const tomorrow = 'assets/svgs/tomorrow.png';
  static const bolcked = 'assets/svgs/bolcked.png';
  static const emptySheet = 'assets/svgs/empty_sheet.svg';
  static const emptySheetPng = 'assets/svgs/empty_sheet.png';
  // static const emptySearch = 'assets/svgs/empty_search.svg';
  static const emptySearch = 'assets/svgs/empty_search.png';
  static const whatsapp = 'assets/svgs/whatsapp.png';
}

/// Application-wide colors.
class AppColor {
  /// Primary color of the app.
  static const primaryColor = Color(0xFF00419D);
  static const backgroundColor = Colors.white;
  static const red = Color(0xFFE34F4F);
  static const textColor = Colors.black;
  static const subtitleColor = Color(0xFF575757);
  static const captionColor = Color(0xFF1F2024);
  static const hintColor = Color(0xFF8C8C8C);
  static const childToothColor = Color(0xFFE84393);
}

class AppFontStyle {
  static const style1 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColor.textColor,
    letterSpacing: 1,
  );

  static const hintStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color(0xFF969696),
    letterSpacing: 1,
  );

  static const textStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColor.textColor,
  );

  static const style2 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColor.textColor,
    letterSpacing: 1,
  );

  static const style3 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColor.textColor,
  );

  static const style4 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColor.primaryColor,
  );

  static const style5 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: AppColor.primaryColor,
  );

  static const style6 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColor.textColor,
  );

  static const style7 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const style8 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColor.textColor,
  );

  static const style9 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Color(0xFF777777),
  );

  static const toothNormalStyle = TextStyle(
    color: AppColor.primaryColor,
    fontFamily: AppFont.nunitoSans,
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );

  static const toothSelectedStyle = TextStyle(
    color: AppColor.backgroundColor,
    fontFamily: AppFont.nunitoSans,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const selectedLabelStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColor.primaryColor,
  );

  static const style10 = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColor.primaryColor,
  );
}
