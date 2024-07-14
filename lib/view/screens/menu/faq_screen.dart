import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/data/repo/info_repo.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_error_widget.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FAQScreenModel>(
      model: FAQScreenModel(
        infoRepo: Provider.of<InfoRepo>(context),
      ),
      initState: (model) {
        if ((model.infoRepo.faqsPaginated?.results ?? []).isEmpty) {
          model.getCarServices();
        }
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("FAQs").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : model.hasError
                  ? MainErrorWidget(
                      error: model.failure,
                      onRetry: model.getCarServices,
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: (model.infoRepo.faqsPaginated?.results ?? []).length,
                      separatorBuilder: (ctx, index) {
                        return const Divider(height: 0);
                      },
                      itemBuilder: (ctx, index) {
                        var item = model.infoRepo.faqsPaginated?.results?[index];
                        return ExpansionTile(
                          expandedAlignment: Alignment.centerLeft,
                          childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                          iconColor: AppColors.goldColor,
                          collapsedIconColor: AppColors.goldColor,
                          title: Text(
                            item?.question ?? "-",
                            style: const TextStyle(color: AppColors.goldColor, fontSize: 14),
                          ),
                          children: [
                            Text(
                              item?.answer ?? "-",
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
        );
      },
    );
  }
}

class FAQScreenModel extends BaseNotifier {
  FAQScreenModel({required this.infoRepo});
  final InfoRepo infoRepo;

  Future<void> getCarServices() async {
    setBusy();
    var res = await infoRepo.getFaqs();
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
    }
  }
}
