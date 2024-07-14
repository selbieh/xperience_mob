import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/repo/info_repo.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_error_widget.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PrivacyPolicyScreenModel>(
      model: PrivacyPolicyScreenModel(
        infoRepo: Provider.of<InfoRepo>(context),
      ),
      initState: (model) {
        if (model.infoRepo.privacyPolicy == null) {
          model.getPrivacy();
        }
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy policy").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : model.hasError
                  ? MainErrorWidget(
                      error: model.failure,
                      onRetry: model.getPrivacy,
                    )
                  : ListView(
                      children: [
                        if (model.infoRepo.termsOfUse?.content != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Html(
                              data: """${model.infoRepo.privacyPolicy?.content}""",
                            ),
                          ),
                      ],
                    ),
        );
      },
    );
  }
}

class PrivacyPolicyScreenModel extends BaseNotifier {
  PrivacyPolicyScreenModel({required this.infoRepo});
  final InfoRepo infoRepo;

  Future<void> getPrivacy() async {
    setBusy();
    var res = await infoRepo.getPrivacyPolicy();
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
    }
  }
}
