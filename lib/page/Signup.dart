import 'dart:developer';
import 'package:app_hospital/widget/TextFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/theme.dart';
import 'package:app_hospital/widget/WigetButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:app_hospital/widget/DialogNotification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_hospital/services/Authservice.dart';

AuthService authService = new AuthService();
/// {@template Signup}
/// Signup widget.
/// {@endtemplate}
class Signup extends StatefulWidget {
  /// {@macro Signup}
  const Signup({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _SignupState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_SignupState>();

  @override
  State<Signup> createState() => _SignupState();
}

/// State for widget Signup.
class _SignupState extends State<Signup> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  var iconbuttongoogle = 'assets/image/icongoogle.png';
  var iconbuttonfacebook = 'assets/image/iconfacebook.png';
  var iconbuttonPhone = 'assets/image/iconphone.png';
  var textbuttongoogle = 'Google';
  var textbuttonfacebook = 'Facebook';
  var textbuttonPhone = 'Phone';
  bool isUsingEmail = true;
   void toggleRegisterMethod() {
    setState(() {
      isUsingEmail = !isUsingEmail;
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
      _phoneController.clear();
    });
  }
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  // void didUpdateWidget(covariant Signup oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // Widget configuration changed
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // The configuration of InheritedWidgets has changed
  //   // Also called after initState but before build
  // }

  @override
  void dispose() {
    // Permanent removal of a tree stent
   
    super.dispose();
  }

  /* #endregion */
  Future<void> _Register() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await credential.user?.updateDisplayName(_nameController.text.trim());
      showSuccessDialog(
        context,
        "Thank You!",
        "Your Signup Successful",
        "You can login now",
      );
      log(credential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Xóa focus khi nhấn ra ngoài
      },
      child: Scaffold(
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
                  TextFieldWidget(
                    textwidget: "Name",
                    textEditingController: _nameController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textwidget: isUsingEmail ? "Email" : "Phone Number",
                    textEditingController:isUsingEmail ? _emailController : _phoneController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textwidget: "Password",
                    textEditingController: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  Buttonwidget(
                    textbutton: "Sign Up",
                    paddinghorizontal: 0.35,
                    paddingvertical: 0.02,
                    onPressed: () {
                     isUsingEmail ? authService.signUpWithEmail(context,_emailController.text,_passwordController.text,_nameController.text) : authService.signUpWithPhone(context,_phoneController.text,_passwordController.text,_nameController.text) ;
                    },
                  ),
                  GestureDetector(
  onTap: toggleRegisterMethod, // Gọi hàm khi nhấn vào đoạn chữ
  child: Text(
    isUsingEmail ? "Đăng ký bằng số điện thoại" : "Đăng ký bằng email",
    style: TextStyle(
      color: Colors.blue, // Màu chữ để hiển thị như một liên kết
      decoration: TextDecoration.underline, // Gạch chân để giống liên kết
    ),
  ),
),
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth * 0.85,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            thickness: 1, // Độ dày của đường
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.85,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WidgetButton(
                          funtionReturnString: (context, email, password) => authService.signUpWithGoogle(context),
                          iconbutton: iconbuttongoogle,
                          textbutton: textbuttongoogle,
                          ),
                        const SizedBox(width: 0),
                        WidgetButton(
                          funtionReturnString: (context, email, password) => authService.signUpWithGoogle(context),
                          iconbutton: iconbuttonfacebook,
                          textbutton: textbuttonfacebook,
                        ),
                         WidgetButton(
                          funtionReturnString: (context, email, password) => authService.signUpWithGoogle(context),
                          iconbutton: iconbuttonPhone,
                          textbutton: textbuttonPhone,
                        ),
                      ],
                    ),
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

void showSuccessDialog(BuildContext context, String title,
    String titleNotification, String textNotification) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DialogNotification(
        title: title,
        titleNotification: titleNotification,
        textNotification: textNotification,
      );
    },
  );
}
