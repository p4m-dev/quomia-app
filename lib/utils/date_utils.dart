import 'package:intl/intl.dart';

class CustomDateUtils {
  static DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  static DateFormat timeFormat = DateFormat("HH:mm");
  static DateFormat fullFormat = DateFormat('dd/MM/yyyy HH:mm');

  static DateTime findNextFutureDate(DateTime pastDate) {
    DateTime today = DateTime.now();

    DateTime nextDate = DateTime(today.year, pastDate.month, pastDate.day);

    if (!nextDate.isAfter(today)) {
      nextDate = DateTime(today.year + 1, pastDate.month, pastDate.day);
    }

    return nextDate;
  }

  static DateTime addYears(DateTime date, int years) {
    return DateTime(
      date.year + years,
      date.month,
      date.day,
    );
  }

  static DateTime transformDate(String dateText, String timeText) {
    DateTime date = dateFormat.parse(dateText);
    DateTime time = timeFormat.parse(timeText);

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  static List<DateTime> generateDateList(DateTime startDate, DateTime endDate) {
    List<DateTime> dateList = [];

    for (int year = startDate.year; year <= endDate.year; year++) {
      dateList.add(DateTime(year, startDate.month, startDate.day,
          startDate.hour, startDate.minute));
    }

    return dateList;
  }

  static DateTime timestampToDateTime(Map<String, dynamic> timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp['_seconds'] * 1000 +
        (timestamp['_nanoseconds'] / 1000000).round());
  }

  static String parseDate(DateTime dateTime) {
    return fullFormat.format(dateTime);
  }
}
