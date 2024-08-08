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

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AboutUsScreenModel>(
      model: AboutUsScreenModel(
        infoRepo: Provider.of<InfoRepo>(context),
      ),
      initState: (model) {
        if (model.infoRepo.aboutUs == null) {
          model.getAboutUs();
        }
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("About us").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : model.hasError
                  ? MainErrorWidget(
                      error: model.failure,
                      onRetry: model.getAboutUs,
                    )
                  : ListView(
                      children: [
                        if (model.infoRepo.aboutUs?.content != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Html(
                              data: """${model.infoRepo.aboutUs?.content}""",
                            ),
                          ),
                      ],
                    ),
        );
      },
    );
  }
}

class AboutUsScreenModel extends BaseNotifier {
  AboutUsScreenModel({required this.infoRepo});
  final InfoRepo infoRepo;

  Future<void> getAboutUs() async {
    setBusy();
    var res = await infoRepo.getAboutUs();
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
    }
  }
}
