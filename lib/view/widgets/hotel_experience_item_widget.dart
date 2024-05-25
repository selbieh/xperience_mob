import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/feature_item.dart';

class HotelExperienceItemWidget extends StatelessWidget {
  const HotelExperienceItemWidget({
    this.onPressed,
    super.key,
  });

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
          const Expanded(
            child: MainImage.network(
              imagePath: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iyix1OYhVxdA/v2/-1x-1.jpg",
              height: 250,
              borderRadius: BorderRadius.only(
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
                  const Text(
                    "Eastern El-Galala Aquapark ",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Ain Sokhna",
                    style: TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      FeatureItem(
                        icon: "assets/svgs/ic_room_door.svg",
                        title: "2 Rooms",
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      // SizedBox(width: 20),
                      SizedBox(width: 20),
                      FeatureItem(
                        icon: "assets/svgs/ic_hotel.svg",
                        title: "4 Beds",
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                      SizedBox(width: 20),
                      FeatureItem(
                        icon: "assets/svgs/ic_breakfast.svg",
                        title: "Breakfast",
                        padding: EdgeInsets.symmetric(vertical: 5),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          "EGP 5,590 per night",
                          style: TextStyle(fontSize: 12, color: AppColors.grey),
                        ),
                      ),
                      BookNowButton(
                        title: "BOOK NOW",
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
