import 'package:ExpensifyX_App/app_routes.dart';
import 'package:ExpensifyX_App/data/local/db_helper.dart';
import 'package:ExpensifyX_App/ui/auth/login/bloc/login_bloc.dart';
import 'package:ExpensifyX_App/ui/auth/login/bloc/login_event.dart';
import 'package:ExpensifyX_App/ui/auth/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool _isObscured = true;
  bool _isPhoneLogin = true;
  bool isLoading = false;
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(ResetLoginState());
    Future.delayed(Duration(seconds: 1), () {
      final state = context.read<LoginBloc>().state;
      print(
          "After Reset State: ${state is LoginValidationState ? state.errors : 'No errors'}");
    });
    DbHelper.getInstance().testQuery();
    _shakeController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _shakeAnimation = Tween<double>(begin: 0, end: 0).animate(_shakeController);
    _phoneFocusNode.addListener(() {
      setState(() {});
    });
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  void _startShakeAnimation() {
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 1),
    ]).animate(_shakeController);

    _shakeController.forward(from: 0);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

    _phoneFocusNode.removeListener(_onFocusChange);
    _emailFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);

    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
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
                        onTap: (index) {
                          setState(() {
                            _isPhoneLogin = (index == 0);
                          });
                        },
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
                      height: 75,
                      child: TabBarView(
                        children: [
                          _buildTextField(
                              "Phone Number",
                              Icons.phone,
                              false,
                              _phoneFocusNode,
                              phoneController,
                              (value) => PhoneChangedEvent(phone: value),
                              (state) =>
                                  state.errors[DbHelper.USER_COLUMN_PHONE]),
                          _buildTextField(
                              "Email",
                              Icons.email,
                              false,
                              _emailFocusNode,
                              emailController,
                              (value) => EmailChangedEvent(email: value),
                              (state) =>
                                  state.errors[DbHelper.USER_COLUMN_EMAIL]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildTextField(
                  "Password",
                  Icons.lock,
                  true,
                  _passwordFocusNode,
                  passwordController,
                  (value) => PasswordChangedEvent(password: value),
                  (state) => state.errors[DbHelper.USER_COLUMN_PASSWORD]),
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
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  print("Current State: $state");
                  if (state is LoginSuccessState) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Login Successful!"),
                          backgroundColor: Colors.green),
                    );
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.pushNamed(context, AppRoutes.ROUTE_MAIN);
                    });
                  } else if (state is LoginFailureState) {
                    print("Error Message: ${state.errorMsg}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.errorMsg),
                          backgroundColor: Colors.red),
                    );
                    _startShakeAnimation();
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    print("Bloc State: $state");
                    bool isLoading =
                        state is LoginLoadingState;

                    return AnimatedBuilder(
                        animation: _shakeAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_shakeAnimation.value, 0),
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      final identifier = _isPhoneLogin
                                          ? phoneController.text.trim()
                                          : emailController.text.trim();
                                      final password =
                                          passwordController.text.trim();
                                      context.read<LoginBloc>().add(
                                            LoginUserEvent(
                                                input: identifier,
                                                password: password,
                                                isEmail: !_isPhoneLogin),
                                          );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff6674d3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 45,
                                child: Center(
                                  child: isLoading
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Logging in...",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Poppins",
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          "Log In",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins",
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
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
                      Navigator.pushNamed(context, AppRoutes.ROUTE_SIGNUP);
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

  Widget _buildTextField(
      String label,
      IconData icon,
      bool isPassword,
      FocusNode focusNode,
      TextEditingController controller,
      Function(String) event,
      String? Function(LoginValidationState state) errorTextSelector) {
    bool isFocused = focusNode.hasFocus;
    Color borderColor = isFocused ? const Color(0xff6674d3) : Colors.black54;
    Color iconColor = isFocused ? const Color(0xff6674d3) : Colors.black54;

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      String? errorText;
      if (state is LoginValidationState) {
        errorText = errorTextSelector(state);
      } else {
        errorText = null;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45, 
            margin: EdgeInsets.only(top:5),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              obscureText: isPassword ? _isObscured : false,
              onChanged: (value) {
                context.read<LoginBloc>().add(event(value));
              },
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                    color: iconColor, fontFamily: "Poppins", fontSize: 14),
                prefixIcon: Icon(icon, color: iconColor),
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
          ),
          if (errorText != null) ...[
            const SizedBox(height:5),
            Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12, fontFamily:"Poppins"),
            ),
          ],
        ],
      );
    });
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
      child: Image.asset(
        image,
        fit: BoxFit.contain,
        height: 25,
        width: 25,
      ),
    );
  }
}
