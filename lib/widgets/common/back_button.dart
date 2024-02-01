import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 40.sp),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: appDecoration,
          child: Center(
              child: ImageAssets.svgAssets(
            Svg.leftArrowIcon,
            width: 8.w,
            height: 16.h,
          )),
        ),
      ),
    );
  }
}
