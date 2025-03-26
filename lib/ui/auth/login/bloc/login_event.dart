abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String input; // Either email or phone
  final String password;
  final bool isEmail; // Flag for email/phone login

  LoginUserEvent({required this.input, required this.password, required this.isEmail});
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

class ResetLoginState extends LoginEvent {}
