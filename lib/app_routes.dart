import 'package:ExpensifyX_App/onboarding_screen.dart';
import 'package:ExpensifyX_App/splash_screen.dart';
import 'package:ExpensifyX_App/ui/auth/login/login_screen.dart';
import 'package:ExpensifyX_App/ui/auth/register/signup_screen.dart';
import 'package:ExpensifyX_App/ui/home_screen.dart';
import 'package:ExpensifyX_App/ui/main_screen.dart';
import 'package:ExpensifyX_App/ui/otp_screen.dart';
import 'package:ExpensifyX_App/ui/auth/profile/profile_screen.dart';
import 'package:ExpensifyX_App/ui/statistic_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String ROUTE_SPLASH = "/";
  static const String ROUTE_ONBOARDING = "/onboarding";
  static const String ROUTE_LOGIN = "/login";
  static const String ROUTE_SIGNUP = "/signUp";
  static const String ROUTE_OTP = "/otp";
  static const String ROUTE_HOME = "/home";
  static const String ROUTE_MAIN = "/main";
  static const String ROUTE_STATISTIC = "/statistic";
  static const String ROUTE_PROFILE = "/profile";

  static Map<String, WidgetBuilder> getRoutes() => {
        ROUTE_SPLASH: (context) => SplashScreen(),
        ROUTE_ONBOARDING: (context) => OnboardingScreeen(),
        ROUTE_LOGIN: (context) => LoginScreen(),
        ROUTE_SIGNUP: (context) => SignUpScreen(),
        ROUTE_OTP: (context) => OTPScreen(),
        ROUTE_HOME: (context) => HomeScreen(),
        ROUTE_MAIN: (context) => MainScreen(),
        ROUTE_STATISTIC: (context) => StatisticScreen(),
        ROUTE_PROFILE: (context) => ProfileScreen(
              onBack: () {},
            ),
      };
}
