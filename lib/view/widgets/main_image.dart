import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xperience/model/services/theme/app_colors.dart';
import 'package:xperience/view/widgets/main_progress.dart';

enum ImageType {
  network,
  cached,
  asset,
  file,
  memory,
}

class MainImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final double? radius;
  final double? opacity;
  final double progressDiameter;
  final double progressStroke;
  final BoxFit? fit;
  final Widget? errorWidget;
  final String? placeholderPath;
  final ImageType imageType;

  const MainImage.network({
    required this.imagePath,
    this.width,
    this.height,
    this.radius = 0,
    this.opacity = 1,
    this.fit = BoxFit.contain,
    this.progressDiameter = 35,
    this.progressStroke = 2,
    this.errorWidget,
    this.placeholderPath,
    super.key,
  }) : imageType = ImageType.network;

  const MainImage.cached({
    required this.imagePath,
    this.width,
    this.height,
    this.radius = 0,
    this.opacity = 1,
    this.fit = BoxFit.contain,
    this.progressDiameter = 35,
    this.progressStroke = 2,
    this.errorWidget,
    this.placeholderPath,
    super.key,
  }) : imageType = ImageType.cached;

  const MainImage.asset({
    required this.imagePath,
    this.width,
    this.height,
    this.radius = 0,
    this.opacity = 1,
    this.fit = BoxFit.contain,
    this.errorWidget,
    this.placeholderPath,
    super.key,
  })  : imageType = ImageType.asset,
        progressDiameter = 0,
        progressStroke = 0;

  const MainImage.file({
    required this.imagePath,
    this.width,
    this.height,
    this.radius = 0,
    this.opacity = 1,
    this.fit = BoxFit.contain,
    this.errorWidget,
    this.placeholderPath,
    super.key,
  })  : imageType = ImageType.file,
        progressDiameter = 0,
        progressStroke = 0;

  const MainImage.memory({
    required this.imagePath,
    this.width,
    this.height,
    this.radius = 0,
    this.opacity = 1,
    this.fit = BoxFit.contain,
    this.errorWidget,
    this.placeholderPath,
    super.key,
  })  : imageType = ImageType.memory,
        progressDiameter = 0,
        progressStroke = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Opacity(
          opacity: opacity!,
          child: _getImage(),
        ),
      ),
    );
  }

  Widget _getImage() {
    final brokenImageIcon = Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius!), border: Border.all(color: Colors.grey)),
      child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
    );

    switch (imageType) {
      ///======================================================================= [ cached ]
      case ImageType.cached:
        return CachedNetworkImage(
          imageUrl: imagePath,
          fit: fit,
          errorWidget: (_, obj, trace) {
            return placeholderPath != null ? Image.asset(placeholderPath!, fit: fit) : errorWidget ?? brokenImageIcon;
          },
          progressIndicatorBuilder: (context, url, progress) {
            return Center(
                child: MainProgress(
              color: AppColors.primaryColorLight,
              stroke: progressStroke,
              diameter: progressDiameter,
            ));
          },
        );

      ///======================================================================= [ network ]
      case ImageType.network:
        return Image.network(
          imagePath,
          fit: fit,
          errorBuilder: (_, obj, trace) {
            return placeholderPath != null ? Image.network(placeholderPath!, fit: fit) : errorWidget ?? brokenImageIcon;
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                  child: MainProgress(
                color: AppColors.primaryColorLight,
                stroke: progressStroke,
                diameter: progressDiameter,
              ));
            }
          },
        );

      ///======================================================================= [ asset ]
      case ImageType.asset:
        return Image.asset(
          imagePath,
          fit: fit,
          errorBuilder: (_, obj, trace) {
            return placeholderPath != null ? Image.asset(placeholderPath!, fit: fit) : errorWidget ?? brokenImageIcon;
          },
        );

      ///======================================================================= [ file ]
      case ImageType.file:
        return Image.file(
          File(imagePath),
          fit: fit,
          errorBuilder: (_, obj, trace) {
            return placeholderPath != null ? Image.asset(placeholderPath!, fit: fit) : errorWidget ?? brokenImageIcon;
          },
        );

      ///======================================================================= [ memory ]
      case ImageType.memory:
        String placeholder = imagePath;
        placeholder = placeholder.replaceAll(" ", "");
        if (placeholder.length < 20) {
          if (placeholder.length % 4 > 0) {
            placeholder += '=' * (4 - placeholder.length % 4);
          }
        }
        return Image.memory(
          // *** image Base 64 string ***
          // const Base64Decoder().convert(imagePath),
          const Base64Decoder().convert((placeholder).split(',').last),
          fit: fit,
          errorBuilder: (_, obj, trace) {
            return placeholderPath != null ? Image.asset(placeholderPath!, fit: fit) : errorWidget ?? brokenImageIcon;
          },
        );
    }
  }
}
