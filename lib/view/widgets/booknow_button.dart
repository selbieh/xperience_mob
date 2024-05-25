
import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class BookNowButton extends StatelessWidget {
  const BookNowButton({
    required this.title,
    this.onPressed,
    super.key,
  });
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.goldColor),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColorLight,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
