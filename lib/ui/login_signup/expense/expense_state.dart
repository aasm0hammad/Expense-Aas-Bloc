import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/DataBase/model/filter_expense_model.dart';

abstract class ExpenseState{}

class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{


}
class ExpenseSuccessState extends ExpenseState{
  List<FilterExpenseModel> allExpense;


  ExpenseSuccessState({required this.allExpense});

}
class ExpenseFailureState extends ExpenseState{
  String errorMsg;

  ExpenseFailureState({required this.errorMsg});

}

class FilteredExpenseSuccessState extends ExpenseState {
  List<FilterExpenseModel> allFilteredExpenses;
  FilteredExpenseSuccessState({required this.allFilteredExpenses});

}