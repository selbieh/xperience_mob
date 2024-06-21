import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/repo/info_repo.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TermsScreenModel>(
      model: TermsScreenModel(
        infoRepo: Provider.of<InfoRepo>(context),
      ),
      initState: (model) {
        if (model.infoRepo.termsOfUse == null) {
          model.getTermsOfUse();
        }
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Terms of use").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : ListView(
                  children: [
                    if (model.infoRepo.termsOfUse?.content != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Html(
                          data: """${model.infoRepo.termsOfUse?.content}""",
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}

class TermsScreenModel extends BaseNotifier {
  TermsScreenModel({required this.infoRepo});
  final InfoRepo infoRepo;

  Future<void> getTermsOfUse() async {
    setBusy();
    var res = await infoRepo.getTermsOfUse();
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
    }
  }
}
