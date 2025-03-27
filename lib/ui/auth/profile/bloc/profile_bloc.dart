import 'package:ExpensifyX_App/data/local/session_manager.dart';
import 'package:ExpensifyX_App/ui/auth/profile/bloc/profile_event.dart';
import 'package:ExpensifyX_App/ui/auth/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  ProfileBloc() : super(ProfileInitialState()){
       on<LogoutUserEvent>((event, emit) async {
         print("Logout event received");
      emit(ProfileLoadingState()); 
      try {
        await SessionManager.logoutUser(); 
         print("Session cleared successfully");
        emit(ProfileSuccessState()); 
      } catch (e) {
        print("Logout Failed: ${e.toString()}");
        emit(ProfileFailureState(errorMsg: "Logout Failed! ${e.toString()}"));
      }
    });
  }
}