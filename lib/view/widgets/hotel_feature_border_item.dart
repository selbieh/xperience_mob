import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class HotelFeatureBoarderItem extends StatelessWidget {
  const HotelFeatureBoarderItem({
    required this.title,
    this.image,
    super.key,
  });
  final String title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.grey,
            width: 0.5,
          )),
      child: Wrap(
        // runAlignment: WrapAlignment.center,
        // alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // SvgPicture.asset(image),
          if (image != null) ...[
            Image.network("$image"),
            const SizedBox(width: 10),
          ],
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
