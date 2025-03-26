import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{
    static String userEmail = "";
  static String userPhone = "";

    // save user credentials 
  static Future<void> saveUserSession({required String userId , required String email , required String phone})async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_logged_in", true);
    await prefs.setString("user_id", userId);
    await prefs.setString("user_email", email);
    await prefs.setString("user_phone", phone);
     userEmail = email; 
    userPhone = phone;
  }

   static Future<void> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString("user_email") ?? "";
    userPhone = prefs.getString("user_phone") ?? "";
  }

    // check if user loggedIn 
  static Future<bool> isUserLoggedIn() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_logged_in") ?? false;
  }

    // Save that intro has been seen
  static Future<void> setIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_intro_seen", true);
  }

  //  Check if intro is seen
  static Future<bool> isIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_intro_seen") ?? false;
  }


  //  When user logout all remove data
  static Future<void> logoutUser()async{
   final prefs = await SharedPreferences.getInstance();
    await prefs.remove("is_logged_in");
    await prefs.remove("user_id");
    await prefs.remove("user_email");
    await prefs.remove("user_phone");
      userEmail = "";
    userPhone = "";
  }
}