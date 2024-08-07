import 'package:flutter/material.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/hotel/hotel_details_screen.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/feature_item.dart';

class UltimateHotelServiceItemWidget extends StatelessWidget {
  const UltimateHotelServiceItemWidget({
    required this.hotelService,
    this.groupValue,
    this.onChanged,
    super.key,
  });

  final HotelServiceModel? hotelService;
  final int? groupValue;
  final Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      // height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColorLight,
        border: Border.all(color: AppColors.goldColor, width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: AppColors.primaryColorLight2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Radio(
                  value: hotelService?.id ?? 0,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotelService?.name ?? "",
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                    ),
                    Text(
                      hotelService?.description ?? "",
                      style: const TextStyle(fontSize: 12, color: AppColors.grey),
                      maxLines: 2,
                    ),
                  ],
                )),
                BookNowButton(
                  title: "VIEW".localize(context),
                  onPressed: () {
                    NavService().pushKey(HotelDetailsScreen(
                      hotelService: hotelService,
                      isFromUltimate: true,
                    ));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                MainImage.network(
                  imagePath: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
                  width: 0.35.w,
                  height: 0.35.w,
                  borderRadius: BorderRadius.circular(5),
                  fit: BoxFit.cover,
                ),
                Expanded(
                  // flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            FeatureItem(
                              icon: "assets/svgs/ic_room_door.svg",
                              // title: "2 Rooms",
                              title: "${hotelService?.numberOfRooms ?? 0} Rooms",
                              padding: const EdgeInsets.symmetric(vertical: 5),
                            ),
                            // SizedBox(width: 20),
                            const SizedBox(width: 20),
                            FeatureItem(
                              icon: "assets/svgs/ic_hotel.svg",
                              // title: "4 Beds",
                              title: "${hotelService?.numberOfBeds ?? 0} Beds",
                              padding: const EdgeInsets.symmetric(vertical: 5),
                            ),
                            // const SizedBox(width: 20),
                            // const FeatureItem(
                            //   icon: "assets/svgs/ic_breakfast.svg",
                            //   title: "Breakfast",
                            //   padding: EdgeInsets.symmetric(vertical: 5),
                            // ),
                          ],
                        ),
                        Text(
                          // "EGP 5,590 per night",
                          // "${hotelService?.dayPrice ?? 0} ${"EGP".localize(context)} ${"per night".localize(context)}",
                          "\$${hotelService?.dollarDayPrice ?? 0} ${"per night".localize(context)}",
                          style: const TextStyle(fontSize: 12, color: AppColors.grey),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
