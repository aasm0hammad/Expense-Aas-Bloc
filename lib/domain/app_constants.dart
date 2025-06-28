import 'dart:ui';

import 'package:ass_expense/DataBase/model/category_model.dart';
import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/DataBase/model/filter_expense_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConstants {


  static List<CategoryModel> mCat = [

    CategoryModel(
        id: 1, name: "Coffee", imgPath: "assets/images/cat_img/coffee.png"),
    CategoryModel(id: 2,
        name: "Fast-Food",
        imgPath: "assets/images/cat_img/fast-food.png"),
    CategoryModel(
        id: 3, name: "Gift", imgPath: "assets/images/cat_img/gift.png"),
    CategoryModel(id: 4,
        name: "Shopping",
        imgPath: "assets/images/cat_img/shopping-bag.jpg"),
    CategoryModel(
        id: 5, name: 'name', imgPath: 'assets/images/cat_img/shopping-bag.jpg')

  ];



  /// Colors
  static Color getColorForCategory(int id) {
    List<Color> defaultColors = [
      Colors.indigo,
      Colors.pinkAccent,
      Colors.amber,
      Colors.cyan,
      Colors.redAccent,
      Colors.green,
      Colors.purple
    ];
    return defaultColors[id % defaultColors.length];
  }
  static List<Map<String, dynamic>> getCategoryPercentageData(Map<String, num> catTotals) {
    num totalSpent = catTotals.values.fold(0, (sum, value) => sum + value.abs());

    // Convert entries to a list and sort it
    List<MapEntry<String, num>> sortedEntries = catTotals.entries.toList();
    sortedEntries.sort((a, b) => b.value.abs().compareTo(a.value.abs()));

    // Map sorted entries to your desired output
    return sortedEntries.map((entry) {
      final catId = entry.key;
      final amount = entry.value.abs();
      final percent = (totalSpent > 0) ? ((amount / totalSpent) * 100).round() : 0;
      final color = getColorForCategory(int.tryParse(catId) ?? 0);

      return {
        'percentage': percent.toString(),
        'color': color,
      };
    }).toList();
  }

  /// Category wise
  static Map<String, num> calculateCategoryTotals(List<ExpenseModel> allExpenses) {
    Map<String, num> categoryMap = {};

    for (var exp in allExpenses) {
      String catId = exp.eCatId;

      if (!categoryMap.containsKey(catId)) {
        categoryMap[catId] = 0;
      }

      if (exp.eType == 'Debit') {
        categoryMap[catId] = categoryMap[catId]! - exp.eAmt;
      } else {
        categoryMap[catId] = categoryMap[catId]! + exp.eAmt;
      }
    }

    return categoryMap;
  }



  static List<FilterExpenseModel> filterExpenseByType(
      {required List<ExpenseModel> allExpenses, int type = 1}) {
    List<String> uniqueDates = [];
    List<FilterExpenseModel> allFilteredExpenses = [];
    DateFormat df = DateFormat.yMMMEd();


    if (type == 1) {
      df = DateFormat.d();
    }
    else if (type == 2) {
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