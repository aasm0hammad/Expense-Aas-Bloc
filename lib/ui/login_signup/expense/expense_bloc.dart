import 'package:ass_expense/DataBase/local/DbHelper.dart';
import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/DataBase/model/filter_expense_model.dart';
import 'package:ass_expense/DataBase/repository/expense_repository.dart';
import 'package:ass_expense/domain/app_constants.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_event.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void updateBalanceInPrefs(num balance)async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setDouble("bal", balance.toDouble());

}

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseRepository expenseRepository;

  ExpenseBloc({required this.expenseRepository}) : super(ExpenseInitialState()) {


    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      bool check = await expenseRepository.addExpense(newExpense: event.newExp);

      if (check) {
        List<ExpenseModel> allExp = await expenseRepository.fetchAllExpense();
        List<FilterExpenseModel> allfilter= ExpenseRepository.filterExpenseByType(allExpenses: allExp,type: 1);


        updateBalanceInPrefs(allExp.last.eBal);
        emit(ExpenseSuccessState(allExpense:allfilter));
      } else {
        emit(ExpenseFailureState(errorMsg: "Something went wrong"));
      }
    });





    on<GetInitialExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      List<ExpenseModel> allExp = await expenseRepository.fetchAllExpense();
      List<FilterExpenseModel> allfilter= ExpenseRepository.filterExpenseByType(allExpenses: allExp,type: event.type);

      updateBalanceInPrefs(allExp.last.eBal);


      emit(ExpenseSuccessState(allExpense: allfilter));
    });
  }
}
