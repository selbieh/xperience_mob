import 'package:flutter/material.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/booknow_button.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/feature_item.dart';

class CarExperienceItemWidget extends StatelessWidget {
  const CarExperienceItemWidget({
    this.onPressed,
    super.key,
  });

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   NavService().pushKey(const CarDetailsScreen());
      // },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            // margin: const EdgeInsets.symmetric(vertical: 5),
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryColorLight,
              border: Border.all(color: AppColors.greyText, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "GLA 250 SUV",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Mercedes"),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          FeatureItem(
                            icon: "assets/svgs/ic_people.svg",
                            title: "6 People",
                          ),
                          // SizedBox(width: 20),
                          FeatureItem(
                            icon: "assets/svgs/ic_cool_seat.svg",
                            title: "Cool Seat",
                          ),
                          FeatureItem(
                            icon: "assets/svgs/ic_car.svg",
                            title: "SUV",
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
                // "https://www.cars.com/i/xlarge/in/v2/color_matched_stock_photos/865490c2-e59b-4180-a3a1-0c06d2d90375/434a1a4e-9daf-4eca-ba99-a40777f3b955.jpg",
                "https://platform.cstatic-images.com/xlarge/in/v2/stock_photos/695deff6-4f71-47aa-803f-661efa168c87/7dd59989-82ce-4b6b-80bf-20f4bb2f7381.png",
            width: 0.45.w,
            // height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
