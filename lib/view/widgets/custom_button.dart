import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    required this.onPressed,
    this.color,
    this.textStyle,
    super.key,
  });
  final String title;
  final Color? color;
  final TextStyle? textStyle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: onPressed == null ? AppColors.grey : color ?? AppColors.goldColor),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColorLight,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: textStyle ?? const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
