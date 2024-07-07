import 'package:flutter/material.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/components/main_image_slider.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({
    required this.imageList,
    super.key,
  });
  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    return MainImageSlider(
      aspectRatio: 28 / 9,
      items: imageList
          .map(
            (e) => Stack(
              children: [
                // MainImage.network(
                //   width: double.infinity,
                //   height: double.infinity,
                //   fit: BoxFit.cover,
                //   imagePath: e,
                //   radius: 10,
                // ),
                MainImage.cached(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imagePath: e,
                  radius: 10,
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.black54, Colors.black54],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      const SizedBox(),
                      const Text(
                        "50%",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          height: 0,
                        ),
                      ),
                      Text(
                        "OFF".localize(context),
                        style: const TextStyle(color: AppColors.white, fontSize: 18),
                      ),
                      Text(
                        "Next 3 Rides".localize(context),
                        style: const TextStyle(color: AppColors.white, fontSize: 10),
                      ),
                      const SizedBox(),
                      const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
