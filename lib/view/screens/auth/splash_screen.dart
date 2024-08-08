import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/shared_preference.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/onbording_screen.dart';
import 'package:xperience/view/screens/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BaseWidget<SplashScreenViewModel>(
      model: SplashScreenViewModel(
        auth: Provider.of<AuthService>(context),
      ),
      initState: (model) {
        model.delayFun();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            color: AppColors.primaryColorDark,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SvgPicture.asset("assets/svgs/xperience_logo.svg"),
                  // FadeTransitionWidget(
                  //   milliseconds: 1500,
                  //   curve: Curves.easeInOut,
                  //   child: SvgPicture.asset("assets/svgs/xperience_logo.svg"),
                  // ),
                  Image.asset(
                    "assets/images/finaltransparancy.gif",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SplashScreenViewModel extends BaseNotifier {
  SplashScreenViewModel({required this.auth});
  final AuthService auth;

  void delayFun() {
    Future.delayed(const Duration(milliseconds: 4500), () async {
      await auth.loadUser();
      if (SharedPref.sharedPref?.getBool(SharedPrefKeys.isFirstLaunch) ?? false) {
        NavService().pushReplacementKey(const OnboardingScreen());
      } else {
        if (auth.isLogged) {
          NavService().pushReplacementKey(
            const MainScreen(),
            settings: const RouteSettings(name: RouteNames.mainScreen),
          );
        } else {
          NavService().pushReplacementKey(
            const MainScreen(),
            settings: const RouteSettings(name: RouteNames.mainScreen),
          );
        }
      }
    });
  }
}
