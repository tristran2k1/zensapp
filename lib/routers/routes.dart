import 'package:flutter/material.dart';
import 'package:zens_app/repositories/menu_screen/menu_repo.dart';
import 'package:zens_app/screens/menu_screen/menu_screen.dart';

RouteFactory routes() {
  return (RouteSettings settings) {
    Widget screen = const SizedBox();

    var name = settings.name;

    switch (name) {
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
}
