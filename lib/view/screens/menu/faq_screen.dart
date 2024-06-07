import 'package:flutter/material.dart';
import 'package:xperience/model/base/base_notifier.dart';
import 'package:xperience/model/base/base_widget.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FAQScreenModel>(
      model: FAQScreenModel(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("FAQs").localize(context),
            backgroundColor: AppColors.primaryColorDark,
          ),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 7,
            separatorBuilder: (ctx, index) {
              return const Divider(height: 0);
            },
            itemBuilder: (ctx, index) {
              return const ExpansionTile(
                expandedAlignment: Alignment.centerLeft,
                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                iconColor: AppColors.goldColor,
                collapsedIconColor: AppColors.goldColor,
                title: Text(
                  "How can I make a hotel reservation?",
                  style: TextStyle(color: AppColors.goldColor, fontSize: 14),
                ),
                children: [
                  Text(
                    "You can make a hotel reservation through our website or mobile app by entering your destination, travel dates, and the number of guests. Select your preferred hotel from the search results and follow the booking process.",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class FAQScreenModel extends BaseNotifier {}
