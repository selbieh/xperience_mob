import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class MenuListTileItemWidget extends StatelessWidget {
  const MenuListTileItemWidget({
    required this.title,
    required this.icon,
    this.onTap,
    super.key,
  });

  final String title;
  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // ignore: deprecated_member_use
      leading: SvgPicture.asset(icon, color: AppColors.goldColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      dense: true,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.goldColor),
      ),
      onTap: onTap,
    );
  }
}
