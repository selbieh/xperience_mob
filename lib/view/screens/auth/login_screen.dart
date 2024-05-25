import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/otp_screen.dart';
import 'package:xperience/view/screens/main_screen.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/have_problem_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginScreenModel>(
      model: LoginScreenModel(),
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
                    "Login / Register",
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
                        "Please Enter your Mobile number",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text(
                        "We will send you an OTP message",
                        style: TextStyle(color: AppColors.greyText),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.10.h),
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Mobile Number",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyText,
                      ),
                    ),
                  ),
                  PhoneFormField(
                    // initialValue: PhoneNumber.parse("+201009658566"),
                    // initialValue: PhoneNumber.parse("+20"),
                    controller: model.phoneController,
                    validator: PhoneValidator.compose([
                      PhoneValidator.required(context),
                      PhoneValidator.validMobile(context),
                    ]),
                    countrySelectorNavigator: CountrySelectorNavigator.dialog(
                      height: 0.60.h,
                      countries: [
                        IsoCode.EG,
                        IsoCode.SA,
                        IsoCode.AE,
                        IsoCode.JO,
                      ],
                    ),
                    onChanged: (phoneNumber) {
                      Logger.printt('changed into $phoneNumber');
                    },
                    enabled: true,
                    isCountrySelectionEnabled: true,
                    isCountryButtonPersistent: true,
                    countryButtonStyle: const CountryButtonStyle(
                      showDialCode: true,
                      showIsoCode: false,
                      showFlag: false,
                      flagSize: 20,
                    ),
                    style: const TextStyle(color: AppColors.greyText),
                    cursorColor: AppColors.greyText,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: "SEND OTP",
                    // onPressed: model.sendOtp,
                    onPressed: () {
                      NavService().pushReplacementKey(const OTPScreen());
                    },
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

class LoginScreenModel extends BaseNotifier {
  // PhoneController? phoneController = PhoneController(initialValue: const PhoneNumber(isoCode: IsoCode.EG, nsn: "1009658566"));
  PhoneController? phoneController = PhoneController(initialValue: PhoneNumber.parse("+201009658566"));

  Future<void> sendOtp() async {
    if (phoneController?.value.isValid() ?? false) {
      Logger.printObject(phoneController?.value.toJson());
      // NavService().pushKey(const OTPScreen());
      NavService().pushReplacementKey(const MainScreen());
    } else {
      Logger.printt("Not valid", isError: true);
    }
  }
}
