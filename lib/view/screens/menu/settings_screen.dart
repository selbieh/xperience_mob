import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLanguage = Provider.of<AppLanguage>(context);

    return BaseWidget<SettingsScreenModel>(
      model: SettingsScreenModel(context: context, appLanguage: appLanguage),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Settings").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "Language",
                    style: TextStyle(color: AppColors.goldColor),
                  ).localize(context),
                  // subtitle: Text(appLanguage.languageName),
                  subtitle: Text(appLanguage.getLanguageName()),
                  leading: const Icon(Icons.language, color: AppColors.goldColor),
                  onTap: model.changeLanguage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingsScreenModel extends BaseNotifier {
  late String selectedValue;

  SettingsScreenModel({
    required this.context,
    required this.appLanguage,
  }) {
    selectedValue = appLanguage.getLanguageName();
  }
  final BuildContext context;
  final AppLanguage appLanguage;

  void changeLanguage() async {
    var result = await DialogsHelper.chooseLanguageDialog(context);
    if (result != null) {
      appLanguage.changeLanguageByName(languageName: result);
      setState();
    }
  }
}
