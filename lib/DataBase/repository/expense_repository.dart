import 'package:ass_expense/DataBase/local/DbHelper.dart';
import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/DataBase/model/filter_expense_model.dart';
import 'package:intl/intl.dart';

class ExpenseRepository {
  DbHelper dbHelper;

  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpense({required ExpenseModel newExpense})async{

    bool check=await dbHelper.addExpense(newExpense: newExpense);
    return check;
  }

  Future<List<ExpenseModel>> fetchAllExpense()async{
    List<ExpenseModel> allExp = await dbHelper.fetchAllExpense();

    return allExp;
  }





  /// Filtering Date Month and Year Wise
  static List<FilterExpenseModel> filterExpenseByType({required List<ExpenseModel> allExpenses, int type=2}) {
    List<String> uniqueDates = [];
    List<FilterExpenseModel> allFilteredExpenses=[];
    DateFormat df = DateFormat.yMMMEd();


    if(type==1){
      df= DateFormat.E();
    }else if (type == 2) {
      df = DateFormat.yMMMEd();
    } else if (type == 3) {
      df = DateFormat.yMMM();
    } else {
      df = DateFormat.y();
    }



    ///data wise
    for (ExpenseModel eachExp in allExpenses) {
      String date = df.format(
          DateTime.fromMicrosecondsSinceEpoch(int.parse(eachExp.eCreatedAt)));

      /// UniqueDate
      if (!uniqueDates.contains(date)) {
        uniqueDates.add(date);
      }
    }
    print(uniqueDates);

    for (String eachDate in uniqueDates) {
      num eachDateTotalAmt = 0.0;
      List<ExpenseModel> eachDateExpenses = [];
      for (ExpenseModel eachExp in allExpenses) {
        String date = df.format(
            DateTime.fromMicrosecondsSinceEpoch(int.parse(eachExp.eCreatedAt)));

        if (eachDate == date) {
          eachDateExpenses.add(eachExp);
          if (eachExp.eType == 'Debit') {
            eachDateTotalAmt -= eachExp.eAmt;
          } else {
            eachDateTotalAmt += eachExp.eAmt;
          }
        }
      }

      allFilteredExpenses.add(FilterExpenseModel(
          type: eachDate,
          totalAmt: eachDateTotalAmt,
          mExpenses: eachDateExpenses));


    }
    return allFilteredExpenses;


  }
}
