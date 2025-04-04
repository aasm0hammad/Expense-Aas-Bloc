import 'package:ass_expense/DataBase/local/DbHelper.dart';
import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_event.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{


  DbHelper dbHelper;
  ExpenseBloc({required this.dbHelper}): super(ExpenseInitialState()){


    on<AddExpenseEvent>((event, emit)async{

      emit(ExpenseLoadingState());

      bool check =await dbHelper.addExpense(newExpense: event.newExp);

      if(check){

        List<ExpenseModel> allExp=await  dbHelper.fetchAllExpense();
        emit(ExpenseSuccessState(allExpense: allExp));
      }else{

        emit(ExpenseFailureState(errorMsg: "Something went wrong"));
      }



    });



  }

}