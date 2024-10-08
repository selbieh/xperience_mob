import 'package:flutter/material.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class ApproveDialog extends StatelessWidget {
  final String title;
  final String subtitle;

  const ApproveDialog({
    Key? key,
    required this.title ,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        title.localize(context),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(subtitle.localize(context)),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => AppColors.goldColor),
          ),
          child: const Text("Discard").localize(context),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => AppColors.goldColor),
          ),
          child: Text(locale.get("Continue")),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
