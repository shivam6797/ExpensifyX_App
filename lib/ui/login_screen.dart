import 'package:ExpensifyX_App/app_routes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool _isObscured = true;
 final FocusNode _phoneFocusNode = FocusNode();
 final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
 @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() {
      setState(() {}); // UI update karega jab focus change hoga
    });
    _passwordFocusNode.addListener(() {
      setState(() {}); // UI update karega jab focus change hoga
    });
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose(); // Memory leak avoid karega
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Login to access your account",
                style: TextStyle(
                    fontSize: 14, fontFamily: "Poppins", color: Colors.grey),
              ),
              const SizedBox(height: 30),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: Color(0xff6674d3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelColor: Colors.white,
                        labelStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12.3,
                            fontWeight: FontWeight.w500),
                        unselectedLabelColor: Colors.black,
                        tabs: const [
                          Tab(
                            text: "Phone Number",
                          ),
                          Tab(text: "Email"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 70, // Fixed height for inputs
                      child: TabBarView(
                        children: [
                          _buildTextField("Phone Number", Icons.phone, false,_phoneFocusNode),
                          _buildTextField("Email", Icons.email, false,_emailFocusNode),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildTextField("Password", Icons.lock, true,_passwordFocusNode),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text(
                        "Remember me",
                        style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.ROUTE_OTP);
                    },
                    child: const Text(
                      "Forget password?",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: Color(0xff6674d3),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context,AppRoutes.ROUTE_MAIN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff6674d3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Or Sign In With",
                style: TextStyle(
                    fontSize: 12, fontFamily: "Poppins", color: Colors.grey),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton("assets/images/googles.png", Colors.red),
                  const SizedBox(width: 20),
                  _socialButton("assets/images/communication.png", Colors.blue),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account?",
                    style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context,AppRoutes.ROUTE_SIGNUP);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: Color(0xff6674d3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, bool isPassword,FocusNode focusNode) {
     bool isFocused = focusNode.hasFocus; 
    Color borderColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        focusNode: focusNode,
        obscureText: isPassword ? _isObscured : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              color: iconColor, fontFamily: "Poppins", fontSize: 14),
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  child: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: iconColor,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: borderColor, width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _socialButton(String image, Color color) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Image.asset(image,fit: BoxFit.contain,height: 25,width: 25,),
    );
  }
}
