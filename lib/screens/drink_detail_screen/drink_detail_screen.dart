import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zens_app/assets/index.dart';
import 'package:zens_app/models/cart_item.dart';
import 'package:zens_app/models/drink_model.dart';
import 'package:zens_app/models/option_model.dart';
import 'package:zens_app/repositories/dish_detail/detail_repo.dart';
import 'package:zens_app/storages/share_preference.dart';
import 'package:zens_app/widgets/common/icon_text_widget.dart';

class DrinkDetailScreen extends StatefulWidget {
  const DrinkDetailScreen({super.key, required this.drink});
  final Drink drink;

  @override
  State<DrinkDetailScreen> createState() => DrinkDetailScreenState();
}

class DrinkDetailScreenState extends State<DrinkDetailScreen> {
  final ValueNotifier<List<RadioModel>> _options = ValueNotifier([]);
  final ValueNotifier<List<RadioModel>> _sizes = ValueNotifier([]);
  final ValueNotifier<List<RadioModel>> _toppings = ValueNotifier([]);
  final ValueNotifier<int> _quantity = ValueNotifier(1);
  TotalPriceStream totalPriceStream = TotalPriceStream();

  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    DetailRepo().getOptions().then((value) {
      for (var option in value) {
        _options.value.add(RadioModel(isSelected: false, option: option));
      }
    });
    DetailRepo().getSizes().then((value) {
      for (int i = 0; i < value.length; i++) {
        if (i == 0) {
          _sizes.value.add(RadioModel(
            isSelected: true,
            option: value[i],
          ));
          continue;
        }
        _sizes.value.add(RadioModel(
          isSelected: false,
          option: value[i],
        ));
      }
    });
    DetailRepo().getToppings().then((value) {
      for (var option in value) {
        _toppings.value.add(RadioModel(isSelected: false, option: option));
      }
    });
    super.initState();
  }

  int getSelectedOptionIndex(List<RadioModel> options) {
    for (var opt in options) {
      if (opt.isSelected) {
        return opt.option.id ?? 0;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset(widget.drink.img ?? Png.tempCoverImg);
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));
    return Scaffold(
      body: Stack(
        children: [
          ImageAssets.pngAsset(widget.drink.img ?? Png.tempCoverImg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(),
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.sp,
                    vertical: 40.sp,
                  ),
                  child: const CartButton()),
            ],
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
          _orderSession(context),
        ],
      ),
    );
  }

  Align _orderSession(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: appDecoration.rectangle.copyWith(
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
            ValueListenableBuilder(
              valueListenable: _quantity,
              builder: (context, _, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _iconBtn(context, icon: Svg.minusIcon, onTap: () {
                    if (_quantity.value > 1) {
                      _quantity.value = _quantity.value - 1;
                    }
                  }),
                  SizedBox(width: 20.w),
                  Text(
                    _quantity.value.toString().padLeft(2, "0"),
                    style: text16.medium,
                  ),
                  SizedBox(width: 20.w),
                  _iconBtn(context, icon: Svg.plusIcon, onTap: () {
                    _quantity.value = _quantity.value + 1;
                  }),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            _addOrderBtn(context),
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
                        text: widget.drink.getRating(),
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
          _optionsList(context, options: _sizes.value, type: OptionType.size),
          _title(context, title: "Món ăn kèm"),
          _optionsList(context,
              options: _toppings.value, type: OptionType.topping),
          _title(context, title: "Yêu cầu thành phần"),
          _optionsList(context,
              options: _options.value, type: OptionType.option),
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

  SliverGrid _optionsList(
    BuildContext context, {
    required List<RadioModel> options,
    required OptionType type,
  }) {
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
                InkWell(
                    onTap: () {
                      // setState(() {
                      //   for (var element in options) {
                      //     element.isSelected = false;
                      //   }
                      //   options[index].isSelected = true;
                      // });
                      totalPriceStream.addItem(
                        CartItem(
                          id: widget.drink.id as int,
                          sizeid: getSelectedOptionIndex(_sizes.value),
                          toppingid: getSelectedOptionIndex(_toppings.value),
                          optionid: getSelectedOptionIndex(_options.value),
                          quantity: _quantity.value,
                        ),
                      );
                    },
                    child: RadioItem(item: options[index])),
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

  SliverToBoxAdapter _note(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: _noteController,
                focusNode: FocusNode(),
                style: text14,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "Ghi chú ở đây",
                  hintStyle: text14.copyWith(color: tourmaline),
                  isDense: true,
                  contentPadding: EdgeInsets.all(12.h),
                  fillColor: culturedPearl,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.h),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
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

  _iconBtn(
    BuildContext context, {
    required String icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: appDecoration.orangeBox.orangeShadow.circle,
        child: ImageAssets.svgAssets(icon, width: 21.w, height: 21.h),
      ),
    );
  }

  _addOrderBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        final size = getSelectedOptionIndex(_sizes.value);
        final tp = getSelectedOptionIndex(_toppings.value);
        final opt = getSelectedOptionIndex(_options.value);
        if (size != -1) {
          print("name: ${widget.drink.name}");
          print("Size: ${_sizes.value[size].option}");
          print("Topping: $tp");
          print("Topping: $opt");
          print("Quantity: ${_quantity.value}");
          UserPrefs.I.addOrder(
            CartItem(
              id: widget.drink.id,
              sizeid: size,
              toppingid: tp,
              optionid: opt,
              quantity: _quantity.value,
            ),
          );
          Navigator.pop(context);
        } else {
          const snackBar = SnackBar(
              content: Text('Bạn vui lòng chọn size!'),
              duration: Duration(seconds: 1));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: appDecoration.orangeBox.orangeShadow.circle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: appDecoration.circle,
              child: ImageAssets.svgAssets(Svg.orangeCartIcon),
            ),
            SizedBox(width: 4.w),
            StreamBuilder(
                stream: totalPriceStream.priceStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return Text(
                      'Thêm vào đơn - ${_getTotal(
                        snapshot.data ?? CartItem(id: widget.drink.id as int),
                        sizes: _sizes.value,
                        toppings: _toppings.value,
                        options: _options.value,
                        price: widget.drink.price ?? 0,
                      )}',
                      style: text14.semiBold.white,
                    );
                  } else {
                    return Text(
                      'Thêm vào đơn - ${widget.drink.getPrice()}',
                      style: text14.semiBold.white,
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

String _getTotal(
  CartItem data, {
  required List<RadioModel> sizes,
  required List<RadioModel> toppings,
  required List<RadioModel> options,
  required double price,
}) {
  var pSize, pTopping, pOption;
  if (data.sizeid == null ||
      data.sizeid == -1 ||
      (data.sizeid ?? 0) >= sizes.length) {
    pSize = sizes[0].option.price;
  } else {
    pSize = sizes[data.sizeid ?? 0].option.price;
  }

  if (data.toppingid == null || data.toppingid == -1) {
    pTopping = 0;
  } else {
    pTopping = toppings[data.toppingid ?? 0].option.price;
  }

  if (data.optionid == null || data.optionid == -1) {
    pOption = 0;
  } else {
    pOption = options[data.optionid ?? 0].option.price;
  }

  final total = (pSize + pTopping + pOption + price) * (data.quantity ?? 1);
  final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  final formattedNumber = numberFormat.format(total);
  return formattedNumber;
}

class BackButton extends StatelessWidget {
  const BackButton({
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

class CartButton extends StatefulWidget {
  const CartButton({super.key});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  final ValueNotifier<int> _counterOrder = ValueNotifier(0);

  @override
  void initState() {
    UserPrefs.I.getCart().then((value) {
      _counterOrder.value = value.length;
    });
    super.initState();
  }

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
                    _counterOrder.value.toString(),
                    style: text10.copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel item;

  const RadioItem({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: <Widget>[
            Icon(
              item.isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: outrageousOrange,
            ),
            SizedBox(width: 12.w),
            Text(item.option.name ?? "", style: text14),
          ],
        ),
        Text(item.option.getPrice(), style: text14),
      ],
    );
  }
}

class RadioModel {
  bool isSelected;
  final DrinkOption option;

  RadioModel({required this.isSelected, required this.option});
}

enum OptionType {
  size,
  topping,
  option,
}

class TotalPriceStream {
  CartItem item = CartItem();
  StreamController<CartItem> totalPrice = StreamController<CartItem>();
  Stream get priceStream => totalPrice.stream;

  void addItem(CartItem data) {
    item = data;
    totalPrice.sink.add(item);
  }
}
