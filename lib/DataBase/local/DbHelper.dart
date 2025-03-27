import 'dart:io';

import 'package:ass_expense/DataBase/model/users_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  ///User Table &  Column

  static const String TABLE_USERS = "users";
  static const String COLUNMN_USER_ID = 'uId';
  static const String COLUNMN_USER_NAME = 'uName';
  static const String COLUNMN_USER_EMAIL = 'uEmail';
  static const String COLUNMN_USER_PHONE = 'uPhone';
  static const String COLUNMN_USER_PASSWORD = "uPassword";
  static const String COLUNMN_USER_CREATED_AT = 'uCreatedAt';

  /// Expense Table &  Column
  static const String TABLE_EXPENSE = 'expense';
  static const String COLUNMN_EXPENSE_ID = 'eId';
  static const String COLUNMN_EXPENSE_USER_ID = 'uId';
  static const String COLUNMN_EXPENSE_TITLE = 'eTitle';
  static const String COLUNMN_EXPENSE_DESC = 'eDesc';
  static const String COLUNMN_EXPENSE_AMT = 'eAMT';
  static const String COLUNMN_EXPENSE_CATEGORY = 'eCATE_Id';
  static const String COLUNMN_EXPENSE_TYPE = 'eType';
  static const String COLUNMN_EXPENSE_BALANCE = 'eBal';
  static const String COLUNMN_EXPENSE_DATE = 'eDate';
  static const String COLUNMN_EXPENSE_CREATED_AT = 'eCREATED';

  Database? _db;

  Future<Database> getDB() async {
    _db ??= await openDB();
    return _db!;
  }

  Future<Database> openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var path = join(appDocDir.path, "ExpenseDB.db");
    return openDatabase(path, version: 1, onCreate: (db, v) {
      db.execute('''
      create table $TABLE_USERS ( 
      $COLUNMN_USER_ID integer primary key autoincrement , 
      $COLUNMN_USER_NAME TEXT NOT NULL ,
      $COLUNMN_USER_EMAIL TEXT NOT NULL,
      $COLUNMN_USER_PHONE TEXT NOT NULL,
      $COLUNMN_USER_PASSWORD TEXT NOT NULL,
      $COLUNMN_USER_CREATED_AT TEXT NOT NULL
      )
      
      ''');
      db.execute('''
      CREATE TABLE $TABLE_EXPENSE( 
      $COLUNMN_EXPENSE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $COLUNMN_EXPENSE_USER_ID TEXT NOT NULL,
      $COLUNMN_EXPENSE_TITLE TEXT NOT NULL,
      $COLUNMN_EXPENSE_DESC TEXT ,
      $COLUNMN_EXPENSE_AMT REAL NOT NULL,
      $COLUNMN_EXPENSE_BALANCE REAL,
      $COLUNMN_EXPENSE_TYPE TEXT NOT NULL,
      $COLUNMN_EXPENSE_DATE TEXT NOT NULL,
      $COLUNMN_EXPENSE_CATEGORY TEXT NOT NULL,
      $COLUNMN_EXPENSE_CREATED_AT TEXT NOT NULL
      )
      
      ''');
    });
  }

  Future<bool> userRegister(UserModel newUser) async {
    Database db = await getDB();
    int rowEffected = await db.insert(TABLE_USERS, newUser.toMap());

    return rowEffected > 0;
  }

  Future<bool> isEmailAlreadyExists({required String email}) async {
    Database db = await getDB();
    var mData = await db
        .query(TABLE_USERS, where: "$COLUNMN_USER_EMAIL=?", whereArgs: [email]);

    return mData.isNotEmpty;
  }

  /// authenticate
  Future<bool> authenticate({
    String email = '',
    String phone = '',
    required String password,
    bool isEmail = true,
  }) async {
    Database db = await getDB();
    var mData = isEmail
        ? await db.query(TABLE_USERS,
            where: "$COLUNMN_USER_EMAIL=? and $COLUNMN_USER_PASSWORD=?",
            whereArgs: [email, password])
        : await db.query(TABLE_USERS,
            where: '$COLUNMN_USER_PHONE=? and $COLUNMN_USER_PASSWORD=?',
            whereArgs: [phone, password]);

    return mData.isNotEmpty;
  }
}
