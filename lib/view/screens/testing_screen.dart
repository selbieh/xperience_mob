import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/view/widgets/components/main_button.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TestingScreenModel>(
      model: TestingScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Testing Screen")),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  title: "test",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TestingScreenModel extends BaseNotifier {}
