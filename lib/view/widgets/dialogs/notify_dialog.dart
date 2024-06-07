import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class NotifyDialog extends StatelessWidget {
  const NotifyDialog({
    this.title,
    this.subtitle,
    this.leading,
    Key? key,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(milliseconds: 5000), () {
    //   Navigator.of(context).pop();
    // });
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            decoration: BoxDecoration(
              // color: Theme.of(context).dialogBackgroundColor,
              color: const Color(0xFF1A1D2E),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.goldColor, width: 0.25),
              boxShadow: const [
                BoxShadow(
                  // color: Colors.black26,
                  color: Colors.white24,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              minVerticalPadding: 0,
              leading: leading,
              title: title != null ? Text("$title") : null,
              subtitle: subtitle != null ? Text("$subtitle") : null,
              trailing: InkWell(
                child: const Icon(Icons.close),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: GestureDetector(onTap: () => Navigator.of(context).pop()),
          ),
        ],
      ),
    );
  }
}
