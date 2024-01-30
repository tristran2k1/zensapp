import 'package:flutter/material.dart';
import 'package:zens_app/screens/drink_detail_screen/drink_detail_screen.dart';
import 'package:zens_app/screens/menu_screen/menu_screen.dart';

RouteFactory routes() {
  return (RouteSettings settings) {
    Widget screen = const SizedBox();

    var name = settings.name;

    switch (name) {
      case RouterName.drinkDetailScreen:
        screen = const DrinkDetailScreen();
        break;
      case RouterName.initScreen:
      default:
        // screen = const SplashScreen();
        screen = const MenuScreen();
        break;
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  };
}

abstract class RouterName {
  static const String initScreen = '/';
  static const String drinkDetailScreen = '/detail';
}
