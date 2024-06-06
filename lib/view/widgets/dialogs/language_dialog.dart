import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLanguage = Provider.of<AppLanguage>(context);
    String selectedLangValue = appLanguage.getLanguageName();
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
                  "Choose Language".localize(context),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Column(
                  children: appLanguage.languages
                      .map(
                        (e) => RadioListTile<String>(
                          // activeColor: AppColors.primaryColor,
                          activeColor: AppColors.goldColor,
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            e.localize(context),
                            style: const TextStyle(fontSize: 16),
                          ),
                          value: e,
                          groupValue: selectedLangValue,
                          onChanged: (value) {
                            selectedLangValue = value!;
                            builderSetstate(() {});
                          },
                        ),
                      )
                      .toList(),
                ),
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
                        "OK".localize(context),
                        style: const TextStyle(fontSize: 13, color: AppColors.goldColor),
                      ),
                      onPressed: () => Navigator.of(context).pop(selectedLangValue),
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
