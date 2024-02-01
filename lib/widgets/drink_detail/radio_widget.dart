import 'package:flutter/material.dart';
import 'package:zens_app/assets/index.dart';
import 'package:zens_app/models/option_model.dart';

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
