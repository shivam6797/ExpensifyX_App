  import 'package:ExpensifyX_App/data/model/user_model.dart';

  abstract class RegisterState{}

  class RegisterInitialState extends RegisterState{
    final UserModel user;
    final String confirmPassword;
    final Map<String,String?> errors;
    RegisterInitialState({required this.user,required this.confirmPassword,required this.errors});
  }
  class RegisterLoadingState extends RegisterState{}
  class RegisterSuccessState extends RegisterState{}
  class RegisterFailureState extends RegisterState{
    String errorMsg;
    RegisterFailureState({required this.errorMsg});
  }

  /// Validation State (Track Form Errors)
  class RegisterValidationState extends RegisterState {
    final UserModel user;
    final String confirmPassword;
    final Map<String, String?> errors;
    RegisterValidationState({required this.user, this.confirmPassword = "", required this.errors});

    RegisterValidationState copyWith({
      UserModel? user,
      String? confirmPassword,
      Map<String, String?>? errors,
    }) {
      return RegisterValidationState(
        user: user ?? this.user,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        errors: errors ?? this.errors,
      );
  }

  }

