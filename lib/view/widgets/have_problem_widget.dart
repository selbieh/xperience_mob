import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
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
        ),
        MainButton(
          type: ButtonType.text,
          radius: 10,
          title: "Contact us",
          color: AppColors.greyText,
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          onPressed: () {},
        ),
      ],
    );
  }
}
