abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String input; // Either email or phone
  final String password;
  final bool isEmail; // Flag for email/phone login
  final bool rememberMe; //for remember checkbox value

  LoginUserEvent({required this.input, required this.password, required this.isEmail, required this.rememberMe});
}

class EmailChangedEvent extends LoginEvent {
  final String email;
  EmailChangedEvent({required this.email});
}

class PhoneChangedEvent extends LoginEvent {
  final String phone;
  PhoneChangedEvent({required this.phone});
}

class PasswordChangedEvent extends LoginEvent {
  final String password;
  PasswordChangedEvent({required this.password});
}

class ClearFieldErrorEvent extends LoginEvent {
  final String field;
  ClearFieldErrorEvent({required this.field});
}

class ResetLoginState extends LoginEvent {}

class UpdateFocusEvent extends LoginEvent {}
