import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';
import 'package:zens_app/models/drink_model.dart';
import 'package:zens_app/storages/share_preference.dart';

class DishWidget extends StatefulWidget {
  const DishWidget({super.key, required this.drink});
  final Drink drink;

  @override
  State<DishWidget> createState() => _DishWidgetState();
}

class _DishWidgetState extends State<DishWidget> {
  final ValueNotifier<bool> _isFavorite = ValueNotifier(false);
  @override
  void initState() {
    _isFavorite.value = widget.drink.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w).copyWith(bottom: 24.h),
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
              image: DecorationImage(
                image: AssetImage(
                  widget.drink.img ?? 'assets/images/img_prod_1.png',
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
                    widget.drink.getPrice(),
                    style: text14.semiBold,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _isFavorite,
                  builder: (context, _, __) => IconButton(
                      padding: EdgeInsets.zero,
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(16.sp)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                      onPressed: () {
                        _isFavorite.value = !_isFavorite.value;
                        UserPrefs.I.updateCart(widget.drink.id.toString());
                      },
                      icon: Container(
                        width: 32.w,
                        height: 32.h,
                        padding: EdgeInsets.all(7.sp),
                        decoration: appDecoration.orangeShadow.circle,
                        child: _isFavorite.value
                            ? ImageAssets.svgAssets(Svg.heartIcon)
                            : ImageAssets.svgAssets(Svg.heartOutlineIcon),
                      )),
                )
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
                  widget.drink.name ?? "Trà Mix",
                  style: text18.semiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.drink.description ?? "Trà Mix",
                  style: text14.graniteGray,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _textIcon(
                            context, Svg.startIcon, widget.drink.getRating()),
                        SizedBox(width: 32.w),
                        _textIcon(
                            context, Svg.heartIcon, widget.drink.getFavorite()),
                      ],
                    ),
                    _addButton(context),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }

  Widget _textIcon(BuildContext context, String startIcon, String value) {
    return Row(
      children: [
        ImageAssets.svgAssets(
          startIcon,
          width: 16.w,
          height: 16.h,
        ),
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
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(12.sp)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      ),
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
