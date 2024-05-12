import 'package:flutter/material.dart';

class NavService {
  NavService._internal() {
    navigationKey = GlobalKey<NavigatorState>();
  }
  static final NavService _instance = NavService._internal();
  factory NavService() => _instance;

  late GlobalKey<NavigatorState> navigationKey;

  BuildContext context() {
    return navigationKey.currentContext!;
  }

  bool canPopKey() {
    return navigationKey.currentState?.canPop() ?? false;
  }

  void popKey([dynamic result]) {
    return navigationKey.currentState?.pop(result);
  }

  void popUntilKey({
    dynamic result,
    RouteSettings? settings,
  }) {
    return navigationKey.currentState?.popUntil(
      (route) {
        return route.settings.name == settings?.name;
      },
    );
  }

  Future<dynamic> pushKey(
    Widget page, {
    RouteSettings? settings,
  }) {
    final route = MaterialPageRoute(builder: (ctx) => page, settings: settings);
    return navigationKey.currentState!.push(route);
  }

  Future<dynamic> pushReplacementKey(
    Widget page, {
    RouteSettings? settings,
  }) {
    final route = MaterialPageRoute(builder: (ctx) => page, settings: settings);
    return navigationKey.currentState!.pushReplacement(route);
  }

  Future<dynamic> pushAndRemoveUntilKey(
    Widget page, {
    RouteSettings? settings,
  }) {
    // *** rootNavigator (true) to pushing contents above all subsequent instances ***
    // *** ( i used with CupertinoTabView to remove bottom bar from bottom ) ***
    final route = MaterialPageRoute(builder: (ctx) => page, settings: settings);
    return navigationKey.currentState!.pushAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
    );
  }
}
