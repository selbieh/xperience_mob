import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/view/widgets/main_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeScreenModel>(
      model: HomeScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Home")),
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

class HomeScreenModel extends BaseNotifier {}
