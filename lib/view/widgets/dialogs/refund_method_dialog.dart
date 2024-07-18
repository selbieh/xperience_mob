import 'package:flutter/material.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_textfield_dropdown.dart';

class RefundMethodDialog extends StatelessWidget {
  const RefundMethodDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedMethod;
    return StatefulBuilder(
      builder: (context, builderSetstate) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Choose Refund Method".localize(context),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    MainTextFieldDropdown<String>(
                      items: [
                        "dsadas1",
                        "dsadas2",
                        "dsadas3",
                      ].map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      hint: "Refund method".localize(context),
                      onChanged: (value) {
                        selectedMethod = value;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        "CANCEL".localize(context),
                        style: const TextStyle(fontSize: 13, color: AppColors.goldColor),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      child: Text(
                        "REFUND".localize(context),
                        style: const TextStyle(fontSize: 13, color: AppColors.red),
                      ),
                      onPressed: () => Navigator.of(context).pop(selectedMethod),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
