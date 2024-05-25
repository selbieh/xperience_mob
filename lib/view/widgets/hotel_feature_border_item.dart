import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class HotelFeatureBoarderItem extends StatelessWidget {
  const HotelFeatureBoarderItem({
    required this.icon,
    required this.title,
    super.key,
  });
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.grey,
            width: 0.5,
          )),
      child: Wrap(
        // runAlignment: WrapAlignment.center,
        // alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
