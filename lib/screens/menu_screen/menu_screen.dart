import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _header(context),
            _filter(context),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topRight,
          height: 150.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  blurRadius: 60,
                  spreadRadius: 60,
                  color: princetonOrange.withOpacity(0.3),
                  offset: Offset(100.w, 80.h))
            ],
          ),
        ),
        Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.symmetric(vertical: 20.h),
            child: ImageAssets.pngAsset(Png.menuBanner)),
        Container(
          margin: EdgeInsets.only(left: 27.w, top: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Trà', style: text40.medium),
              Text(
                "Mix",
                style: secondFont.copyWith(
                  fontSize: 68.sp,
                  color: outrageousOrange,
                ),
              ),
              Text('40 sự lựa chọn cho bạn', style: text16)
            ],
          ),
        )
      ],
    );
  }

  Widget _filter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Tìm kiếm theo:'),
              Text('Tìm kiếm theo:'),
            ],
          ),
          ImageAssets.svgAssets(Svg.cartIcon),
        ],
      ),
    );
  }
}
