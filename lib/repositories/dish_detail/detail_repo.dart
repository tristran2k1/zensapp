import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zens_app/models/option_model.dart';

class DetailRepo {
  final optionSrc = 'assets/data/option_json.json';
  final sizeSrc = 'assets/data/size_json.json';
  final toppingSrc = 'assets/data/topping_json.json';

  Future<List<DrinkOption>> getOptions() async {
    final String response = await rootBundle.loadString(optionSrc);
    final data = await json.decode(response);
    final res = DrinkOption().fromJsonList(data);
    return res;
  }

  Future<List<DrinkOption>> getSizes() async {
    final String response = await rootBundle.loadString(sizeSrc);
    final data = await json.decode(response);
    final res = DrinkOption().fromJsonList(data);
    return res;
  }

  Future<List<DrinkOption>> getToppings() async {
    final String response = await rootBundle.loadString(toppingSrc);
    final data = await json.decode(response);
    final res = DrinkOption().fromJsonList(data);
    return res;
  }
}
