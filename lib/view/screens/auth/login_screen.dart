import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/config/size_config.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/otp_screen.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/have_problem_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginScreenViewModel>(
      model: LoginScreenViewModel(
        auth: Provider.of<AuthService>(context),
      ),
      builder: (_, model, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: model.formKey,
                autovalidateMode: model.autovalidateMode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 0.05.h),
                    const Text(
                      "Login / Register",
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyText),
                    ).localize(context),
                    SizedBox(height: 0.05.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svgs/vi_login.svg"),
                        const Text(
                          "Please Enter your Mobile number",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ).localize(context),
                        const Text(
                          "We will send you an OTP message",
                          style: TextStyle(color: AppColors.greyText),
                        ).localize(context),
                      ],
                    ),
                    SizedBox(height: 0.10.h),
                     Align(
                      alignment: AlignmentDirectional.topStart,
                      child: const Text(
                        "Mobile Number",
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyText),
                      ).localize(context),
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
                      // onChanged: (phoneNumber) {
                      //   Logger.printt('changed into $phoneNumber');
                      // },
                      enabled: true,
                      isCountrySelectionEnabled: true,
                      isCountryButtonPersistent: true,
                      countryButtonStyle: const CountryButtonStyle(
                        showDialCode: true,
                        showIsoCode: false,
                        showFlag: true,
                        flagSize: 20,
                      ),
                      style: const TextStyle(color: AppColors.greyText),
                      cursorColor: AppColors.greyText,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    ),
                    const SizedBox(height: 20),
                    model.isBusy
                        ? const MainProgress()
                        : CustomButton(
                            title: "SEND OTP".localize(context),
                            onPressed: model.submitFun,
                          ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: const HaveProblemWidget(),
        );
      },
    );
  }
}

class LoginScreenViewModel extends BaseNotifier {
  LoginScreenViewModel({required this.auth});
  final AuthService auth;

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  // PhoneController? phoneController = PhoneController(initialValue: PhoneNumber.parse("+20"));
  PhoneController? phoneController = PhoneController(initialValue: PhoneNumber.parse("+201009658566"));

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
    final res = await auth.phoneLoginRegister(
      body: {
        "mobile": phoneController?.value.international,
      },
    );
    if (res.left != null) {
      setError();
      // failure = res.left?.message;
      // DialogsHelper.messageDialog(message: "${res.left?.message}");
      NavService().pushKey(OTPScreen(mobile: "${phoneController?.value.international}")); // Temp
    } else {
      setIdle();
      NavService().pushKey(OTPScreen(mobile: "${phoneController?.value.international}"));
    }
  }
}
