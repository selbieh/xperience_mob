import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class MainImageSlider extends StatefulWidget {
  const MainImageSlider({
    required this.items,
    this.displayIndecator = true,
    this.autoPlay = true,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 1,
    this.autoPlayInterval = 5,
    Key? key,
  }) : super(key: key);

  final List<Widget> items;
  final bool displayIndecator;
  final bool autoPlay;
  final double aspectRatio;
  final double viewportFraction;
  final int autoPlayInterval;
  @override
  MainImageSliderState createState() => MainImageSliderState();
}

class MainImageSliderState extends State<MainImageSlider> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: CarouselSlider(
            items: widget.items,
            options: CarouselOptions(
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              autoPlay: widget.autoPlay,
              aspectRatio: widget.aspectRatio,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayInterval: Duration(seconds: widget.autoPlayInterval),
              viewportFraction: widget.viewportFraction,
              onPageChanged: (index, reason) {
                currentPage = index;
                setState(() {});
              },
            ),
          ),
        ),
        if (widget.displayIndecator)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              // to increase indicator space from bottom
              const SizedBox(height: 0),
              ...buildPageIndicator(),
            ]),
          ),
      ],
    );
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.all(2),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : AppColors.greyText,
          border: isActive ? null : Border.all(color: AppColors.primaryColorLight, width: 0.5),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> buildPageIndicator() {
    List<Widget> indicatorList = [];
    for (int i = 0; i < widget.items.length; i++) {
      indicatorList.add(i == currentPage ? indicator(true) : indicator(false));
    }
    return indicatorList;
  }
}
