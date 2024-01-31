import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';
import 'package:zens_app/models/drink_model.dart';
import 'package:zens_app/models/option_model.dart';
import 'package:zens_app/repositories/dish_detail/detail_repo.dart';
import 'package:zens_app/widgets/common/icon_text_widget.dart';

class DrinkDetailScreen extends StatefulWidget {
  const DrinkDetailScreen({super.key, required this.drink});
  final Drink drink;

  @override
  State<DrinkDetailScreen> createState() => DrinkDetailScreenState();
}

class DrinkDetailScreenState extends State<DrinkDetailScreen> {
  final ValueNotifier<List<DrinkOption>> _options = ValueNotifier([]);
  final ValueNotifier<List<DrinkOption>> _sizes = ValueNotifier([]);
  final ValueNotifier<List<DrinkOption>> _toppings = ValueNotifier([]);

  @override
  void initState() {
    DetailRepo().getOptions().then((value) {
      _options.value = value;
    });
    DetailRepo().getSizes().then((value) {
      _sizes.value = value;
    });
    DetailRepo().getToppings().then((value) {
      _toppings.value = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Image image =
        Image.asset(widget.drink.img ?? 'assets/images/img_prod_1.png');
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));
    return Scaffold(
      body: Stack(
        children: [
          ImageAssets.pngAsset(
            widget.drink.img ?? 'assets/images/img_prod_1.png',
          ),
          FutureBuilder<ui.Image>(
            future: completer.future,
            builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
              if (snapshot.hasData) {
                return _drinkDetailSession(context, snapshot.data?.height ?? 0);
              } else {
                return _drinkDetailSession(context, 0);
              }
            },
          ),
          _addOrder(context),
        ],
      ),
    );
  }

  Align _addOrder(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: appDecoration.noborder.copyWith(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: .5,
              blurRadius: 10,
              offset: const Offset(0, -1),
            )
          ],
        ),
        width: double.infinity,
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _updateNumber(context, icon: Svg.minusIcon, onTap: () {}),
                SizedBox(width: 20.w),
                Text('1'.padLeft(2, "0"), style: text16.medium),
                SizedBox(width: 20.w),
                _updateNumber(context, icon: Svg.plusIcon, onTap: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _drinkDetailSession(BuildContext context, int imgHeight) {
    return Container(
      margin: EdgeInsets.only(top: imgHeight * 0.33.h),
      decoration: appDecoration,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            clipBehavior: Clip.antiAlias,
            primary: false,
            toolbarHeight: 210.h,
            automaticallyImplyLeading: false,
            pinned: true,
            shadowColor: graniteGray,
            surfaceTintColor: whiteColor,
            title: Container(
              margin: EdgeInsets.only(top: 32.h, left: 8.w, right: 8.w),
              height: 180.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.drink.name ?? 'Trà', style: text24.semiBold),
                  SizedBox(height: 12.h),
                  Text(
                    widget.drink.description ?? '',
                    style: text14,
                    maxLines: 4,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconText(
                        iconPath: Svg.startIcon,
                        text: '4.5',
                        style: text14.semiBold,
                      ),
                      Row(
                        children: [
                          Text(
                            '59.000đ',
                            style: text14.copyWith(
                                decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: 12.w),
                          Text(widget.drink.getPrice(),
                              style: text24.semiBold.orange),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          _sliverSizedBox(height: 16.h),
          _title(context, title: "Chọn size", isRequired: true),
          _optionsList(context, _sizes.value),
          _title(context, title: "Món ăn kèm"),
          _optionsList(context, _toppings.value),
          _title(context, title: "Yêu cầu thành phần"),
          _optionsList(context, _options.value),
          _title(context, title: "Thêm lưu ý cho quán"),
          _note(context),
          _sliverSizedBox(height: 200.h)
        ],
      ),
    );
  }

  SliverToBoxAdapter _sliverSizedBox({double? height}) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height),
    );
  }

  SliverGrid _optionsList(BuildContext context, List<DrinkOption> options) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: double.infinity,
        childAspectRatio: 195.w / 356.h * 10,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabeledRadio(
                        groupValue: true,
                        value: _isRadioSelected,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isRadioSelected = newValue;
                          });
                        },
                        label: options[index].name ?? ""),
                    Text(options[index].getPrice(), style: text14),
                  ],
                ),
                SizedBox(height: 20.h),
                const Divider(height: 1, color: gainsboro),
              ],
            ),
          );
        },
        childCount: options.length,
      ),
    );
  }

  SliverToBoxAdapter _title(
    BuildContext context, {
    required String title,
    bool isRequired = false,
  }) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: text16.semiBold,
                ),
                Text(
                  isRequired ? '(Bắt buộc)' : '(Không bắt buộc)',
                  style: text14,
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  bool _isRadioSelected = false;

  SliverToBoxAdapter _note(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Việc thực hiện yêu cầu còn tùy thuộc vào khả năng của quán',
              style: text14,
            )
          ],
        ),
      ),
    );
  }

  _updateNumber(BuildContext context,
      {required String icon, VoidCallback? onTap}) {
    return IconButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(12.sp)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      ),
      onPressed: onTap,
      icon: Container(
        padding: const EdgeInsets.all(5),
        decoration: appDecoration.orangeBox.orangeShadow.circle,
        child: ImageAssets.svgAssets(icon, width: 21.w, height: 21.h),
      ),
    );
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    super.key,
    required this.label,
    this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets? padding;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: [
          Radio<bool>(
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            groupValue: groupValue,
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
            activeColor: outrageousOrange,
          ),
          SizedBox(width: 12.w),
          Text(label, style: text14),
        ],
      ),
    );
  }
}
