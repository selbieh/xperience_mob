import 'package:flutter/material.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class CarInfoItem extends StatelessWidget {
  const CarInfoItem({
    required this.title,
    required this.value,
    super.key,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(color: AppColors.greyText, fontSize: 12),
        ),
        SizedBox(width: 0.25.w),
      ],
    );
  }
}
