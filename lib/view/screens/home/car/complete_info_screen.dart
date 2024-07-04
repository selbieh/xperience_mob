import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/car/checkout_screen.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class CompleteInfoScreen extends StatelessWidget {
  const CompleteInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CompleteInfoViewModel>(
      model: CompleteInfoViewModel(
        auth: Provider.of<AuthService>(context),
      ),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Complete Information").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Form(
            key: model.formKey,
            autovalidateMode: model.autovalidateMode,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Full name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.greyText,
                              fontSize: 14,
                            ),
                          ).localize(context),
                          const SizedBox(height: 5),
                          MainTextField(
                            controller: model.nameController,
                            hint: "Full name".localize(context),
                            validator: Validator.name,
                            keyboardType: TextInputType.name,
                            borderWidth: 0.5,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(14),
                              child: SvgPicture.asset("assets/svgs/ic_fullname.svg"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Email",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.greyText,
                              fontSize: 14,
                            ),
                          ).localize(context),
                          const SizedBox(height: 5),
                          MainTextField(
                            controller: model.emailController,
                            hint: "E-mail".localize(context),
                            validator: Validator.email,
                            keyboardType: TextInputType.emailAddress,
                            borderWidth: 0.5,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(14),
                              child: SvgPicture.asset("assets/svgs/ic_email.svg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    title: "CHECKOUT".localize(context),
                    onPressed: () {
                      NavService().pushKey(const CheckoutScreen());
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CompleteInfoViewModel extends BaseNotifier {
  CompleteInfoViewModel({required this.auth});
  final AuthService auth;

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void submitFun() {
    if (formKey.currentState!.validate()) {
      updateProfile();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }

  Future<void> updateProfile() async {
    setBusy();
    final res = await auth.updateUserProfile(
      userId: auth.userModel?.user?.id ?? -1,
      body: {
        "name": nameController.text,
        "email": emailController.text,
      },
    );
    if (res.left != null) {
      setError();
      DialogsHelper.messageDialog(message: "${res.left?.message}");
    } else {
      setIdle();
      NavService().popKey(true);
    }
  }
}
