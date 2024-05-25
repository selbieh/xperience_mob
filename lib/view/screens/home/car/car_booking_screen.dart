import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/router/nav_service.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/screens/home/car/complete_info_screen.dart';
import 'package:xperience/view/widgets/components/main_textfield.dart';
import 'package:xperience/view/widgets/custom_button.dart';

class CarBookingScreen extends StatelessWidget {
  const CarBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CarBookingViewModel>(
      model: CarBookingViewModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Booking Details"),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Extras",
                  style: TextStyle(color: AppColors.grey),
                ),
                const SizedBox(height: 10),
                MainTextField(
                  controller: model.extrasController,
                  validator: Validator.required,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  hint: "Please add whatever you want here",
                  borderWidth: 0.5,
                  maxLines: 5,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  title: "CONTINUE",
                  onPressed: () {
                    NavService().pushKey(const CompleteInfoScreen());
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CarBookingViewModel extends BaseNotifier {
  final extrasController = TextEditingController();
}
