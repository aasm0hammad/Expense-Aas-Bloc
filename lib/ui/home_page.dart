import 'package:ass_expense/ui/BottomNavigationBar_ui/Nav_Statics.dart';
import 'package:ass_expense/ui/BottomNavigationBar_ui/nav_home.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  List<Widget> bottomNavPage=[
    NavHomePage(),
    NavStaticsPage(),
    NavHomePage(),
    NavStaticsPage(),
    NavProfilePage(),

  ];
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:bottomNavPage[selectedIndex],
        bottomNavigationBar:
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black54,
            selectedItemColor: Colors.pinkAccent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Statics"),
          BottomNavigationBarItem(icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,

                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(Icons.add,color: Colors.white,)), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        currentIndex: selectedIndex,
          onTap: (value){
              selectedIndex=value;
              setState(() {

              });
          },
        ),

    );
  }
}

class NavProfilePage  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text("nsjjnssnmsncmcnsnjscnscn"),
    );
  }
}




