

import 'package:ass_expense/DataBase/local/DbHelper.dart';
import 'package:ass_expense/ui/login_signup/register/user_event.dart';
import 'package:ass_expense/ui/login_signup/register/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{

  DbHelper dbHelper;
  RegisterBloc({required this.dbHelper}): super(RegisterInitialState()){
    on<RegisterUserEvent>((event,emit)async{


      emit(RegisterLoadingState());
      if(await dbHelper.isEmailAlreadyExists(email: event.newUser.uEmail)){
        emit(RegisterFailureState(errorMsg:'Email already exists..' ));
      }else{

        bool check = await dbHelper.userRegister(event.newUser);
        if(check){
          emit(RegisterSuccessState());
        }else{
          emit(RegisterFailureState(errorMsg: "Something went wrong"));
        }
      }

    });



  }
}