import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/app_const.dart';
import 'package:xperience/model/services/launcher.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/menu/about_screen.dart';
import 'package:xperience/view/screens/menu/cancelation_policy_screen.dart';
import 'package:xperience/view/screens/menu/faq_screen.dart';
import 'package:xperience/view/screens/menu/privacy_policy_screen.dart';
import 'package:xperience/view/screens/menu/terms_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<InfoScreenModel>(
      model: InfoScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Info"),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        aboutItem(
                          "FAQ",
                          () {
                            NavService().pushKey(const FAQScreen());
                          },
                        ),
                        const Divider(height: 0, thickness: 0.2),
                        aboutItem(
                          "About",
                          () {
                            NavService().pushKey(const AboutScreen());
                          },
                        ),
                        const Divider(height: 0, thickness: 0.2),
                        aboutItem(
                          "Terms of use",
                          () {
                            NavService().pushKey(const TermsScreen());
                          },
                        ),
                        const Divider(height: 0, thickness: 0.2),
                        aboutItem(
                          "Privacy policy",
                          () {
                            NavService().pushKey(const PrivacyPolicyScreen());
                          },
                        ),
                        const Divider(height: 0, thickness: 0.2),
                        aboutItem(
                          "Cancelation policy",
                          () {
                            NavService().pushKey(const CancelationPolicyScreen());
                          },
                        ),
                        const Divider(height: 0, thickness: 0.2),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(25),
                      child: SvgPicture.asset("assets/svgs/vi_facebook.svg"),
                      onTap: () {
                        Launcher.launcherFun("https://www.facebook.com/", LaunchType.url);
                      },
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      borderRadius: BorderRadius.circular(25),
                      child: SvgPicture.asset("assets/svgs/vi_instagram.svg"),
                      onTap: () {
                        Launcher.launcherFun("https://www.instagram.com/", LaunchType.url);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Version  ${AppConst.appVersion}",
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
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      onTap: onTap,
    );
  }
}

class InfoScreenModel extends BaseNotifier {}
