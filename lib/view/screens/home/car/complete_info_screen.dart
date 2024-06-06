import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/car/checkout_screen.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';

class CompleteInfoScreen extends StatelessWidget {
  const CompleteInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CompleteInfoViewModel>(
      model: CompleteInfoViewModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Complete Information"),
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
                          textFieldTitile("Full name"),
                          const SizedBox(height: 5),
                          MainTextField(
                            controller: model.nameController,
                            hint: "Full name",
                            validator: Validator.name,
                            keyboardType: TextInputType.name,
                            borderWidth: 0.5,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(14),
                              child: SvgPicture.asset("assets/svgs/ic_fullname.svg"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          textFieldTitile("Email"),
                          const SizedBox(height: 5),
                          MainTextField(
                            controller: model.emailController,
                            hint: "E-mail",
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
                    title: "CHECKOUT",
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

  Text textFieldTitile(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.greyText,
        fontSize: 14,
      ),
    );
  }
}

class CompleteInfoViewModel extends BaseNotifier {
  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  void submitFun() {
    if (formKey.currentState!.validate()) {
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }
}
