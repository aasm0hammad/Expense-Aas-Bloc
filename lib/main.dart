import 'package:ass_expense/DataBase/local/DbHelper.dart';
import 'package:ass_expense/DataBase/repository/expense_repository.dart';
import 'package:ass_expense/routes/app_routes.dart';
import 'package:ass_expense/ui/home_page.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_bloc.dart';
import 'package:ass_expense/ui/login_signup/login/login_bloc.dart';
import 'package:ass_expense/ui/login_signup/profile/profile_bloc.dart';
import 'package:ass_expense/ui/login_signup/register/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

void main() {
  runApp(
   MultiBlocProvider(
       providers: [
         BlocProvider(create: (context)=>RegisterBloc(dbHelper: DbHelper.getInstance())),
         BlocProvider(create: (context)=>LoginBloc(dbHelper: DbHelper.getInstance())),
         BlocProvider(create: (context)=>ExpenseBloc(expenseRepository: ExpenseRepository(dbHelper: DbHelper.getInstance()))),
         BlocProvider(create: (_)=>ProfileBloc(dbHelper: DbHelper.getInstance())),
       ], child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.ROUTE_SPLASH,
      routes: AppRoutes.getRoutes(),
    );
  }
}
