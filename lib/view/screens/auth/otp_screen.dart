import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/main_screen.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/have_problem_widget.dart';
import 'package:xperience/view/widgets/components/otp_widget.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({required this.mobile, Key? key}) : super(key: key);
  final String mobile;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<OTPScreenModel>(
      model: OTPScreenModel(
        auth: Provider.of<AuthService>(context),
        mobile: mobile,
      ),
      builder: (_, model, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 0.05.h),
                  const Text(
                    "OTP",
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyText),
                  ).localize(context),
                  SizedBox(height: 0.05.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svgs/vi_login.svg"),
                      const Text(
                        "Enter OTP",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ).localize(context),
                      const Text(
                        "We have sent OTP on your mobile number",
                        style: TextStyle(color: AppColors.greyText),
                      ).localize(context),
                    ],
                  ),
                  SizedBox(
                    child: OTPWidget(
                      codeLength: 6,
                      formKey: model.formKey,
                      autovalidateMode: model.autovalidateMode,
                      keyboardType: TextInputType.number,
                      // isFilled: false,
                      // fillColor: Colors.grey.shade300,
                      callbackFun: (value) {
                        model.pinCode = value;
                      },
                    ),
                  ),
                  SizedBox(height: 0.10.h),
                  model.isBusy
                      ? const MainProgress()
                      : CustomButton(
                          title: "VERIFY".localize(context),
                          onPressed: model.submitFun,
                        ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const HaveProblemWidget(),
        );
      },
    );
  }
}

class OTPScreenModel extends BaseNotifier {
  OTPScreenModel({required this.auth, required this.mobile});
  final AuthService auth;
  final String mobile;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String pinCode = "";

  void submitFun() async {
    if (formKey.currentState!.validate()) {
      sendOtp();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }

  Future<void> sendOtp() async {
    setBusy();
    final res = await auth.phoneVerify(
      body: {
        "mobile": mobile,
        "token": pinCode,
      },
    );
    if (res.left != null) {
      setError();
      DialogsHelper.messageDialog(message: "${res.left?.message}");
    } else {
      setIdle();
      NavService().pushAndRemoveUntilKey(const MainScreen());
    }
  }
}
