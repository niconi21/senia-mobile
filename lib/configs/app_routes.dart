import 'package:flutter/material.dart';
import 'package:senia_app/models/models.dart';
import 'package:senia_app/screens/screens.dart';

class AppRoutes {
  static final initialRoute = 'auth';

  static final Map<String, MenuItemModel> routesApp = {
    "home": MenuItemModel(route: 'home', widget: HomeScreen()),
    "auth": MenuItemModel(route: 'auth', widget: AuthHomeScreen()),
    "lsm": MenuItemModel(route: 'lsm', widget: LsmHomeScreen()),
  };

  static Map<String, Widget Function(BuildContext)> getRoutesApp() {
    Map<String, Widget Function(BuildContext)> routes = {};

    for (var route in routesApp.values) {
      routes.addAll({route.route: (_) => route.widget});
    }
    return routes;
  }
}
