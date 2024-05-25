import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class FeatureBoarderItem extends StatelessWidget {
  const FeatureBoarderItem({
    required this.icon,
    required this.title,
    required this.value,
    super.key,
  });
  final String icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.grey,
            width: 0.5,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(icon),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 30)
            ],
          ),
          Text(
            value,
            style: const TextStyle(color: AppColors.greyText, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
