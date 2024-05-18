import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';

class MoreTabScreen extends StatelessWidget {
  const MoreTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MoreTabViewModel>(
      model: MoreTabViewModel(context: context),
      builder: (_, model, child) {
        return const Scaffold(
          body: Center(child: Text("MoreTab Screen")),
        );
      },
    );
  }
}

class MoreTabViewModel extends BaseNotifier {
  final BuildContext context;
  MoreTabViewModel({required this.context});
}
