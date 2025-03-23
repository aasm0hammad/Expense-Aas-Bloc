import 'package:ass_expense/routes/app_routes.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150, left: 16, right: 16),
        child: Column(
          children: [
            Center(
                child: Text(
              "WELCOME BACK",
              style: TextStyle(fontFamily: "Poppins", fontSize: 25),
            )),
            Text(
              "Enter Your Credential to login ",
              style: TextStyle(fontSize: 11, color: Colors.black),
            ),
            SizedBox(
              height: 120,
            ),
            user("username", Icon(Icons.person)),
            SizedBox(
              height: 20,
            ),
            user("password", Icon(Icons.password)),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_HOME);
                 },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12)),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              "Forget password?",
              style: TextStyle(color: Colors.pinkAccent),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.ROUTE_SIGNUP);
              },
              child: Text.rich(TextSpan(text: "Don't have an account? ", children: [
                TextSpan(
                    text: "Signn Up", style: TextStyle(color: Colors.pinkAccent))
              ])),
            )
          ],
        ),
      ),
    );
  }

  static Widget user(title, icon) {
    return TextField(


      decoration: InputDecoration(
        hintText: title,
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
