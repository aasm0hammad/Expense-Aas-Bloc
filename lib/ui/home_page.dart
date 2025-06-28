import 'package:ass_expense/ui/BottomNavigationBar_ui/Nav_Statics.dart';
import 'package:ass_expense/ui/BottomNavigationBar_ui/nav_home.dart';
import 'package:ass_expense/ui/BottomNavigationBar_ui/nav_profile.dart';
import 'package:ass_expense/ui/add_expense.dart';
import 'package:ass_expense/ui/login_signup/login.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  List<Widget> bottomNavPage=[
    NavHomePage(),
    NavStaticsPage(),
    NavHomePage(),
    NavHomePage(),
    NavProfilePage(),

  ];
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(selectedIndex!=0){
          setState(() {
            selectedIndex=0;
          });
          return false;

        }
        return true;

      },
      child: Scaffold(
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
            BottomNavigationBarItem(icon: InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>AddExpense()));
              },
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
              
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(Icons.add,color: Colors.white,)),
            ), label: "Add"),
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

      ),
    );
  }
}





