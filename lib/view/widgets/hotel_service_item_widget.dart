import 'package:flutter/material.dart';
import 'package:xperience/model/models/hotel_service_model.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/feature_item.dart';

class HotelServiceItemWidget extends StatelessWidget {
  const HotelServiceItemWidget({
    required this.hotelService,
    this.onPressed,
    super.key,
  });

  final HotelServiceModel? hotelService;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      // margin: const EdgeInsets.symmetric(vertical: 5),
      height: 200,
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryColorLight,
        border: Border.all(color: AppColors.greyText, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: MainImage.network(
              // imagePath: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
              imagePath: "${hotelService?.image}",
              placeholderPath: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
              height: 250,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // "Eastern El-Galala Aquapark ",
                    hotelService?.name ?? "",
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    child: Text(
                      // "Ain Sokhna",
                      hotelService?.description ?? "",
                      style: const TextStyle(fontSize: 12, color: AppColors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FittedBox(
                          child: Text(
                            // "EGP 5,590 per night",
                            // "${hotelService?.dayPrice ?? 0} ${"EGP".localize(context)} ${"per night".localize(context)}",
                            "\$${hotelService?.dollarDayPrice ?? 0} ${"per night".localize(context)}",
                            style: const TextStyle(fontSize: 12, color: AppColors.grey),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      BookNowButton(
                        title: "BOOK NOW".localize(context),
                        onPressed: onPressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
