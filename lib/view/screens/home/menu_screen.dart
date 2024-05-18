import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/widgets/main_button.dart';
import 'package:xperience/view/widgets/main_image.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MenuViewModel>(
      model: MenuViewModel(),
      builder: (_, model, child) {
        return Drawer(
          backgroundColor: AppColors.primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.25.w),
                child: SvgPicture.asset("assets/svgs/xperience_logo.svg"),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    MainImage.network(
                      height: 40,
                      width: 40,
                      radius: 25,
                      imagePath: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text("Mohamed Ahmed", maxLines: 1),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),
              Expanded(
                child: SingleChildScrollView(
                  // physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      menuTitleItem("Account"),
                      menuItem(
                        title: "Wallet",
                        icon: "assets/svgs/ic_wallet.svg",
                        onTap: () {},
                      ),
                      menuItem(
                        title: "My reservations",
                        icon: "assets/svgs/ic_reservations.svg",
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      menuTitleItem("App"),
                      menuItem(
                        title: "About",
                        icon: "assets/svgs/ic_about.svg",
                        onTap: () {},
                      ),
                      menuItem(
                        title: "Help",
                        icon: "assets/svgs/ic_help.svg",
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      menuTitleItem("More"),
                      menuItem(
                        title: "Settings",
                        icon: "assets/svgs/ic_settings.svg",
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MainButton(
                  type: ButtonType.outlined,
                  width: double.infinity,
                  height: 55,
                  title: "LOGOUT",
                  color: AppColors.white,
                  radius: 10,
                  onPressed: () {
                    NavService().pushReplacementKey(const LoginScreen());
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Padding menuTitleItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.greyText, fontWeight: FontWeight.bold),
      ),
    );
  }

  ListTile menuItem({required String title, required String icon, Function()? onTap}) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      dense: true,
      title: Text(title),
      onTap: onTap,
    );
  }
}

class MenuViewModel extends BaseNotifier {}
