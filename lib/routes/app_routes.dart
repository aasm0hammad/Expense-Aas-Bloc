import 'package:ass_expense/ui/home_page.dart';
import 'package:ass_expense/ui/splash.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String ROUTE_SPLASH = '/';
  static const String ROUTE_HOME = 'home';

  static Map<String, WidgetBuilder> getRoutes() => {
        ROUTE_SPLASH: (context) => Splash(),
        ROUTE_HOME: (context) => HomePage(),
      };
}
