import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/menu/help_screen.dart';

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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        aboutItem("FAQ", () => NavService().pushKey(const HelpScreen())),
                        const Divider(height: 0, thickness: 0.2),
                        aboutItem("Privacy Policy", () => NavService().pushKey(const HelpScreen())),
                        const Divider(height: 0, thickness: 0.2),
                        aboutItem("Terms of use", () => NavService().pushKey(const HelpScreen())),
                        const Divider(height: 0, thickness: 0.2),
                        aboutItem("Cancelation Policy", () => NavService().pushKey(const HelpScreen())),
                        const Divider(height: 0, thickness: 0.2),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svgs/vi_facebook.svg"),
                    const SizedBox(width: 20),
                    SvgPicture.asset("assets/svgs/vi_instagram.svg"),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Version  3.2.1",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyText,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile aboutItem(String title, Function()? onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.greyText,
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.greyText,
      ),
      dense: true,
      contentPadding: const EdgeInsets.only(top: 10),
      onTap: onTap,
    );
  }
}

class AboutScreenModel extends BaseNotifier {}
