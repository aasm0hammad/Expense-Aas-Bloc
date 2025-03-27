import 'package:ass_expense/routes/app_routes.dart';
import 'package:ass_expense/ui/BottomNavigationBar_ui/nav_home.dart';
import 'package:ass_expense/ui/login_signup/login/login_bloc.dart';
import 'package:ass_expense/ui/login_signup/login/login_event.dart';
import 'package:ass_expense/ui/login_signup/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {


  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  bool isLoading =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
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
      user("username", Icon(Icons.person), emailController),
      SizedBox(
        height: 20,
      ),
      user("password", Icon(Icons.password), passController),
      SizedBox(
        height: 100,
      ),
      BlocListener<LoginBloc,LoginState>(
          listener: (context, state) {
            if(state is LoginLoadingState){
              isLoading=true;
              setState(() {

              });

            }
            if (state is LoginFailureState) {
              isLoading=false;
              setState(() {
                
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("data")));
            }
            if (state is LoginSuccessState) {
              isLoading=false;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NavHomePage()));
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Login Successful")));
            }
          },
          child: ElevatedButton(
          onPressed: () async
      {
       context.read<LoginBloc>().add(AuthenticateUserEvent(email: emailController.text,pass: passController.text,));
      },
      child: Text("Login"),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12)),
    ),
    ),
    SizedBox(
    height:80,
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

  static Widget user(title, icon, TextEditingController controller) {
    return TextField(


      controller: controller,
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
