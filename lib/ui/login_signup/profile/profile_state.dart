import 'package:ass_expense/DataBase/model/users_model.dart';

abstract class ProfileState {

}
class ProfileInitialState extends ProfileState{}
class ProfileLoadingState extends ProfileState{}
class ProfileLoadedState extends ProfileState{
  final UserModel userModel;
  ProfileLoadedState({required this.userModel});

}
class ProfileFailureState extends ProfileState{

  String errorMsg;
  ProfileFailureState({required this.errorMsg});
}
