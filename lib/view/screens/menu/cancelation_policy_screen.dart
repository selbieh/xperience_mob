import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class CancelationPolicyScreen extends StatelessWidget {
  const CancelationPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CancelationPolicyScreenModel>(
      model: CancelationPolicyScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cancelation policy").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: ListView(
            children: [
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
            ],
          ),
        );
      },
    );
  }
}

class CancelationPolicyScreenModel extends BaseNotifier {}
