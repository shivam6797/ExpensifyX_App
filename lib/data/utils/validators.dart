import 'package:intl/intl.dart';

class Validators {
  //  check Name
  static String? validateName(String value, String fieldName) {
    if (value.isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  // check email
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is required";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  // check phone number vaildation (10 digits)
  static String? validatePhone(String value) {
    if (value.isEmpty) {
      return "Phone number is required";
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter a valid 10-digits phone number";
    }
    return null;
  }

  // check date of birth
static String? validateDOB(String value) {
  if (value.isEmpty) {
    return "Date of Birth is required";
  }
  try {
    final date = DateFormat("dd/MM/yyyy").parseStrict(value);
    
    if (date.isAfter(DateTime.now())) {
      return "Future dates are not allowed!";
    }
    return null; // No error
  } catch (e) {
    return "Invalid Date Format! Use dd/MM/yyyy."; // Format galat hai
  }
}


  //  check password
 static String? validatePassword(String value) {
  print("Validating Password: $value"); 
  
  if (value.isEmpty) {
    return "Password cannot be empty";
  } else if (value.length != 6) {
    return "Password must be exactly 6 characters";
  } else if (!RegExp(r'^[A-Za-z0-9]{6}$').hasMatch(value)) {
    return "Password must contain only letters or numbers";
  }

  return null; 
}


  // check confirmPassword
  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Confirm password is required";
    } else if (password != confirmPassword) {
      return "Password do not match";
    }
    return null;
  }
}
