import 'package:ass_expense/DataBase/model/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{

  ExpenseModel newExp;
  AddExpenseEvent({required this.newExp});

}

/*class FilterExpenseByTypeEvent extends ExpenseEvent{
  List<ExpenseModel>  allExpenses;
  var filterType;
  FilterExpenseByTypeEvent({required this.allExpenses,required this.filterType});

}*/

class GetInitialExpenseEvent extends ExpenseEvent{
int type;
GetInitialExpenseEvent({this.type=2});


}