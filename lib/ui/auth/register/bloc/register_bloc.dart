import 'package:ExpensifyX_App/data/local/db_helper.dart';
import 'package:ExpensifyX_App/data/model/user_model.dart';
import 'package:ExpensifyX_App/data/utils/validators.dart';
import 'package:ExpensifyX_App/ui/auth/register/bloc/register_event.dart';
import 'package:ExpensifyX_App/ui/auth/register/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  DbHelper dbHelper;
  RegisterBloc({required this.dbHelper})
      : super(RegisterInitialState(
            user: UserModel.empty(), confirmPassword: "", errors: {})) {

              
    //  common function: update state with user $ Errors
    void updateState(
        UserModel user, Map<String, String?> errors, Emitter emit) {
      emit(RegisterValidationState(user: user, errors: errors));
    }

    // reset state 
    on<ResetRegisterState>(_onResetRegister);


    // this function for currentState handle
    RegisterValidationState getCurrentState() {
      return state is RegisterValidationState
          ? state as RegisterValidationState
          : RegisterValidationState(
              user: UserModel.empty(), confirmPassword: "", errors: {});
    }

    // first name changed
    on<FirstNameChangedEvent>((event, emit) {
      final currentState = getCurrentState();
      final updateUser = currentState.user.copyWith(firstName: event.value);
      final updateErrors = Map<String, String?>.from(currentState.errors);
      updateErrors[DbHelper.USER_COLUMN_FIRST_NAME] =
          Validators.validateName(event.value, "First Name");
      updateState(updateUser, updateErrors, emit);
    });

    // Last name changed
    on<LastNameChangedEvent>((event, emit) {
      final currentState = getCurrentState();
      final updateUser = currentState.user.copyWith(lastName: event.value);
      final updateErrors = Map<String, String?>.from(currentState.errors);
      updateErrors[DbHelper.USER_COLUMN_LAST_NAME] =
          Validators.validateName(event.value, "Last Name");
      updateState(updateUser, updateErrors, emit);
    });

    /// Email Changed
    on<EmailChangedEvent>((event, emit) {
      final currentState = getCurrentState();
      final updatedUser = currentState.user.copyWith(email: event.value);
      final updatedErrors = Map<String, String?>.from(currentState.errors);
      updatedErrors[DbHelper.USER_COLUMN_EMAIL] =
          Validators.validateEmail(event.value);
      updateState(updatedUser, updatedErrors, emit);
    });

    /// DOB Changed
    on<DateofBirthChangedEvent>((event, emit) {
      final currentState = getCurrentState();
      final updatedUser = currentState.user.copyWith(birthDate: event.value);
      final updatedErrors = Map<String, String?>.from(currentState.errors);
      updatedErrors[DbHelper.USER_COLUMN_BIRTH_DATE] =
          Validators.validateDOB(event.value);
       print("DOB Validation Error: ${updatedErrors[DbHelper.USER_COLUMN_BIRTH_DATE]}");   
      updateState(updatedUser, updatedErrors, emit);
    });

    /// Phone Changed
    on<PhoneChangedEvent>((event, emit) {
      final currentState = getCurrentState();
      final updatedUser = currentState.user.copyWith(phone: event.value);
      final updatedErrors = Map<String, String?>.from(currentState.errors);
      updatedErrors[DbHelper.USER_COLUMN_PHONE] =
          Validators.validatePhone(event.value);
      updateState(updatedUser, updatedErrors, emit);
    });

    /// Password Changed
    on<PasswordChangedEvent>((event, emit) {
       print("Password Changed Event Triggered: ${event.value}");
      final currentState = getCurrentState();
      final updatedUser = currentState.user.copyWith(password: event.value);
      final updatedErrors = Map<String, String?>.from(currentState.errors);
      updatedErrors[DbHelper.USER_COLUMN_PASSWORD] =
          Validators.validatePassword(event.value);
           print("Updated Errors Map: $updatedErrors");  
      if (currentState.confirmPassword.isNotEmpty) {
        updatedErrors["confirmPasswordError"] =
            Validators.validateConfirmPassword(
                event.value, currentState.confirmPassword);
      }
      emit(currentState.copyWith(user: updatedUser, errors: updatedErrors));
      print("Final Emitted State: ${currentState.copyWith(user: updatedUser, errors: updatedErrors)}");
    });
    

    /// Confirm Password Changed
    on<ConfirmPasswordChangedEvent>((event, emit) {
      final currentState = getCurrentState();
      final updatedErrors = Map<String, String?>.from(currentState.errors);
      updatedErrors["confirmPasswordError"] =
          Validators.validateConfirmPassword(
        currentState.user.password,
        event.value,
      );
      emit(currentState.copyWith(
        confirmPassword: event.value,
        errors: updatedErrors,
      ));
    });

    on<RegisterUserEvent>((event, emit) async {
      if (state is! RegisterValidationState) return;
      final currentState = state as RegisterValidationState;
      if (currentState.errors.values.any((error) => error != null)) {
        return;
      }
      await Future.delayed(Duration(seconds: 1)); 
      emit(RegisterLoadingState());
      if (await dbHelper.isEmailAlreadyExist(email: event.newUser.email)) {
        emit(RegisterFailureState(errorMsg: "Email already exist"));
      } else {
        bool check = await dbHelper.registerUser(event.newUser);
        if (check) {
          emit(RegisterSuccessState());
        } else {
          emit(RegisterFailureState(errorMsg: "Something went wrong"));
        }
      }
    });
  }

  void _onResetRegister(ResetRegisterState event, Emitter<RegisterState> emit) {
  emit(RegisterInitialState(
    user: UserModel.empty(),
    confirmPassword: "",
    errors: {},
  ));
}

}
