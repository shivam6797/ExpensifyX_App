import 'package:ExpensifyX_App/data/local/db_helper.dart';
import 'package:ExpensifyX_App/data/local/session_manager.dart';
import 'package:ExpensifyX_App/data/model/user_model.dart';
import 'package:ExpensifyX_App/data/utils/validators.dart';
import 'package:ExpensifyX_App/ui/auth/login/bloc/login_event.dart';
import 'package:ExpensifyX_App/ui/auth/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DbHelper dbHelper;
  LoginBloc({required this.dbHelper})
      : super(LoginInitialState(user: UserModel.empty(), errors: {})) {


    // common Function: Update State with User & Errors
    void updateState(
        UserModel user, Map<String, String?> errors, Emitter<LoginState> emit) {
      emit(LoginValidationState(user: user, errors: errors));
    }

    // Get Current State
    LoginValidationState getCurrentState(){
      return state is LoginValidationState ? state as LoginValidationState : LoginValidationState(user:UserModel.empty(),errors: {});
    }


    // email changed Event
     on<EmailChangedEvent>((event, emit) {
       final currentState = getCurrentState();
       final updateUser = currentState.user.copyWith(email: event.email);
       final updatedErrors = Map<String,String?>.from(currentState.errors);
       updatedErrors[DbHelper.USER_COLUMN_EMAIL] = Validators.validateEmail(event.email);
       updateState(updateUser, updatedErrors, emit);
     });

      // phone changed Event
     on<PhoneChangedEvent>((event, emit) {
       final currentState = getCurrentState();
       final updateUser = currentState.user.copyWith(phone: event.phone);
       final updatedErrors = Map<String,String?>.from(currentState.errors);
       updatedErrors[DbHelper.USER_COLUMN_PHONE] = Validators.validatePhone(event.phone);
       updateState(updateUser, updatedErrors, emit);
     });

        // password changed Event
     on<PasswordChangedEvent>((event, emit) {
       final currentState = getCurrentState();
       final updateUser = currentState.user.copyWith(password: event.password);
       final updatedErrors = Map<String,String?>.from(currentState.errors);
       updatedErrors[DbHelper.USER_COLUMN_PASSWORD] = Validators.validatePassword(event.password);
       updateState(updateUser, updatedErrors, emit);
     });

    // User Login Submit Event (LoginUserEvent)
    on<LoginUserEvent>((event, emit) async {
       final currentState = getCurrentState();
      if (currentState.errors.values.any((error) => error != null)) {
        updateState(currentState.user, currentState.errors, emit);
        return;
      }
      emit(LoginLoadingState());
      await Future.delayed(Duration(seconds: 2));
      print(
          "Login attempt - Input: ${event.input}, Password: ${event.password}, isEmail: ${event.isEmail}");
      UserModel? user = await dbHelper.authenticateUser(
        input: event.input,
        password: event.password,
        isEmail: event.isEmail,
      );
      if (user != null) {
        await SessionManager.saveUserSession(
            userId: user.id.toString(), email: user.email, phone: user.phone);
        emit(LoginSuccessState());
      } else {
        emit(LoginFailureState(errorMsg: "Invalid credentials"));
      }
    });

     /// Reset Login State
    on<ResetLoginState>((event, emit) {
      emit(LoginInitialState(user: UserModel.empty(), errors: {}));
    });
  }
  }

