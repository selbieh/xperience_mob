import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HelpScreenModel>(
      model: HelpScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Help"),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Form(
            key: model.formKey,
            autovalidateMode: model.autovalidateMode,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "How can we help you?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyText,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30),
                    textFieldTitile("Full name"),
                    const SizedBox(height: 5),
                    MainTextField(
                      controller: model.nameController,
                      hint: "Full name",
                      validator: Validator.name,
                      keyboardType: TextInputType.name,
                      isFilled: true,
                      fillColor: AppColors.primaryColorLight,
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
                      isFilled: true,
                      fillColor: AppColors.primaryColorLight,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset("assets/svgs/ic_email.svg"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    textFieldTitile("Message"),
                    const SizedBox(height: 5),
                    MainTextField(
                      controller: model.messageController,
                      validator: Validator.required,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      hint: "Write here!",
                      isFilled: true,
                      fillColor: AppColors.primaryColorLight,
                      maxLines: 7,
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      title: "SEND",
                      onPressed: model.submitFun,
                    )
                  ],
                ),
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

class HelpScreenModel extends BaseNotifier {
  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  void submitFun() {
    if (formKey.currentState!.validate()) {
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }
}
