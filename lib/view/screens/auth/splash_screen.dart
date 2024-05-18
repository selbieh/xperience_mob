import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/screens/home_screen.dart';
import 'package:xperience/view/widgets/animations/fade_transition_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BaseWidget<SplashScreenViewModel>(
      model: SplashScreenViewModel(auth: Provider.of<AuthService>(context)),
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
                  FadeTransitionWidget(
                    milliseconds: 1500,
                    curve: Curves.easeInOut,
                    child: SvgPicture.asset("assets/svgs/xperience_logo.svg"),
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
    Future.delayed(const Duration(milliseconds: 2000), () async {
      if (auth.isLogged) {
        await auth.loadUser();
        NavService().pushReplacementKey(const HomeScreen());
      } else {
        // NavService().pushReplacementKey(const OnboardingScreen());
        NavService().pushReplacementKey(const LoginScreen());
      }
    });
  }
}
