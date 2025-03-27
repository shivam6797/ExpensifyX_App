import 'package:ExpensifyX_App/app_routes.dart';
import 'package:ExpensifyX_App/data/local/session_manager.dart';
import 'package:ExpensifyX_App/ui/auth/profile/bloc/profile_bloc.dart';
import 'package:ExpensifyX_App/ui/auth/profile/bloc/profile_event.dart';
import 'package:ExpensifyX_App/ui/auth/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onBack;
  const ProfileScreen({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc,ProfileState>(
      listener: (context, state) {
        if(state is ProfileSuccessState){
         Navigator.pushNamedAndRemoveUntil(context, AppRoutes.ROUTE_LOGIN, (route) => false);
        }else if(state is ProfileFailureState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(state.errorMsg)));
        }
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xff6674d3),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  SessionManager.userEmail,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  SessionManager.userPhone,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Expenses",
                                style: TextStyle(
                                    fontSize: 16,fontFamily:"Poppins", fontWeight: FontWeight.w600)),
                            Text("\$3,734",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff6674d3))),
                          ],
                        ),
                        SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: 0.75,
                          backgroundColor: Colors.grey[300],
                          color: Color(0xff6674d3),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(FontAwesomeIcons.cog, color: Color(0xff6674d3)),
                  title: Text("Settings", style: TextStyle(
                                    fontSize: 15,fontFamily:"Poppins", fontWeight: FontWeight.w600)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.bell, color: Color(0xff6674d3)),
                  title: Text("Notifications", style: TextStyle(
                                    fontSize: 15,fontFamily:"Poppins", fontWeight: FontWeight.w600)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.moneyBillWave,
                      color: Color(0xff6674d3)),
                  title: Text("Manage Subscription", style: TextStyle(
                                    fontSize: 15,fontFamily:"Poppins", fontWeight: FontWeight.w600)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(LogoutUserEvent());
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
        ),
      ),
    );
  }
}
