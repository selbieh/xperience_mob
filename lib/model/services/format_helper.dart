import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:xperience/model/config/logger.dart';

class FormatHelper {
  static String formatDateTime(
    DateTime dateTime, {
    String pattern = "h:mm a EEEE d MMM y",
    String localeCode = "en",
  }) {
    return DateFormat(pattern, localeCode).format(dateTime);
  }

  static String? formatStringDateTime(
    String stringDateTime, {
    String localeCode = "en",
    String pattern = "h:mm a EEEE d MMM y",
    String? inputPattern,
  }) {
    try {
      if (inputPattern == null) {
        final dateTime = DateTime.tryParse(stringDateTime);
        if (dateTime != null) {
          return DateFormat(pattern, localeCode).format(dateTime);
        } else {
          return null;
        }
      } else {
        DateTime inputDate = DateFormat(inputPattern).parse(stringDateTime);
        String outputDate = DateFormat(pattern).format(inputDate);
        return outputDate;
      }
    } catch (error) {
      Logger.printt(error, isError: true);
      return null;
    }
  }

  static DateTime? getDateTimeFromString(
    String stringDateTime, {
    String? inputPattern,
  }) {
    try {
      if (inputPattern == null) {
        final dateTime = DateTime.tryParse(stringDateTime);
        return dateTime;
      } else {
        DateTime dateTime = DateFormat(inputPattern).parse(stringDateTime);
        return dateTime;
      }
    } catch (error) {
      Logger.printt(error, isError: true);
      return null;
    }
  }

  static String formatTimeOfDay(
    BuildContext context,
    TimeOfDay timeOfDay,
  ) {
    return timeOfDay.format(context);
  }
}
