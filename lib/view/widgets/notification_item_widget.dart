import 'package:flutter/material.dart';
import 'package:xperience/model/models/notification_model.dart';
import 'package:xperience/model/services/format_helper.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    required this.notification,
    super.key,
  });

  final NotificationModel? notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: const EdgeInsets.all(0),
      // leading: SvgPicture.asset("assets/svgs/vi_crown.svg"),
      leading: const Icon(Icons.notifications, color: AppColors.goldColor, size: 30),
      title: Row(
        children: [
          Expanded(
            child: Text(
              // "Congatulations",
              notification?.title ?? "",
              maxLines: 1,
              style: const TextStyle(color: AppColors.white, fontSize: 12),
            ),
          ),
          Text(
            // "5/19/2024",
            "${FormatHelper.formatStringDateTime(notification?.createdAt ?? "", pattern: "d/M/yyyy")}",
            maxLines: 1,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.greyText,
            ),
          ),
        ],
      ),
      subtitle: Text(
        // "You have earned 1500 point for your last reservation, you have earned 1500 point for your last reservation",
        notification?.body ?? "",
        maxLines: 3,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.greyText,
        ),
      ),
      onTap: null,
    );
  }
}
