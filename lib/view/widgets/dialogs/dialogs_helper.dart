import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/view/widgets/dialogs/language_dialog.dart';
import 'package:xperience/view/widgets/dialogs/message_dialog.dart';
import 'package:xperience/view/widgets/dialogs/notify_dialog.dart';

class DialogsHelper {
  static Future<dynamic> messageDialog({
    required String message,
    double? radius = 10,
    bool? isRetry = false,
    MessageDialogType type = MessageDialogType.error,
  }) async {
    return await showDialog(
      context: NavService().context(),
      builder: (ctx) {
        return MessageDialog(
          message: message,
          radius: radius!,
          isRetry: isRetry!,
          type: type,
        );
      },
    );
  }

  static Future<dynamic> chooseLanguageDialog(
    BuildContext context,
  ) async {
    return await showDialog(
      context: context,
      builder: (ctx) {
        return const LanguageDialog();
      },
    );
  }

  static Future<dynamic> notifyDialog({
    String? title,
    String? subtitle,
    Widget? leading,
  }) async {
    return await showGeneralDialog(
      context: NavService().context(),
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, anim1, anim2) {
        return NotifyDialog(title: title, subtitle: subtitle, leading: leading);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }
}
