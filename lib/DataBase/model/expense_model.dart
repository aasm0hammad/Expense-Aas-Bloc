import 'package:ass_expense/DataBase/local/DbHelper.dart';

class ExpenseModel {
  int? eId;
  String? uId;
  String eTitle;
  String eDesc;
  num eAmt;
  num eBal;
  String eCreatedAt;
  String eType;
  String eCatId;

  ExpenseModel({this.eId,
     this.uId,
    required this.eTitle,
    required this.eDesc,
    required this.eAmt,
    required this.eBal,
    required this.eCreatedAt,
    required this.eType,
    required this.eCatId});

  factory ExpenseModel.fromMap(Map<String, dynamic> map){
    return ExpenseModel(
      eId:  map[DbHelper.COLUNMN_EXPENSE_ID],
        uId: map[DbHelper.COLUNMN_EXPENSE_USER_ID],
        eTitle: map[DbHelper.COLUNMN_EXPENSE_TITLE],
        eDesc:  map[DbHelper.COLUNMN_EXPENSE_DESC],
        eAmt: map[DbHelper.COLUNMN_EXPENSE_AMT],
        eBal:  map[DbHelper.COLUNMN_EXPENSE_BALANCE],
        eCreatedAt:  map[DbHelper.COLUNMN_EXPENSE_CREATED_AT],
        eType:  map[DbHelper.COLUNMN_EXPENSE_TYPE],
        eCatId:  map[DbHelper.COLUNMN_EXPENSE_CATEGORY]);
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.COLUNMN_EXPENSE_USER_ID:uId,
      DbHelper.COLUNMN_EXPENSE_TITLE: eTitle,
      DbHelper.COLUNMN_EXPENSE_DESC: eDesc,
      DbHelper.COLUNMN_EXPENSE_AMT: eAmt,
      DbHelper.COLUNMN_EXPENSE_BALANCE: eBal,
      DbHelper.COLUNMN_EXPENSE_CREATED_AT: eCreatedAt,
      DbHelper.COLUNMN_EXPENSE_TYPE: eType,
      DbHelper.COLUNMN_EXPENSE_CATEGORY: eCatId,
    };
  }
}
