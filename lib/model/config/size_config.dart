import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double height;
  static late double width;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double textSize;
  static late double respSize;
  static bool isPortrait = true;

  static void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    if (mediaQuery.orientation == Orientation.portrait) {
      height = mediaQuery.size.height;
      width = mediaQuery.size.width;
      blockSizeVertical = height / 100;
      blockSizeHorizontal = width / 100;
      textSize = (height / width) * 6;
      respSize = (height - width) * 1;
      isPortrait = true;
    } else {
      height = mediaQuery.size.height;
      width = mediaQuery.size.width;
      blockSizeVertical = height / 100;
      blockSizeHorizontal = width / 100;
      textSize = (width / height) * 6;
      respSize = (width - height) * 1;
      isPortrait = false;
    }
  }
}

extension SizeConfigExtension on double {
  double get w {
    return SizeConfig.width * this;
  }

  double get h {
    return SizeConfig.height * this;
  }
}
