import 'package:ass_expense/DataBase/local/DbHelper.dart';
import 'package:ass_expense/DataBase/model/users_model.dart';
import 'package:ass_expense/ui/login_signup/profile/profile_event.dart';
import 'package:ass_expense/ui/login_signup/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  DbHelper dbHelper;

  ProfileBloc({required this.dbHelper}) : super(ProfileInitialState()) {
    on<GetUserProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        final userId = pref.getInt("key");
        print(userId);

        if (userId != null) {
          List<UserModel> users = await dbHelper.fetchUserProfile();
          UserModel? currentUser = users.firstWhere((user) =>
          user.uId == userId,
              orElse: () =>
                  UserModel(
                    uId: userId,
                      uName: "",
                      uEmail: "",
                      uPhone: "",
                      uPassword: "",
                      uCreatedAt: ""),
          );
              if (currentUser.uId!=0)
          {
            emit(ProfileLoadedState(userModel: currentUser));
            print("hiii${currentUser.uName}");
          } else {
          emit(ProfileFailureState(errorMsg: "No user found"));
        }
      }
    }catch(e){
      emit(ProfileFailureState(errorMsg: e.toString()));

      }


    });
  }

}