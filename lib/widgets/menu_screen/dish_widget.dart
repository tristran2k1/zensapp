import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';
import 'package:zens_app/models/drink_model.dart';
import 'package:zens_app/routers/routes.dart';
import 'package:zens_app/storages/share_preference.dart';
import 'package:zens_app/widgets/common/icon_text_widget.dart';

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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
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
                    builder: (context, _, __) => InkWell(
                        onTap: () {
                          _isFavorite.value = !_isFavorite.value;
                          UserPrefs.I
                              .updateFavourites(widget.drink.id.toString());
                        },
                        child: Container(
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
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconText(
                          iconPath: Svg.startIcon,
                          text: widget.drink.getRating(),
                        ),
                        SizedBox(width: 32.w),
                        IconText(
                          iconPath: Svg.heartIcon,
                          text: widget.drink.getFavorite(),
                        ),
                      ],
                    ),
                    _addButton(context, widget.drink),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}

Widget _addButton(BuildContext context, Drink drink) {
  return InkWell(
    onTap: () => Navigator.pushNamed(context, RouterName.drinkDetailScreen,
        arguments: {'drink': drink}),
    child: Container(
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
