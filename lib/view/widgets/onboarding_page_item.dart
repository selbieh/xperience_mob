import 'package:flutter/material.dart';
import 'package:xperience/model/config/size_config.dart';

class OnboardingPageItem extends StatelessWidget {
  const OnboardingPageItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    super.key,
  });
  final String imagePath;
  final String title;
  final String subtitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage(imagePath),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            // colorBlendMode: BlendMode.xor,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.transparent, Colors.black],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: double.infinity),
                SizedBox(height: 0.30.h),
                // SvgPicture.asset("assets/svgs/xperience_logo.svg", width: 80),
                 Image.asset("assets/images/xperience_logo.png", width: 100),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w300, height: 0),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, height: 0),
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
