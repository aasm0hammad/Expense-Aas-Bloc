import 'package:ass_expense/DataBase/model/expense_model.dart';

class FilterExpenseModel{
  String type;
  num totalAmt;
  List<ExpenseModel> mExpenses;

  FilterExpenseModel({required this.type, required this.totalAmt,required this.mExpenses});


}