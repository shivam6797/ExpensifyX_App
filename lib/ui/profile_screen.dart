import 'package:ExpensifyX_App/app_routes.dart';
import 'package:ExpensifyX_App/data/local/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
   final VoidCallback onBack; 
  const ProfileScreen({Key? key,required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff6674d3),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
               onBack();
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                size: 17,
              )),
          iconTheme: IconThemeData(color: Colors.white, size: 22),
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: Colors.white),
          )),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xff6674d3),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              "Email: ${SessionManager.userEmail}",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: Colors.black),
            ),
            Text(
              "Phone: ${SessionManager.userPhone}",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  color: Colors.black),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await SessionManager.logoutUser();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_LOGIN);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff6674d3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text("Logout",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
