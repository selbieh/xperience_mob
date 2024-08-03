// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/app_messenger.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/auth/login_screen.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';
import 'package:xperience/view/widgets/dialogs/message_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileScreenModel>(
      model: ProfileScreenModel(
        context: context,
        auth: Provider.of<AuthService>(context),
      ),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile").localize(context),
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
                    MainTextField(
                      controller: model.phoneController,
                      hint: "Phone".localize(context),
                      isReadOnly: true,
                      isFilled: true,
                      fillColor: AppColors.grey.withOpacity(0.5),
                      prefixIcon: const Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    MainTextField(
                      controller: model.nameController,
                      hint: "Name".localize(context),
                      validator: Validator.name,
                      keyboardType: TextInputType.name,
                      isFilled: true,
                      fillColor: AppColors.primaryColorLight,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset("assets/svgs/ic_fullname.svg"),
                      ),
                    ),
                    MainTextField(
                      controller: model.emailController,
                      hint: "E-mail".localize(context),
                      validator: Validator.email,
                      keyboardType: TextInputType.emailAddress,
                      isFilled: true,
                      fillColor: AppColors.primaryColorLight,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset("assets/svgs/ic_email.svg"),
                      ),
                    ),
                    const SizedBox(height: 40),
                    model.isBusy
                        ? const MainProgress()
                        : CustomButton(
                            title: "SAVE".localize(context),
                            onPressed: model.submitFun,
                          ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 100,
            child: Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: model.isDeleteLoading
                    ? const MainProgress()
                    : CustomButton(
                        title: "DELETE ACCOUNT".localize(context),
                        color: AppColors.red,
                        textStyle: const TextStyle(fontSize: 14, color: AppColors.red),
                        onPressed: model.confirmDeleteAccount,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileScreenModel extends BaseNotifier {
  ProfileScreenModel({required this.context, required this.auth}) {
    phoneController.text = auth.userModel?.user?.mobile ?? "";
    nameController.text = auth.userModel?.user?.name ?? "";
    emailController.text = auth.userModel?.user?.email ?? "";
  }
  final AuthService auth;
  final BuildContext context;

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  bool isDeleteLoading = false;

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
      DialogsHelper.messageDialog(
        type: MessageDialogType.success,
        message: "Profile updated successfully".tr(),
      );
    }
  }

  Future<void> confirmDeleteAccount() async {
    final result = await DialogsHelper.approveDialog(
      context,
      title: "Delete Account",
      subtitle: "Are you sure you want to delete your account?",
    );
    if (result != null) {
      deleteUserProfile();
    }
  }

  Future<void> deleteUserProfile() async {
    isDeleteLoading = true;
    setState();
    final res = await auth.deleteUserProfile(
      userId: auth.userModel?.user?.id ?? -1,
    );
    if (res.left != null) {
      isDeleteLoading = false;
      setError();
      DialogsHelper.messageDialog(message: "${res.left?.message}");
    } else {
      await auth.signOut();
      NavService().pushAndRemoveUntilKey(const LoginScreen());
      AppMessenger.snackBar(
        context: context,
        message: "Account deleted successfully".localize(context),
      );
      isDeleteLoading = false;
      setIdle();
    }
  }
}
