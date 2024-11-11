import 'dart:developer';
import 'package:app_hospital/widget/TextFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/theme.dart';
import 'package:app_hospital/widget/GoogleButton.dart';
import 'package:app_hospital/widget/FacebookButton.dart';
import 'package:app_hospital/widget/Dialogbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_hospital/widget/Buttonwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_hospital/services/Authservice.dart';
AuthService authService = new AuthService();
/// {@template login}
/// Login widget.
/// {@endtemplate}
class Login extends StatefulWidget {
  /// {@macro login}
  const Login({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _LoginState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_LoginState>();

  @override
  State<Login> createState() => _LoginState();
}

/// State for widget Login.
class _LoginState extends State<Login> {
  final TextEditingController _emailController  = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /* #region Lifecycle */
  @override

  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant Login oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */
  Future<void> _Login() async {
    try {
       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Đăng nhập thành công, chuyển hướng sang trang Home
      Navigator.pushReplacementNamed(context, '/homepage', arguments: {
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName ?? "No Name",
      });
    } catch (e) {
       showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Failed"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } 
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenHeight);
    print(screenWidth);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Xóa focus khi nhấn ra ngoài
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: AppTheme.backgroundGradient,
          ),
          child: ListView(
            padding:
                const EdgeInsets.symmetric(vertical: 100.0, horizontal: 10.0),
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/image/logoapphospital.png'),
                  const SizedBox(height: 20),
                  Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Welcome back to the app hospital. Here, you can access your health information.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(textwidget: "Email",textEditingController: _emailController,),
                  const SizedBox(height: 20),
                  TextFieldWidget(textwidget: "Password", textEditingController: _passwordController,),
                  const SizedBox(height: 20),
                  Buttonwidget(
                    textbutton: "Login",
                    paddinghorizontal: screenWidth * 0.37,
                    paddingvertical: screenHeight * 0.02,
                    onPressed: () {
                      // _Login();
                      authService.loginWithEmail(context, _emailController.text.trim(), _passwordController.text.trim());
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoogleButton(
                        funtionReturnString: (context, email, password) => authService.loginWithGoogle(context),
                      ),
                      const SizedBox(width: 50),
                      Facebookbutton(),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                         showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        child:  Dialogbox(content: 'Enter your email for the verification proccesss,we will send 4 digits code to your email.',labeltext: 'Email',title: 'Forgot Password',screenHeight: screenHeight,screenWidth: screenWidth,),
      ),
    );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.blue, // Màu sắc cho chữ
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Thực hiện điều hướng tới màn hình Forgot Password hoặc xử lý reset password
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          "Don't have an account? Join us",
                          style: TextStyle(
                            color: Colors.blue, // Màu sắc cho chữ
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
