import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xperience/model/services/theme/app_colors.dart';

enum ProgressType { circular, linear }

class MainProgress extends StatelessWidget {
  final Color color;
  final double diameter;
  final double stroke;
  final ProgressType type;
  final double height;
  final double? linearWidth;

  const MainProgress({
    Key? key,
    // this.color = AppColors.primaryColorLight,
    this.color = AppColors.goldColor,
    this.stroke = 4,
    this.diameter = 35,
    this.height = 4,
    this.linearWidth,
    this.type = ProgressType.circular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget progress;
    switch (type) {
      case ProgressType.circular:
        progress = Center(
          child: SizedBox(
            height: diameter,
            width: diameter,
            child: Platform.isAndroid
                ? CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    strokeWidth: stroke,
                  )
                : CupertinoActivityIndicator(
                    radius: diameter * 0.5,
                  ),
          ),
        );
        break;
      case ProgressType.linear:
        progress = SizedBox(
          width: linearWidth,
          child: LinearProgressIndicator(
            minHeight: height,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        );
        break;
    }
    return progress;
  }
}
