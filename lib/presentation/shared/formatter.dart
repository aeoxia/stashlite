import 'package:intl/intl.dart';

const defaultDateFormat = "yyyy-MM-dd'T'HH:mm:ss";
const uiDateFormat = "MMM d, hh:mm a";

extension DateStringConverter on String? {
  String toFormat(
      {DateTime? defaultDateTime,
      String inputFormat = defaultDateFormat,
      String outputFormat = defaultDateFormat}) {
    final inputFormatter = DateFormat(inputFormat);
    final outputFormatter = DateFormat(outputFormat);
    try {
      final dateTime = inputFormatter.parse(this!);
      final dateTimeString = outputFormatter.format(dateTime);
      return dateTimeString;
    } catch (e) {
      return outputFormatter.format(defaultDateTime ?? currentDateTime());
    }
  }

  DateTime toDateTime(
      {DateTime? defaultDateTime, String outputFormat = defaultDateFormat}) {
    try {
      final outputFormatter = DateFormat(outputFormat);
      return outputFormatter.parse(this!);
    } catch (e) {
      return defaultDateTime ?? currentDateTime();
    }
  }
}

extension DateToStringFormatter on DateTime {
  String toDateString(
      {DateTime? defaultDateTime, String outputFormat = defaultDateFormat}) {
    final outputFormatter = DateFormat(outputFormat);
    try {
      return outputFormatter.format(this);
    } catch (e) {
      return outputFormatter.format(defaultDateTime ?? currentDateTime());
    }
  }
}

DateTime currentDateTime() {
  return DateTime.now();
}

DateTime nextDayDateTime() {
  return currentDateTime().add(const Duration(days: 1));
}
