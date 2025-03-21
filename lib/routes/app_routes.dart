import 'package:ass_expense/ui/home_page.dart';
import 'package:ass_expense/ui/login.dart';
import 'package:ass_expense/ui/singup.dart';
import 'package:ass_expense/ui/splash.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String ROUTE_SPLASH = '/';
  static const String ROUTE_LOGIN = 'login';
  static const String ROUTE_SIGNUP = 'signUp';
  static const String ROUTE_HOME = 'home';

  static Map<String, WidgetBuilder> getRoutes() => {
        ROUTE_SPLASH: (context) => Splash(),
        ROUTE_LOGIN: (context) => Login(),
        ROUTE_SIGNUP: (context) => Signup(),
        ROUTE_HOME: (context) => HomePage(),
      };
}
