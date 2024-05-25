
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    required this.icon,
    required this.title,
    super.key,
  });
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(color: AppColors.greyText, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
