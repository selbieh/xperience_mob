import 'package:flutter/material.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    this.isSuccess = true,
    this.message,
    super.key,
  });
  final bool isSuccess;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          title: Text(isSuccess ? "Success" : "Error").localize(context),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isSuccess) ...[
                      const Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
                      const SizedBox(height: 20),
                      const Text(
                        "Congratulations",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ).localize(context),
                      const SizedBox(height: 10),
                      Text(
                        message ?? "Success".localize(context),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, color: AppColors.greyText),
                      ),
                    ],
                    if (!isSuccess) ...[
                      const Icon(Icons.error_outline, color: Colors.red, size: 100),
                      const SizedBox(height: 20),
                      const Text(
                        "Error",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ).localize(context),
                      Text(
                        message ?? "Something went wrong",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, color: AppColors.greyText),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: MainButton(
                  height: 45,
                  width: double.infinity,
                  title: "Go to home".localize(context),
                  onPressed: () async {
                    NavService().popUntilKey(
                      settings: const RouteSettings(name: RouteNames.mainScreen),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
