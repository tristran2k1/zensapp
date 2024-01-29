import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  static getImagePng(
    String image, {
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    bool getTestImage = true,
    Alignment alignment = Alignment.center,
  }) {
    return pngAsset(
      image,
      height: height,
      width: width,
      fit: fit,
      color: color,
      alignment: alignment,
    );
  }

  static Widget pngAsset(
    String name, {
    Color? color,
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    bool circle = false,
    BoxFit? fit,
  }) {
    return Image.asset(
      name,
      color: color,
      alignment: alignment,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      errorBuilder: (context, error, _) {
        return Container();
      },
    );
  }

  static SvgPicture svgAssets(
    String name, {
    Color? color,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      name,
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
