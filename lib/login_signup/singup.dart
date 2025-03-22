import 'package:ass_expense/DataBase/model/users_model.dart';
import 'package:ass_expense/login_signup/register/user_bloc.dart';
import 'package:ass_expense/login_signup/register/user_event.dart';
import 'package:ass_expense/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';

class Signup extends StatelessWidget {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
        child: Column(
          children: [
            Center(
                child: Text(
                  "SIGN UP",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 25),
                )),
            Text(
              "Create your Account ",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 100,
            ),
             user("username", Icon(Icons.person, ),nameController),
            SizedBox(
              height: 20,
            ),
            user("email", Icon(Icons.email),emailController),
            SizedBox(
              height: 20,
            ),
            user("Moblie", Icon(Icons.call),phoneController),
            SizedBox(
              height: 20,
            ),
            user("password", Icon(Icons.password),passController),
            SizedBox(
              height: 20,
            ),
            user("Confirm password", Icon(Icons.password),passController),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_HOME);
              },
              child: Text("Sign Up"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12)),
            ),
            SizedBox(height: 11,),
            Text("OR"),
            SizedBox(height: 11,),
            ElevatedButton(
              onPressed: () {

                context.read<RegisterBloc>().add(RegisterUserEvent(newUser: UserModel(
                    uName: nameController.text,
                    uEmail: emailController.text,
                    uPhone: phoneController.text,
                    uPassword: passController.text,
                    uCreatedAt: DateTime.now().microsecondsSinceEpoch.toString())));
                Navigator.pop(context);
              },
              child: Text("Sign in with Google"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                    side: BorderSide(color: Colors.pinkAccent)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 12)),
            ),


            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.ROUTE_LOGIN);
              },
              child: Text.rich(TextSpan(text: "Already have an account? ", children: [
                TextSpan(
                    text: "Login", style: TextStyle(color: Colors.pinkAccent))
              ])),
            )
          ],
        ),
      ),
    );
  }

  Widget user(String s, Icon icon,controller) {
    return TextField(

      controller: controller ,

      decoration: InputDecoration(
        hintText: s,
        hintStyle: TextStyle(color: Colors.black),
        prefixIcon: icon,
        filled: true,
        fillColor: Color(0xffF0E4F2),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),

          borderSide: BorderSide.none,
        ),
      ),
    );

  }
}
