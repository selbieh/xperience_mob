import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/main_screen.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/have_problem_widget.dart';
import 'package:xperience/view/widgets/otp_widget.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<OTPScreenModel>(
      model: OTPScreenModel(),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyText,
                    ),
                  ),
                  SizedBox(height: 0.05.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svgs/vi_login.svg"),
                      const Text(
                        "Enter OTP",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text(
                        "We have sent OTP on your mobile number",
                        style: TextStyle(color: AppColors.greyText),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: OTPWidget(
                      codeLength: 4,
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
                  CustomButton(
                    title: "VERIFY",
                    onPressed: model.sendOtp,
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
  String pinCode = "";
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  Future<void> sendOtp() async {
    if (formKey.currentState!.validate()) {
      Logger.printObject(pinCode);
      NavService().pushAndRemoveUntilKey(const MainScreen());
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }
}
