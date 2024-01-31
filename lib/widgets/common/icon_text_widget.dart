import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';

class IconText extends StatelessWidget {
  const IconText(
      {super.key, required this.iconPath, required this.text, this.style});
  final String iconPath;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageAssets.svgAssets(
          iconPath,
          width: 16.w,
          height: 16.h,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: style ?? text12.graniteGray,
        ),
      ],
    );
  }
}
