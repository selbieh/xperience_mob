import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class PickerHelper {
  static Future<TimeOfDay?> getTimePicker(
    BuildContext context, {
    TimeOfDay? initialTime,
    Color color = AppColors.goldColor,
  }) async {
    TimeOfDay? dateTime = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: color,
            colorScheme: ColorScheme.dark(primary: color),
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
    Color color = AppColors.goldColor,
  }) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      currentDate: currentDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: color,
            colorScheme: ColorScheme.dark(primary: color),
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
    Color color = AppColors.goldColor,
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
              // ignore: deprecated_member_use
              background: AppColors.primaryColorDark,
            ),
          ),
          child: child!,
        );
      },
    );
    return dateTimeRange;
  }


  ///==================================================================================
  ///================================================================== Location Picker
  static Future<LatLng?> getLocationPicker(BuildContext context, {LatLng? targetLatLng}) async {
    List<Marker> markers = [];
    LatLng? latLng = await showDialog(
      context: (context),
      builder: (context) {
        if (targetLatLng != null) {
          markers.add(Marker(markerId: const MarkerId('MarkerID'), position: targetLatLng!));
        }
        return StatefulBuilder(
          builder: (context, newSetState) {
            return Dialog(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: targetLatLng ?? const LatLng(30.043241, 31.239521),
                          zoom: 7,
                        ),
                        markers: markers.toSet(),
                        onTap: (value) {
                          newSetState(() {
                            markers.clear();
                            markers.add(
                              Marker(markerId: const MarkerId('MarkerID'), position: value),
                            );
                          });
                          targetLatLng = value;
                        },
                      ),
                    ),
                    MainButton(
                      height: 45,
                      width: double.infinity,
                      radius: 0,
                      title: "Ok".localize(context),
                      onPressed: () {
                        Navigator.of(context).pop(targetLatLng);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    return latLng;
  }
}
