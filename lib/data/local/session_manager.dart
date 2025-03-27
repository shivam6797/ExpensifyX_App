import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static String userEmail = "";
  static String userPhone = "";
  static bool isRemembered = false; // Remember Me Status

  // save user session & Remember credentials
  static Future<void> saveUserSession(
      {required String userId,
      required String email,
      required String phone,
      required bool rememberMe}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_logged_in", true);
    await prefs.setString("user_id", userId);
    await prefs.setString("user_email", email);
    await prefs.setString("user_phone", phone);
    await prefs.setBool("is_remembered", rememberMe);
    userEmail = email;
    userPhone = phone;
    isRemembered = rememberMe;
  }

  // Load User session & Remembered Credentials
  static Future<void> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString("user_email") ?? "";
    userPhone = prefs.getString("user_phone") ?? "";
    isRemembered = prefs.getBool("is_remembered") ?? false;
  }

  // Check if User logged In
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_logged_in") ?? false;
  }

  //  Check if intro is seen
  static Future<bool> isIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_intro_seen") ?? false;
  }

  // Mark intro as seen
  static Future<void> setIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_intro_seen", true);
  }

  //  Logout User (Keep Credentials if Remembered)
  static Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("is_logged_in");
    await prefs.remove("user_id");
    if (!isRemembered) {
      await prefs.remove("user_email");
      await prefs.remove("user_phone");
      await prefs.remove("is_remembered");
      userEmail = "";
      userPhone = "";
      isRemembered = false;
    }
  }
}
