import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zens_app/models/cart_item.dart';

class _keys {
  static const String favourite = 'favourite';
  static const String cart = 'cart';
}

class UserPrefs {
  factory UserPrefs() => instance;
  UserPrefs._internal();

  static final UserPrefs instance = UserPrefs._internal();
  static UserPrefs get I => instance;
  late SharedPreferences _prefs;
  Future initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<String>> getFavourites() async {
    return _prefs.getStringList(_keys.favourite) ?? [];
  }

  Future<void> updateFavourites(String id) async {
    final items = _prefs.getStringList(_keys.favourite) ?? [];
    if (items.contains(id)) {
      _prefs.setStringList(
          _keys.favourite, items.where((element) => element != id).toList());
    } else {
      _prefs.setStringList(_keys.favourite, [...items, id]);
    }
  }

  Future<List<CartItem>> getCart() async {
    final items = _prefs.getStringList(_keys.cart) ?? [];
    return items.map((e) => CartItem.fromJson(json.decode(e))).toList();
  }

  Future<void> addOrder(CartItem item) async {
    final items = _prefs.getStringList(_keys.cart) ?? [];
    _prefs.setStringList(_keys.cart, [...items, json.encode(item.toJson())]);
  }
}
