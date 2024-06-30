import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/screens/auth/splash_screen.dart';
import 'package:xperience/view/screens/menu/info_screen.dart';
import 'package:xperience/view/screens/menu/help_screen.dart';
import 'package:xperience/view/screens/menu/myreservations_screen.dart';
import 'package:xperience/view/screens/menu/profile_screen.dart';
import 'package:xperience/view/screens/menu/settings_screen.dart';
import 'package:xperience/view/screens/menu/wallet_screen.dart';
import 'package:xperience/view/screens/testing_screen.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/components/main_image.dart';
import 'package:xperience/view/widgets/menu_listtile_item.dart';
import 'package:xperience/view/widgets/menu_title_item.dart';

class MenuDrawerScreen extends StatelessWidget {
  const MenuDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MenuDrawerViewModel>(
      model: MenuDrawerViewModel(
        auth: Provider.of<AuthService>(context),
      ),
      builder: (_, model, child) {
        return Drawer(
          // backgroundColor: AppColors.primaryColorLight,
          backgroundColor: AppColors.primaryColorDark,
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
              // if (model.auth.isLogged)
              // InkWell(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //     child: Row(
              //       children: [
              //         Container(
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             border: Border.all(color: AppColors.goldColor, width: 3),
              //           ),
              //           child: const MainImage.network(
              //             height: 45,
              //             width: 45,
              //             radius: 25,
              //             imagePath: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
              //           ),
              //         ),
              //         const SizedBox(width: 10),
              //         Expanded(
              //           child: Text(
              //             model.auth.userModel?.user?.name ?? "-",
              //             maxLines: 1,
              //             style: const TextStyle(color: AppColors.goldColor),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   onTap: () {
              //     // NavService().pushKey(const WalletScreen());
              //   },
              // ),
              if (model.auth.isLogged)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.goldColor, width: 3),
                    ),
                    child: const MainImage.network(
                      height: 45,
                      width: 45,
                      radius: 25,
                      imagePath: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                    ),
                  ),
                  title: Text(
                    model.auth.userModel?.user?.name ?? "Profile".localize(context),
                    maxLines: 1,
                    style: const TextStyle(color: AppColors.goldColor),
                  ),
                  subtitle: (model.auth.userModel?.user?.email ?? "") == ""
                      ? null
                      : Text(
                          model.auth.userModel?.user?.email ?? "-",
                          maxLines: 2,
                        ),
                  onTap: () {
                    NavService().pushKey(const ProfileScreen());
                  },
                ),
              // const Divider(height: 0),
              const Divider(height: 0, color: AppColors.goldColor),
              Expanded(
                child: SingleChildScrollView(
                  // physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (model.auth.isLogged) ...[
                        const SizedBox(height: 20),
                        MenuTitleItem("Account".localize(context)),
                        MenuListTileItemWidget(
                          title: "Wallet".localize(context),
                          icon: "assets/svgs/ic_wallet.svg",
                          onTap: () {
                            NavService().pushKey(const WalletScreen());
                          },
                        ),
                        MenuListTileItemWidget(
                          title: "My reservations".localize(context),
                          icon: "assets/svgs/ic_reservations.svg",
                          onTap: () {
                            NavService().pushKey(const MyReservationsScreen());
                          },
                        ),
                      ],
                      const SizedBox(height: 20),
                      MenuTitleItem("App".localize(context)),
                      MenuListTileItemWidget(
                        // title: "About",
                        title: "Info".localize(context),
                        icon: "assets/svgs/ic_about.svg",
                        onTap: () {
                          NavService().pushKey(const InfoScreen());
                        },
                      ),
                      MenuListTileItemWidget(
                        title: "Help".localize(context),
                        icon: "assets/svgs/ic_help.svg",
                        onTap: () {
                          NavService().pushKey(const HelpScreen());
                        },
                      ),
                      const SizedBox(height: 20),
                      MenuTitleItem("More".localize(context)),
                      MenuListTileItemWidget(
                        title: "Settings".localize(context),
                        icon: "assets/svgs/ic_settings.svg",
                        onTap: () {
                          NavService().pushKey(const SettingsScreen());
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: MainButton(
                          title: "testing",
                          onPressed: () {
                            NavService().pushKey(const TestingScreen());
                          },
                        ),
                      ),
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
                  title: model.auth.isLogged ? "LOGOUT".localize(context) : "LOGIN".localize(context),
                  // color: AppColors.white,
                  color: AppColors.goldColor,
                  radius: 10,
                  onPressed: () async {
                    if (model.auth.isLogged) {
                      await model.auth.signOut();
                      NavService().pushAndRemoveUntilKey(const SplashScreen());
                    } else {
                      NavService().pushKey(const LoginScreen());
                    }
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
}

class MenuDrawerViewModel extends BaseNotifier {
  MenuDrawerViewModel({required this.auth});

  final AuthService auth;

  void logout() async {
    await auth.signOut();
    NavService().pushAndRemoveUntilKey(const SplashScreen());
  }
}
