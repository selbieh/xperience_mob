import 'package:flutter/material.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

enum MessageDialogType {
  error,
  info,
  success,
}

class MessageDialog extends StatelessWidget {
  final String message;
  final double radius;
  final bool isRetry;
  final MessageDialogType type;

  const MessageDialog({
    required this.message,
    required this.radius,
    required this.isRetry,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.warning_amber;
    Color color = Colors.red;
    switch (type) {
      case MessageDialogType.error:
        {
          icon = Icons.warning;
          color = Colors.red;
        }
        break;
      case MessageDialogType.info:
        {
          icon = Icons.info;
          color = Colors.blue;
        }
        break;
      case MessageDialogType.success:
        {
          icon = Icons.check_circle;
          color = Colors.green;
        }
        break;
    }
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          //========================================================== Dialog Content
          Container(
            width: SizeConfig.width * 0.85,
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(radius),
              // border: Border.all(color: AppColors.goldColor),
              border: Border.all(color: color),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 40),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    maxLines: 10,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                if (isRetry)
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 10),
                    child: MainButton(
                      title: "Tap to retry",
                      radius: 5,
                      width: SizeConfig.width * 0.50,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ),
              ],
            ),
          ),
          //========================================================== Dialog Icon
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                width: 1,
                color: Theme.of(context).dialogBackgroundColor,
                // color: AppColors.goldColor2,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 35, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
