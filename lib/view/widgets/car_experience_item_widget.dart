import 'package:flutter/material.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/models/car_service_model.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/feature_item.dart';

class CarExperienceItemWidget extends StatelessWidget {
  const CarExperienceItemWidget({
    required this.carService,
    this.onPressed,
    super.key,
  });

  final CarServiceModel carService;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.primaryColorLight,
            border: Border.all(color: AppColors.greyText, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // "GLA 250 SUV",
                carService.model ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              // const Text("Mercedes"),
              Text(carService.make ?? ""),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        FeatureItem(
                          icon: "assets/svgs/ic_people.svg",
                          // title: "6 People",
                          title: "${carService.numberOfSeats} Seats",
                        ),
                        // SizedBox(width: 20),
                        if (carService.cool == true)
                          const FeatureItem(
                            icon: "assets/svgs/ic_cool_seat.svg",
                            title: "Cool Seat",
                          ),
                        FeatureItem(
                          icon: "assets/svgs/ic_car.svg",
                          // title: "SUV",
                          title: carService.type ?? "",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: BookNowButton(
                        title: "BOOK NOW",
                        onPressed: onPressed,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        MainImage.network(
          imagePath:
              "https://platform.cstatic-images.com/xlarge/in/v2/stock_photos/695deff6-4f71-47aa-803f-661efa168c87/7dd59989-82ce-4b6b-80bf-20f4bb2f7381.png",
          // "${carService.image}",
          width: 0.45.w,
          // height: 100,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
