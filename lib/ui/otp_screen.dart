import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff6674d3),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text(
            "Verification",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xff6674d3),
                child: Icon(Icons.thumb_up_alt_rounded,
                    color: Colors.white, size: 40),
              ),
              SizedBox(height: 25),
              Text(
                "Verification Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Enter the verification code we've sent to your\nsarkarraj0766@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.2,
                  color: Colors.black87,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 40),
              Pinput(
                length: 4,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                controller: otpController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: focusedPinTheme,
                showCursor: true,
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff6674d3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(fontSize: 14, fontFamily: "Poppins"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        color: Color(0xff6674d3),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
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
}
