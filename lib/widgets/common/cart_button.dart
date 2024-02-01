import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.value});
  final int value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: appDecoration,
        child: Stack(
          children: [
            Center(
              child: ImageAssets.svgAssets(
                Svg.cartIcon,
                width: 18.w,
                height: 18.h,
              ),
            ),
            Positioned(
              right: 0,
              top: -2,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    value.toString(),
                    style: text10.copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
