import 'package:ass_expense/DataBase/local/DbHelper.dart';

class UserModel {
  int? uId;
  String uName;
  String uEmail;
  String uPhone;
  String uPassword;
  String uCreatedAt;

  UserModel(
      {this.uId,
      required this.uName,
      required this.uEmail,
      required this.uPhone,
      required this.uPassword,
      required this.uCreatedAt});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uId: map[DbHelper.COLUNMN_USER_ID],
        uName: map[DbHelper.COLUNMN_USER_NAME],
        uEmail: map[DbHelper.COLUNMN_USER_EMAIL],
        uPhone: map[DbHelper.COLUNMN_USER_PHONE],
        uPassword: map[DbHelper.COLUNMN_USER_PASSWORD],
        uCreatedAt: map[DbHelper.COLUNMN_USER_CREATED_AT]);
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.COLUNMN_USER_NAME: uName,
      DbHelper.COLUNMN_USER_EMAIL: uEmail,
      DbHelper.COLUNMN_USER_PHONE: uPhone,
      DbHelper.COLUNMN_USER_PASSWORD: uPassword,
      DbHelper.COLUNMN_USER_CREATED_AT: uCreatedAt,
    };
  }
}
