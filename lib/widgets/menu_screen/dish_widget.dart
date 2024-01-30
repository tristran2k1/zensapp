import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';

class DishWidget extends StatelessWidget {
  const DishWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: appDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/img_prod_1.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(16.sp),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Text(
                    '44.000đ',
                    style: text14.semiBold,
                  ),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(16.sp)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    onPressed: () {},
                    icon: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: appDecoration.orangeShadow.circle,
                      child: const Icon(
                        Icons.favorite_outline,
                        size: 17,
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Trà Đào mix Dứa",
                  style: text18.semiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Đào, chanh Quảng Đông, đường tinh luyện, hương nnn",
                  style: text14.graniteGray,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _textIcon(context, Svg.startIcon, "4.7"),
                        SizedBox(width: 32.w),
                        _textIcon(context, Svg.heartIcon, "4.7"),
                      ],
                    ),
                    _addButton(context),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _textIcon(BuildContext context, String startIcon, String value) {
    return Row(
      children: [
        ImageAssets.svgAssets(startIcon, width: 16.w, height: 16.h),
        SizedBox(width: 4.w),
        Text(
          value,
          style: text12.graniteGray,
        ),
      ],
    );
  }

  Widget _addButton(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Container(
        padding: const EdgeInsets.all(5),
        decoration: appDecoration.orangeBox.orangeShadow.copyWith(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.sp),
            bottomRight: Radius.circular(12.sp),
          ),
        ),
        child: ImageAssets.svgAssets(Svg.plusIcon, width: 21.w, height: 21.h),
      ),
    );
  }
}
