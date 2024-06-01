import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/view/widgets/dialogs/message_dialog.dart';

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
}
