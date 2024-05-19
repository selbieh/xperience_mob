import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/main_textfield.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AboutScreenModel>(
      model: AboutScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("About"),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("FAQ"),
                    leading: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  Divider(height: 0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AboutScreenModel extends BaseNotifier {}
