import 'package:ass_expense/routes/app_routes.dart';
import 'package:ass_expense/ui/BottomNavigationBar_ui/nav_home.dart';
import 'package:ass_expense/ui/home_page.dart';
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

  TextEditingController loginController = TextEditingController();

  TextEditingController passController = TextEditingController();

  bool isLoading =false;
  bool isEmailRegExp(String input){
    final emailRegExp=RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(input);
  }
  bool isMobNoRegExp(String input){
    final mobNo=  RegExp(r"^[6-9]\d{9}$");
    return mobNo.hasMatch(input);
  }
  bool isPass(String input){
    final pass=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    return pass.hasMatch(input);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors:[Color(0xff6674D3), Color(0xffE78BBC),])),
        child:  Padding(
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
              user("Email or Phone Number", Icon(Icons.person), loginController),
              SizedBox(
                height: 20,
              ),
              user("password", Icon(Icons.password), passController,),
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
                    Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_HOME);
                     ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Successful")));
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    String loginInput= loginController.text;
                    String passInput=passController.text;

                    String? email;
                    String? mobNo;
                    String pass;
                    bool isEmail=true;

                    if(isEmailRegExp(loginInput)){
                      email=loginInput;
                      isEmail=true;
                    }else if(isMobNoRegExp(loginInput)){

                      mobNo=loginInput;
                      isEmail=false;


                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a valid email or phone number")));
                      return;
                    }
                    if(isPass(passInput)){
                      pass=passInput;
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a valid password")));
                      return;
                    }
                    context.read<LoginBloc>().add(AuthenticateUserEvent(email:email,mobNo:mobNo,pass: passController.text,isEmail: isEmail));
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
      )
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
