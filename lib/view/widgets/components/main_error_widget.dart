import 'package:flutter/material.dart';
import 'package:xperience/model/config/app_const.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({
    this.error,
    this.onRetry,
    super.key,
  });
  final String? error;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            error ?? AppConst.defaultError,
            style: const TextStyle(color: AppColors.red),
            textAlign: TextAlign.center,
          ),
        ),
        if (onRetry != null)
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 10),
            child: MainButton(
              title: "Tap to retry".localize(context),
              radius: 20,
              onPressed: onRetry,
            ),
          ),
      ],
    ));
  }
}
