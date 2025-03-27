import 'package:ExpensifyX_App/app_routes.dart';
import 'package:ExpensifyX_App/data/local/session_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserSession();
  }

 void checkUserSession() async {
    bool isLoggedIn = await SessionManager.isUserLoggedIn();
    bool isIntroSeen = await SessionManager.isIntroSeen();
    
    // Load Session Data
    await SessionManager.loadUserSession();

    Future.delayed(Duration(seconds: 2), () {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_MAIN);
      } else if (isIntroSeen) {
        // Remember Me Credentials Pass Kare
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.ROUTE_LOGIN,
          arguments: {
            "email": SessionManager.isRemembered ? SessionManager.userEmail : "",
            "phone": SessionManager.isRemembered ? SessionManager.userPhone : "",
          },
        );
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_ONBOARDING);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand, children: [
          Container(
            color: Colors.white,
          ),
          Center(
            child: Image.asset(
              'assets/images/expensify_splash_logos.png',
              height: 200,
              width: 200,
            ),
          ),
           Positioned(
            bottom: 280,
             child: Align(
              alignment: Alignment.center,
               child: Text(
                       "ExpensifyX App",
                       style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
                     ),
             ),
           ),
        ]),
      ),
    );
  }
}
