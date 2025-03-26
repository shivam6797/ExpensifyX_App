import 'package:ExpensifyX_App/data/model/user_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {
   final UserModel user;
  final Map<String, String?> errors;
  LoginInitialState({required this.user,required this.errors});
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {  
  final String errorMsg;
  LoginFailureState({required this.errorMsg});
}

/// Validation State (Track Form Errors)
class LoginValidationState extends LoginState {
  final UserModel user;
  final Map<String, String?> errors;

  LoginValidationState({required this.user, required this.errors});

  LoginValidationState copyWith({
    UserModel? user,
    Map<String, String?>? errors,
  }) {
    return LoginValidationState(
      user: user ?? this.user,
      errors: errors ?? this.errors,
    );
  }
}
