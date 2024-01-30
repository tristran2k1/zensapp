import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class _keys {
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

  Future<List<String>> getCart() async {
    return _prefs.getStringList(_keys.cart) ?? [];
  }

  Future<void> updateCart(String id) async {
    final items = _prefs.getStringList(_keys.cart) ?? [];
    if (items.contains(id)) {
      _prefs.setStringList(
          _keys.cart, items.where((element) => element != id).toList());
    } else {
      _prefs.setStringList(_keys.cart, [...items, id]);
    }
  }
}
