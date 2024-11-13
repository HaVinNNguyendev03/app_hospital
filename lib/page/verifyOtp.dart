import 'package:flutter/material.dart';
import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:app_hospital/services/Authservice.dart';

AuthService authService = new AuthService();

class verifyOtp extends StatefulWidget {
  @override
  _verifyOtpState createState() => _verifyOtpState();
}

class _verifyOtpState extends State<verifyOtp> {
  String? uid;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the uid from arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      uid = args['uid'];
    }
  }
  List<String> otp = ["", "", "", "", "", ""]; // Holds OTP digits
  void _onOtpEntered(int index, String value) {
    setState(() {
      otp[index] = value;
    });
  }
  Widget _buildOTPField(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          onChanged: (value) {
            _onOtpEntered(index, value);
            if (value.isNotEmpty && index < otp.length) {
              FocusScope.of(context).nextFocus();
            }
          },
          decoration: InputDecoration(
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.pink),
            ),
            filled: true,
            fillColor: index < 6 && otp[index].isNotEmpty
                ? Colors.pink[100]
                : Colors.grey[200],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verify your Phone number",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Enter your OTP code here",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) => _buildOTPField(index)),
            ),
            SizedBox(height: 16),
             Buttonwidget(
                    textbutton: "Sign Up",
                    paddinghorizontal: 0.35,
                    paddingvertical: 0.02,
                    onPressed: () async{
                      String otpString = otp.join(); 
                      bool isVerified = await authService.verifyOtp(uid!, otpString);
                      if (isVerified) {
                  // OTP verified successfully
                  await Navigator.pushNamed(context, '/success', arguments: {});
                } else {
                  // OTP verification failed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("OTP verification failed")),
                  );
                }
                    },
                  ),
            SizedBox(height: 16),
            Text(
              "Didn't you receive any code?",
              style: TextStyle(color: Colors.grey),
            ),
            GestureDetector(
              onTap: () {
                // Implement resend code functionality
              },
              child: Text(
                "RESEND NEW CODE",
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
