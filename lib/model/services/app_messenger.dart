import 'package:flutter/material.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class AppMessenger {
  static snackBar({
    required String message,
    String? title,
    TextStyle? style,
    TextAlign textAlign = TextAlign.start,
    Widget? content,
    String? label,
    double radius = 0,
    int seconds = 5,
    SnackBarBehavior? behavior,
    DismissDirection dismissDirection = DismissDirection.down,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
  }) {
    BuildContext context = NavService().context();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            if (title != null) const SizedBox(height: 5),
            Text(message, style: style, textAlign: textAlign),
          ],
        ),
        duration: Duration(seconds: seconds),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        behavior: behavior,
        // *** Margin can only be used with floating behavior. SnackBarBehavior.fixed was set in the SnackBar constructor.
        margin: behavior == SnackBarBehavior.floating ? margin ?? const EdgeInsets.only(bottom: 20, left: 10, right: 10) : null,
        dismissDirection: dismissDirection,
        backgroundColor: backgroundColor,
        padding: padding,
        action: label == null ? null : SnackBarAction(label: label, textColor: AppColors.primaryColorDark, onPressed: () {}),
      ),
    );
  }
}
