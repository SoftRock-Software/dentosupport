import 'package:intl/intl.dart';

class DateFormatUtils {
  static String format(DateTime dateTime) {
    return DateFormat('EEEE, dd MMMM').format(dateTime);
  }

  static String weekDate(DateTime dateTime) {
    return DateFormat('EEE').format(dateTime);
  }

  static String fullWeekDay(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  static String dob(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}

extension DateUtils on DateTime {
  String get dateInput {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get dateString {
    if (isToday) {
      return 'Today';
    } else if (isTomorrow) {
      return 'Tomorrow';
    } else if (isYesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM dd, yyyy').format(this);
    }
  }

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String get dob {
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
