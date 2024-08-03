import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/models/user_model.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_button.dart';
import 'package:xperience/view/widgets/components/main_error_widget.dart';
import 'package:xperience/view/widgets/components/main_progress.dart';
import 'package:xperience/view/widgets/dialogs/dialogs_helper.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<WalletViewModel>(
      model: WalletViewModel(
        auth: Provider.of<AuthService>(context),
      ),
      initState: (model) {
        model.getUserProfile();
      },
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Wallet").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: model.isBusy
              ? const MainProgress()
              : model.hasError
                  ? MainErrorWidget(
                      error: model.failure,
                      onRetry: model.getUserProfile,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text("Available Credit").localize(context),
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(text: " "),
                                          TextSpan(
                                            // text: "3250",
                                            text: "${model.userInfo?.wallet ?? 0}",
                                            style: const TextStyle(fontSize: 30),
                                          ),
                                          const TextSpan(text: " "),
                                          TextSpan(
                                            text: "EGP".localize(context),
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                MainButton(
                                  type: ButtonType.outlined,
                                  radius: 20,
                                  color: AppColors.white,
                                  title: "Recharge".localize(context),
                                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColorLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset("assets/svgs/vi_crown.svg"),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // "2542",
                                          "${model.userInfo?.points ?? 0}",
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          "Points",
                                          style: TextStyle(color: AppColors.grey, fontSize: 12),
                                        ).localize(context),
                                      ],
                                    ),
                                  ),
                                  MainButton(
                                    type: ButtonType.outlined,
                                    radius: 20,
                                    color: AppColors.white,
                                    title: "Redeem".localize(context),
                                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                                    // onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "My transaction",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ).localize(context),
                            const SizedBox(height: 10),
                            Column(
                              children: List.generate(10, (index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColorLight,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Ride Trip",
                                              // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ).localize(context),
                                            const SizedBox(height: 5),
                                            const Text(
                                              "May 6 , 2022",
                                              style: TextStyle(color: AppColors.grey, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text("- \$103.56"),
                                    ],
                                  ),
                                );
                              }),
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

class WalletViewModel extends BaseNotifier {
  WalletViewModel({required this.auth});
  final AuthService auth;

  UserInfo? userInfo;

  Future<void> getUserProfile() async {
    setBusy();
    final res = await auth.getUserProfile(
      userId: auth.userModel?.user?.id ?? -1,
    );
    if (res.left != null) {
      failure = res.left?.message;
      DialogsHelper.messageDialog(message: "${res.left?.message}");
      setError();
    } else {
      userInfo = res.right;
      setIdle();
    }
  }
}
