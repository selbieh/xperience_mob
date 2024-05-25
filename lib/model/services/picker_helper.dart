import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class PickerHelper {
  static Future<TimeOfDay?> getTimePicker(
    BuildContext context, {
    TimeOfDay? initialTime,
    Color color = AppColors.primaryColorDark,
  }) async {
    TimeOfDay? dateTime = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: color,
            colorScheme: ColorScheme.fromSwatch().copyWith(background: Theme.of(context).dialogBackgroundColor),
          ),
          child: child!,
        );
      },
    );
    return dateTime;
  }

  static Future<DateTime?> getDatePicker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? currentDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Color color = AppColors.primaryColorDark,
  }) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      currentDate: currentDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: color,
            colorScheme: ColorScheme.light(primary: color),
          ),
          child: child!,
        );
      },
    );
    return dateTime;
  }

  static Future<DateTimeRange?> getDateRangePicker(
    BuildContext context, {
    required DateTime firstDate,
    required DateTime lastDate,
    Color color = AppColors.primaryColorDark,
  }) async {
    DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        // return child
        return Theme(
          data: ThemeData.dark().copyWith(
              primaryColor: color,
              // colorScheme: ColorScheme.dark(primary: color),
              colorScheme: ColorScheme.fromSeed(
                primary: AppColors.greyText,
                seedColor: AppColors.greyText,
                brightness: Brightness.dark,
                background: AppColors.primaryColorDark,
              )),
          child: child!,
        );
      },
    );
    return dateTimeRange;
  }
}
