import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/shared_preference.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TestingViewModel>(
      model: TestingViewModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Testing Screen")),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainTextField(
                  controller: model.fcmController,
                  label: "FCM  Token",
                  isFilled: true,
                  isReadOnly: true,
                  fillColor: AppColors.primaryColorLight,
                  maxLines: 10,
                ),
                // MainButton(
                //   title: "test",
                //   onPressed: () {},
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TestingViewModel extends BaseNotifier {
  TestingViewModel() {
    fcmController.text = SharedPref.getString(SharedPrefKeys.fcmToken) ?? "";
  }
  final fcmController = TextEditingController();
}
