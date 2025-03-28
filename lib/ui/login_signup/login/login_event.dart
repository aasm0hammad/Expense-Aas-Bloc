abstract class LoginEvent {}

class AuthenticateUserEvent extends LoginEvent{
  String? email;
  String? mobNo;
  String pass;
  bool isEmail=false;
  AuthenticateUserEvent({ this.email,this.mobNo,required this.pass, required this.isEmail});

}