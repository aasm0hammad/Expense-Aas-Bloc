import 'package:ass_expense/DataBase/model/users_model.dart';
import 'package:ass_expense/routes/app_routes.dart';
import 'package:ass_expense/ui/login_signup/profile/profile_bloc.dart';
import 'package:ass_expense/ui/login_signup/profile/profile_event.dart';
import 'package:ass_expense/ui/login_signup/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavProfilePage extends StatefulWidget {
  const NavProfilePage({super.key});

  @override
  State<NavProfilePage> createState() => _NavProfilePageState();
}

class _NavProfilePageState extends State<NavProfilePage> {
  bool isHover = false;
  DateFormat df = DateFormat.s();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          UserModel? user;
          if (state is ProfileLoadingState) {}

          if (state is ProfileFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
          if (state is ProfileLoadedState) {
            user = state.userModel;
            print(state.userModel.uEmail);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    "assets/images/profile.png",
                    height: 139,
                    width: 139,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                                        user?.uName ?? "",
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                                      ),
                        Icon(Icons.verified,color: Colors.blueAccent,)
                      ],
                    ),
                  )),
              customContainer(
                  text: "Your Email",
                  icon: Icon(
                    Icons.mail,
                    color: Colors.grey,
                  ),
                  hint: user?.uEmail ?? ""),
              SizedBox(
                height: 15,
              ),
              customContainer(
                text: "Phone Number",
                icon: Icon(
                  Icons.phone,
                  color: Colors.grey,
                ),
                hint: user?.uPhone ?? "",
              ),
              SizedBox(
                height: 15,
              ),
              customContainer(
                text: "Account Create",
                icon: Icon(
                  Icons.create_sharp,
                  color: Colors.grey,
                ),
                hint:DateFormat('dd MMM yyyy hh:mm:ss a').format(
          DateTime.fromMicrosecondsSinceEpoch(
          int.tryParse(user?.uCreatedAt ?? '') ?? 0),)),

          SizedBox(
                height: 25,
              ),
              Center(
                child: OutlinedButton(
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setInt('key', 0);
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.ROUTE_LOGIN);
                    },
                    child: Text("Logout")),
              )
            ],
          );
        }));
  }

  customContainer({required String text, icon, required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(left: 11.0, right: 11),
      child: Container(
        height: 83,
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
            TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: icon,
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey)),
            )
          ],
        ),
      ),
    );
  }
}
