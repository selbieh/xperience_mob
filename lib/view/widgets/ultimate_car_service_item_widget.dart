import 'package:flutter/material.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/car/car_details_screen.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/feature_item.dart';

class UltimateCarServiceItemWidget extends StatelessWidget {
  const UltimateCarServiceItemWidget({
    required this.carService,
    this.groupValue,
    this.onChanged,
    super.key,
  });

  final CarServiceModel? carService;
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
                  value: carService?.id ?? 0,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carService?.modelName ?? "",
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                    ),
                    Text(
                      carService?.makeName ?? "",
                      style: const TextStyle(fontSize: 12, color: AppColors.grey),
                      maxLines: 2,
                    ),
                  ],
                )),
                BookNowButton(
                  title: "VIEW".localize(context),
                  onPressed: () {
                    NavService().pushKey(CarDetailsScreen(
                      carService: carService,
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
                  // imagePath: "https://platform.cstatic-images.com/xlarge/in/v2/stock_photos/695deff6-4f71-47aa-803f-661efa168c87/7dd59989-82ce-4b6b-80bf-20f4bb2f7381.png",
                  imagePath: "${carService?.image}",
                  height: 0.25.w,
                  width: 0.35.w,
                  borderRadius: BorderRadius.circular(5),
                  fit: BoxFit.contain,
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
                              icon: "assets/svgs/ic_people.svg",
                              // title: "6 People",
                              title: "${carService?.numberOfSeats} ${"Seats".localize(context)}",
                            ),
                            // SizedBox(width: 20),
                            if (carService?.cool == true)
                              const FeatureItem(
                                icon: "assets/svgs/ic_cool_seat.svg",
                                title: "Cool Seat",
                              ),
                            FeatureItem(
                              icon: "assets/svgs/ic_car.svg",
                              // title: "SUV",
                              title: carService?.type ?? "",
                            ),
                          ],
                        ),
                        // Text(
                        //   // "EGP 5,590 per night",
                        //   "${hotelService?.dayPrice ?? 0} ${"EGP".localize(context)} ${"per night".localize(context)}",
                        //   style: const TextStyle(fontSize: 12, color: AppColors.grey),
                        //   maxLines: 2,
                        // ),
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
