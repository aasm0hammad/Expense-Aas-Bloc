import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_routes.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), ()async {

      var pref=await SharedPreferences.getInstance();

      int userId=pref.getInt("key")??0;


      if(userId>0){
        Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_HOME);
      }else{
        Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_LOGIN);

      }
       });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ClipOval(
            child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
              height: 200,
              width: 200,
                  ),
          )),
    );
  }
}
