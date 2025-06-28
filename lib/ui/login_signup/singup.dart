import 'package:ass_expense/DataBase/model/users_model.dart';

import 'package:ass_expense/routes/app_routes.dart';
import 'package:ass_expense/ui/login_signup/register/user_bloc.dart';
import 'package:ass_expense/ui/login_signup/register/user_event.dart';
import 'package:ass_expense/ui/login_signup/register/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(

          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors:[Color(0xff6674D3), Color(0xffE78BBC),])
          ),
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
                height: 50,
              ),
              user(
                  "username",
                  Icon(
                    Icons.person,
                  ),
                  nameController,
                  false, validator: (value) {
                if (value!.isEmpty) {
                  return "Username is required!";
                } else {
                  return null;
                }
              }),
              SizedBox(
                height: 20,
              ),
              user("email", Icon(Icons.email), emailController, false,
                  validator: (value) {
                if (value!.isEmpty) {
                  return "Email is required!";
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return "Enter valid Email";
                } else {
                  return null;
                }
              }),
              SizedBox(
                height: 20,
              ),
              user("Moblie Number", Icon(Icons.call), phoneController, false,
                  validator: (value) {
                if (value!.isEmpty) {
                  return " Mobile is required!..";
                } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                  return "Enter a valid 10-digit phone number";
                } else {
                  return null;
                }
              }),
              SizedBox(
                height: 20,
              ),
              user("password", Icon(Icons.password), passController,
                  !isPasswordVisible,
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: !isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)), validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required!..';
                } else if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$')
                    .hasMatch(value)) {
                  return "Please include Minimum 1 Upper case\nMinimum 1 lowercase\nMinimum 1 Numeric Number\nMinimum 1 Special Character";
                } else {
                  return null;
                }
              }),
              SizedBox(
                height: 20,
              ),
              user(
                "Confirm password",
                Icon(Icons.password),
                confirmController,
                !isConfirmPasswordVisible,
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    child: isConfirmPasswordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Confirm Pass field cannot be empty!";
                  } else if (value != passController.text) {
                    return "Password doesn't match!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoadingState) {
                    isLoading = true;
                    setState(() {});
                  }
                  if (state is RegisterFailureState) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }
                  if (state is RegisterSuccessState) {
                    isLoading = false;
                    Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_LOGIN);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Register Successful...")));
                  }
                },
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      context.read<RegisterBloc>().add(RegisterUserEvent(
                          newUser: UserModel(
                              uName: nameController.text,
                              uEmail: emailController.text,
                              uPhone: phoneController.text,
                              uPassword: passController.text,
                              uCreatedAt: DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString())));
                    }
                  },

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 12)),
                  child: isLoading
                      ? Row(
                    children: [
                      CircularProgressIndicator(),
                      Text("Registering...")
                    ],
                  )
                      : Text("Sign Up"),
                ),
              ),
              SizedBox(
                height: 11,
              ),
              Text("OR"),
              SizedBox(
                height: 11,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ROUTE_HOME);
                },

                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                        side: BorderSide(color: Colors.pinkAccent)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 70, vertical: 12)),
                child: Text("Sign in with Google"),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.ROUTE_LOGIN);
                },
                child: Text.rich(TextSpan(
                    text: "Already have an account? ",
                    children: [
                      TextSpan(
                          text: "Login",
                          style: TextStyle(color: Colors.pinkAccent))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget user(String s, Icon preIcon, controller, bool obscureText,
      {Widget? suffixIcon, String? Function(String?)? validator}) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
errorStyle: TextStyle(color: Colors.redAccent,fontSize: 15),

        hintText: s,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: Colors.black),
        prefixIcon: preIcon,
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
