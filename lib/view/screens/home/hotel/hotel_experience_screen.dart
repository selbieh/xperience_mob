import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/services/picker_helper.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/hotel/hotel_details_screen.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/components/main_textfield_dropdown.dart';
import 'package:xperience/view/widgets/hotel_experience_item_widget.dart';

class HotelExperienceScreen extends StatelessWidget {
  const HotelExperienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HotelExperienceViewModel>(
      model: HotelExperienceViewModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColorDark,
            title: const Text("Hotel Experience"),
            actions: [
              IconButton(
                icon: SvgPicture.asset("assets/svgs/ic_search.svg"),
                onPressed: () {},
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainTextField(
                    controller: TextEditingController(),
                    hint: "Search",
                    hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                    borderRadius: 5,
                    borderWidth: 0.5,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset("assets/svgs/ic_search_2.svg"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    children: [
                      SvgPicture.asset("assets/svgs/ic_filters.svg"),
                      const SizedBox(width: 10),
                      const Text(
                        "Filters",
                        style: TextStyle(color: AppColors.greyText),
                      ),
                    ],
                  ),
                  MainTextField(
                    controller: model.checkInOutController,
                    hint: "check-in date - check-out date",
                    hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                    isReadOnly: true,
                    borderWidth: 0.5,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14),
                      child: SvgPicture.asset("assets/svgs/ic_calendar_fill.svg"),
                    ),
                    onTap: () => model.selectCheckInOutDate(context),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: MainTextFieldDropdown<String>(
                          items: model.locationList
                              .map(
                                (e) => DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          hint: "Location",
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(fontSize: 14, color: AppColors.white),
                          hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                          borderWidth: 0.5,
                          menuMaxHeight: 300,
                          value: model.selectedLocation,
                          onChanged: (value) {
                            model.selectedLocation = value;
                            model.setState();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MainTextFieldDropdown<String>(
                          items: model.roomsList
                              .map(
                                (e) => DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                          hint: "Room facilities",
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(fontSize: 14, color: AppColors.white),
                          hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
                          borderWidth: 0.5,
                          menuMaxHeight: 300,
                          value: model.selectedRoom,
                          onChanged: (value) {
                            model.selectedRoom = value;
                            model.setState();
                          },
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return HotelExperienceItemWidget(
                        onPressed: () {
                          NavService().pushKey(const HotelDetailsScreen());
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HotelExperienceViewModel extends BaseNotifier {
  String? selectedLocation;
  String? selectedRoom;
  final checkInOutController = TextEditingController();

  Future<void> selectCheckInOutDate(BuildContext context) async {
    DateTimeRange? dateTimeRange = await PickerHelper.getDateRangePicker(
      context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dateTimeRange != null) {
      Logger.log("$dateTimeRange");
    }
  }

  List<String> locationList = [
    "Cairo",
    "Giza",
    "Alexandria",
    "Sharm El-Sheikh",
  ];
  List<String> roomsList = [
    "Room 1",
    "Room 2",
    "Room 3",
    "Room 4",
    "Room 5",
  ];
}
