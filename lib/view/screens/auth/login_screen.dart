import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/main_button.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                const Text(
                  "Login / Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyText,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svgs/login_victor.svg"),
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
                const SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mobile Number",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyText,
                      ),
                    ),
                    PhoneFormField(
                      controller: model.phoneController,
                      // initialValue: PhoneNumber.parse("+20"),
                      validator: PhoneValidator.compose([
                        PhoneValidator.required(context),
                        PhoneValidator.validMobile(context),
                      ]),
                      countrySelectorNavigator: const CountrySelectorNavigator.page(),
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
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      title: "SEND OTP",
                      onPressed: model.sendOtp,
                    ),
                  ],
                ),
                const SizedBox(),
                const SizedBox(),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      "Have a problem?",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.greyText,
                        fontSize: 12,
                      ),
                    ),
                    MainButton(
                      type: ButtonType.text,
                      radius: 10,
                      title: "Contact us",
                      color: AppColors.greyText,
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    required this.onPressed,
    super.key,
  });
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.goldColor),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColorLight,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}

class LoginScreenModel extends BaseNotifier {
  PhoneController? phoneController = PhoneController();

  Future<void> sendOtp() async {
    if (phoneController?.value.isValid() ?? false) {
      Logger.printObject(phoneController?.value.toJson());
    } else {
      Logger.printt("Not valid", isError: true);
    }
  }
}
