import 'package:ExpensifyX_App/data/model/user_model.dart';

abstract class RegisterEvent{}

class RegisterUserEvent extends RegisterEvent{
  UserModel newUser;
  RegisterUserEvent({required this.newUser});
}

class FirstNameChangedEvent extends RegisterEvent{
  final String value;
  FirstNameChangedEvent({required this.value});
}


class LastNameChangedEvent extends RegisterEvent{
  final String value;
  LastNameChangedEvent({required this.value});
}

  class EmailChangedEvent extends RegisterEvent{
    final String value;
    EmailChangedEvent({required this.value});
  }

class DateofBirthChangedEvent extends RegisterEvent{
  final String value;
  DateofBirthChangedEvent({required this.value});
}

class PhoneChangedEvent extends RegisterEvent{
  final String value;
  PhoneChangedEvent({required this.value});
}

class PasswordChangedEvent extends RegisterEvent{
  final String value;
  PasswordChangedEvent({required this.value});
}

class ConfirmPasswordChangedEvent extends RegisterEvent{
  final String value;
  ConfirmPasswordChangedEvent({required this.value});
}

class FormSubmittedEvent extends RegisterEvent{}

class ResetRegisterState extends RegisterEvent {}

