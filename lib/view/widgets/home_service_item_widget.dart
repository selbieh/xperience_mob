import 'package:flutter/material.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_image.dart';

class HomeServiceItemWidget extends StatelessWidget {
  const HomeServiceItemWidget({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: AppColors.goldColor),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            MainImage.asset(
              imagePath: imageUrl,
              height: 0.50.h,
              width: 0.75.w,
              // fit: BoxFit.cover,
              fit: BoxFit.fill,
              radius: 10,
            ),
            Container(
              height: 0.50.h,
              width: 0.75.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 16, color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
