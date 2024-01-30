import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zens_app/models/drink_model.dart';
import 'package:zens_app/storages/share_preference.dart';

class MenuRepo {
  final source = 'assets/data/drink_json.json';
  Future<List<Drink>> getDrinks() async {
    final String response = await rootBundle.loadString(source);
    final data = await json.decode(response);
    var res = Drink().fromJsonList(data);
    final liked = await UserPrefs.I.getCart();
    for (var item in res) {
      item.isFavorite = liked.contains(item.id.toString());
    }
    return res;
  }
}
