abstract class LoginEvent {}

class AuthenticateUserEvent extends LoginEvent{
  String? email;
  String? mobNo;
  String pass;
  bool isEmail;
  AuthenticateUserEvent({this.email,this.mobNo,required this.pass,this.isEmail=true});

}