import 'package:flutter/material.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/menu/help_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class HaveProblemWidget extends StatelessWidget {
  const HaveProblemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        const Text(
          "Have a problem?",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: AppColors.greyText,
            fontSize: 12,
          ),
        ).localize(context),
        MainButton(
          type: ButtonType.text,
          radius: 10,
          title: "Contact us".localize(context),
          color: AppColors.greyText,
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          onPressed: () {
            NavService().pushKey(const HelpScreen());
          },
        ),
      ],
    );
  }
}
