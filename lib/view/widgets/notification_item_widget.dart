import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      // contentPadding: const EdgeInsets.all(0),
      // leading: SvgPicture.asset("assets/svgs/vi_crown.svg"),
      leading: Icon(Icons.notifications, color: AppColors.goldColor, size: 30),
      title: Row(
        children: [
          Expanded(
              child: Text(
            "Congatulations",
            maxLines: 1,
            style: TextStyle(color: AppColors.white, fontSize: 12),
          )),
          Text(
            "5/19/2024",
            maxLines: 1,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.greyText,
            ),
          ),
        ],
      ),
      subtitle: Text(
        "You have earned 1500 point for your last reservation, you have earned 1500 point for your last reservation",
        maxLines: 3,
        style: TextStyle(
          fontSize: 11,
          color: AppColors.greyText,
        ),
      ),
      onTap: null,
    );
  }
}
