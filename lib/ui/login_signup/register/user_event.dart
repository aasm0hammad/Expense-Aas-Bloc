import 'package:ass_expense/DataBase/model/users_model.dart';

abstract class RegisterEvent {

}

class RegisterUserEvent extends RegisterEvent{

  UserModel newUser;
  RegisterUserEvent({required this.newUser});
}
class Authentication extends RegisterEvent{


}