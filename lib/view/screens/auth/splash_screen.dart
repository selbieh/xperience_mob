import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/auth/local_auth_service.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/router/route_names.dart';
import 'package:xperience/model/services/shared_preference.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
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
        localAuth: LocalAuthService(),
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
                  const SizedBox(),
                  Image.asset(
                    "assets/images/finaltransparancy.gif",
                  ),
                  if (model.isLocalAuthAutinticaed == false)
                    Center(
                      child: IconButton(
                        icon: const Icon(Icons.lock_open, size: 50),
                        onPressed: () {
                          model.handleBiometricAuthentication();
                        },
                      ),
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
  SplashScreenViewModel({
    required this.auth,
    required this.localAuth,
  });
  final AuthService auth;
  final LocalAuthService localAuth;
  bool? isLocalAuthAutinticaed;

  void delayFun() {
    Future.delayed(const Duration(milliseconds: 4500), () async {
      await auth.loadUser();
      if (SharedPref.sharedPref?.getBool(SharedPrefKeys.isFirstLaunch) ?? false) {
        NavService().pushReplacementKey(const OnboardingScreen());
      } else {
        if (auth.isLogged) {
          handleBiometricAuthentication();
        } else {
          NavService().pushReplacementKey(const LoginScreen(isGuest: true));
        }
      }
    });
  }

  goToHome() {
    NavService().pushReplacementKey(
      const MainScreen(),
      settings: const RouteSettings(name: RouteNames.mainScreen),
    );
  }

  Future<void> handleBiometricAuthentication() async {
    final isDeviceSupport = await localAuth.isDeviceSupported();
    final isHasBiometrics = await localAuth.isCanCheckBiometrics();
    if (isHasBiometrics && isDeviceSupport) {
      final isAuthenticated = await localAuth.authenticate();
      if (isAuthenticated) {
        goToHome();
      } else {
        Logger.log("Not Autinticaed");
        isLocalAuthAutinticaed = false;
        setState();
      }
    } else {
      goToHome();
    }
  }
}

/*
[log] biometricsList: []
[log] isDeviceSupported: false
[log] isCanAuthenticateWithBiometrics: true


[log] biometricsList: []
[log] isDeviceSupported: true
[log] isCanAuthenticateWithBiometrics: true

*/