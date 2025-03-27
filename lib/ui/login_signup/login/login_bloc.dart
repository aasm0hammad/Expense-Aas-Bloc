import 'package:ass_expense/DataBase/local/DbHelper.dart';
import 'package:ass_expense/ui/login_signup/login/login_event.dart';
import 'package:ass_expense/ui/login_signup/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  DbHelper dbHelper;
   LoginBloc({required this.dbHelper}):super(LoginInitialState()){
     on<AuthenticateUserEvent>((event,emit)async{

       emit(LoginLoadingState());
       bool check=await dbHelper.authenticate(password: event.pass,email: event.email!,isEmail: event.isEmail,phone: event.mobNo!);

       if(check){
         emit(LoginSuccessState());
       }else{
         emit(LoginFailureState(errorMsg: "Invalid credentials!!"));
       }


     });



   }



}