import 'dart:math';
import 'dart:ui';

///The number of device pixels for each logical pixel.
double get pixelRatio =>
    PlatformDispatcher.instance.views.first.physicalSize.aspectRatio;

Size get size =>
    PlatformDispatcher.instance.views.first.physicalSize / pixelRatio;

const guidelineBaseWidth = 375;
const guidelineBaseHeight = 812;

double kButtonRadius = 16;

double get scaleWidth => size.width / guidelineBaseWidth;

double get scaleHeight => size.height / guidelineBaseHeight;

double get scaleText => min(scaleWidth, scaleHeight);

extension ScreenExtension on num {
  double get w => this * scaleWidth; // Width Scale
  double get h => this * scaleHeight; // Height Scale
  double get sp => this * scaleText; // Text Scale
  double get r => this * scaleText; // Radius Scale
}
