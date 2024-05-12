import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///============================== init Size Config
    SizeConfig.init(context);

    return BaseWidget<SplashScreenViewModel>(
      model: SplashScreenViewModel(auth: Provider.of<AuthService>(context)),
      initState: (model) {
        model.delayFun();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            color: AppColors.primaryColor,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Logo"),
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
    Future.delayed(const Duration(milliseconds: 1500), () async {
      if (auth.isLogged) {
        await auth.loadUser();
        goToHome();
      } else {
        goToHome();
      }
    });
  }

  void goToHome() {
    // NavService().pushAndRemoveUntilKey(
    //   const HomeScreen(),
    //   settings: const RouteSettings(name: RouteNames.homeScreen),
    // );
  }
}
