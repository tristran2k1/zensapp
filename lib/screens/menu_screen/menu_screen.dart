import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';
import 'package:zens_app/widgets/menu_screen/dish_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: culturedPearl,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _header(context),
            _filter(context),
            SizedBox(height: 16.h),
            _listDishes(context),
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
            margin: EdgeInsets.only(top: 20.h),
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

  final items = ['Nổi bật', 'Yêu thích', 'Bình chọn'];
  Widget _filter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Tìm kiếm theo:', style: text14),
              _dropdownWiget(context),
            ],
          ),
          _yourCart(context),
        ],
      ),
    );
  }

  Widget _yourCart(BuildContext context) {
    return Container(
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
          )),
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
                  '2',
                  style: text10.copyWith(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  Widget _listDishes(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10.h);
          },
          itemCount: 5,
          itemBuilder: (context, index) {
            return const DishWidget();
          }),
    );
  }

  Widget _dropdownWiget(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: DropdownButton(
        value: items[0],
        menuMaxHeight: 200.h,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        isExpanded: true,
        items: items
            .map((e) => DropdownMenuItem(
                  alignment: Alignment.center,
                  value: e,
                  child: Text(e, style: text14.orange),
                ))
            .toList(),
        underline: const SizedBox(),
        onChanged: (value) {},
      ),
    );
  }
}
