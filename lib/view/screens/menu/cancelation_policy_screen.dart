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

class CancelationPolicyScreen extends StatelessWidget {
  const CancelationPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CancelationPolicyScreenModel>(
      model: CancelationPolicyScreenModel(
        infoRepo: Provider.of<InfoRepo>(context),
      ),
      initState: (model) {
        if (model.infoRepo.cancellationPolicy == null) {
          model.getCancellationPolicy();
        }
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cancelation policy").localize(context),
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
                          data: """${model.infoRepo.cancellationPolicy?.content}""",
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}

class CancelationPolicyScreenModel extends BaseNotifier {
  CancelationPolicyScreenModel({required this.infoRepo});
  final InfoRepo infoRepo;

  Future<void> getCancellationPolicy() async {
    setBusy();
    var res = await infoRepo.getCancellationPolicy();
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      setIdle();
    }
  }
}



/*

    Html(
                data: """<div>
                            <h1>Cancelation policy Page</h1>
                            <p>This is a fantastic product that you should buy!</p>
                            <h3>Features</h3>
                            <ul>
                              <li>It actually works</li>
                              <li>It exists</li>
                              <li>It doesn't cost much!</li>
                            </ul>
                            <!--You can pretty much put any html in here!-->
                      </div>""",
              ),

*/