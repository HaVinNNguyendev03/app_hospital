import 'package:flutter/material.dart';
import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:app_hospital/services/Authservice.dart';
import 'package:app_hospital/theme.dart';
AuthService authService = new AuthService();
bool _isDataInitialized = false;
class verifyOtp extends StatefulWidget {
  @override
  _verifyOtpState createState() => _verifyOtpState();
}

class _verifyOtpState extends State<verifyOtp> {
  String? uid;
  String? verificationId;
  String? phone;
  String? email;
  int? role;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the uid from arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      uid = args['uid'];
      verificationId = args['verificationId'];
      phone = args['phoneNumber'];
      email = args['email'];
      role = args['role'];
    }
     _isDataInitialized = true; // Đánh dấu đã xử lý,để trách việc rebuil lại widget verifyOtp
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
          
          decoration:
           
           InputDecoration(
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
                ? const Color.fromARGB(255, 255, 255, 255)
                : const Color.fromARGB(255, 217, 217, 217),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                email != null ? "Xác thực Email" : "Xác thực Số điện thoại",
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
                         bool isVerified = false;
                         if(role == 1){
                            if(email != null){
                           isVerified = await authService.verifyOtp(uid!, otpString,'Users');
                        } else{
                           isVerified = await authService.verifyOtpPhone(context, uid!, otpString,verificationId!,phone!);
                        }
                         } else if (role == 2){
                           if(email != null){
                           isVerified = await authService.verifyOtp(uid!, otpString, 'Doctors');
                        } else{
                           isVerified = await authService.verifyOtpPhone(context, uid!, otpString,verificationId!,phone!);
                        }
                         }
                        if (isVerified) {
                    // OTP verified successfully
                    await Navigator.pushNamedAndRemoveUntil(context, '/success', (route) => false);
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
      ),
    );
  }
}
