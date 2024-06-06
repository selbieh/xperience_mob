import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class MenuTitleItem extends StatelessWidget {
  const MenuTitleItem(
    this.title, {
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.greyText, fontWeight: FontWeight.bold),
      ),
    );
  }
}
