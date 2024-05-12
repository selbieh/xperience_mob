import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double height;
  static late double width;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double textSize;
  static late double respSize;
  static bool isPortrait = true;

  ///==================================================================================
  ///======================== Initialize SizeConfig with BoxConstraints and Orientation
  // static void init(BoxConstraints constraints, Orientation orientation) {
  //   if (orientation == Orientation.portrait) {
  //     height = constraints.maxHeight;
  //     width = constraints.maxWidth;
  //     blockSizeVertical = height / 100;
  //     blockSizeHorizontal = width / 100;
  //     textSize = (height / width) * 6;
  //     respSize = (height - width) * 1;
  //     isPortrait = true;
  //   } else {
  //     height = constraints.maxHeight;
  //     width = constraints.maxWidth;
  //     blockSizeVertical = height / 100;
  //     blockSizeHorizontal = width / 100;
  //     textSize = (width / height) * 6;
  //     respSize = (width - height) * 1;
  //     isPortrait = false;
  //   }

  //   log("================================================");
  //   log("mainInitialize");
  //   log("isPortrait ===========> $isPortrait");
  //   log("height ===============> $height");
  //   log("width ================> $width");
  //   log("blockSizeVertical ====> $blockSizeVertical");
  //   log("blockSizeHorizontal ==> $blockSizeHorizontal");
  //   log("textSize =============> $textSize");
  // }

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
    // log("================================================");
    // log("init");
    // log("isPortrait ===========> $isPortrait");
    // log("height ===============> $width");
    // log("width ================> $height");
    // log("blockSizeVertical ====> $blockSizeVertical");
    // log("blockSizeHorizontal ==> $blockSizeHorizontal");
    // log("textSize =============> $textSize");
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
