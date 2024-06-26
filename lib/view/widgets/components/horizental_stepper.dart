import 'package:flutter/material.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

class HorizentalStepper extends StatelessWidget {
  const HorizentalStepper({
    Key? key,
    required this.stepsTitleList,
    required this.currentStep,
    this.stepsSubtitleList,
    this.activeColor = AppColors.goldColor,
    this.disableColor = Colors.grey,
    this.currentStepColor = AppColors.goldColor,
    this.width = 200,
    this.strokeWidth = 2,
    this.pointSize = 20,
    this.radius = 20,
  }) : super(key: key);

  final List<String> stepsTitleList;
  final List<String>? stepsSubtitleList;
  final String currentStep;
  final double width;
  final double strokeWidth;
  final double pointSize;
  final double radius;
  final Color activeColor;
  final Color disableColor;
  final Color currentStepColor;

  @override
  Widget build(BuildContext context) {
    double stepLineWidth = (width - (pointSize * stepsTitleList.length)) / (stepsTitleList.length - 1) - 20;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                stepsTitleList.length,
                (index) {
                  int currentIndex = stepsTitleList.indexOf(currentStep);
                  bool isActive = currentIndex >= index;
                  bool isNotCurrent = currentIndex != index;
                  Color pointColor = isActive ? activeColor : disableColor;

                  if (index < stepsTitleList.length - 1) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildPoint(color: isNotCurrent ? pointColor : currentStepColor, index: index),
                        CustomPaint(
                          size: Size(stepLineWidth, 0),
                          painter: DashedLineHorizontalPainter(
                            isDashed: false,
                            color: isActive && isNotCurrent ? activeColor : disableColor,
                            strokeWidth: strokeWidth,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return buildPoint(color: isActive ? activeColor : disableColor, index: index);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              stepsTitleList.length,
              (index) {
                CrossAxisAlignment axisAlignment = index == 0
                    ? CrossAxisAlignment.start
                    : index == stepsTitleList.length - 1
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.center;
                return SizedBox(
                  width: width / stepsTitleList.length,
                  child: Column(
                    crossAxisAlignment: axisAlignment,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stepsTitleList[index].localize(context),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.grey,
                        ),
                      ),
                      if (stepsSubtitleList != null && stepsSubtitleList!.isNotEmpty && stepsSubtitleList!.length == stepsTitleList.length)
                        Text(
                          stepsSubtitleList![index],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 8),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildPoint({required Color color, required int index}) {
    return Container(
      height: pointSize,
      width: pointSize,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
          child: Text(
        "${index + 1}",
        style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 12),
      )),
    );
  }
}

class DashedLineHorizontalPainter extends CustomPainter {
  DashedLineHorizontalPainter({this.isDashed = true, this.strokeWidth = 2, this.color = Colors.grey});
  final bool isDashed;
  final Color color;
  final double strokeWidth;
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 7, dashSpace = isDashed ? 3 : 0, startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
