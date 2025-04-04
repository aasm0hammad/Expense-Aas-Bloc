import 'package:ass_expense/DataBase/model/expense_model.dart';

abstract class ExpenseState{}

class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{


}
class ExpenseSuccessState extends ExpenseState{
  List<ExpenseModel> allExpense;
  ExpenseSuccessState({required this.allExpense});

}
class ExpenseFailureState extends ExpenseState{
  String errorMsg;

  ExpenseFailureState({required this.errorMsg});

}