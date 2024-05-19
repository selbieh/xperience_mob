
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: const EdgeInsets.all(0),
      leading: SvgPicture.asset("assets/svgs/vi_crown.svg"),
      title: const Row(
        children: [
          Expanded(
              child: Text(
            "Congatulations",
            style: TextStyle(color: AppColors.white, fontSize: 12),
          )),
          Text(
            "5/19/2024",
            style: TextStyle(
              fontSize: 11,
              color: AppColors.greyText,
            ),
          ),
        ],
      ),
      subtitle: const Text(
        "You have earned 1500 point for your last reservation",
        style: TextStyle(
          fontSize: 11,
          color: AppColors.greyText,
        ),
      ),
      onTap: null,
    );
  }
}