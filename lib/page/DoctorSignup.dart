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

class DoctorSignup extends StatefulWidget {
  const DoctorSignup({
    super.key,
  });

  static _DoctorSignupState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_DoctorSignupState>();

  @override
  State<DoctorSignup> createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

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

  Future<void> _registerDoctor() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await credential.user?.updateDisplayName(_nameController.text.trim());
      // Additional doctor data can be saved to Firestore here
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
        FocusScope.of(context).unfocus();
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
                    "Doctor Registration",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Join our app to manage your schedule and connect with patients.",
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
                    textEditingController: isUsingEmail
                        ? _emailController
                        : _phoneController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textwidget: "Password",
                    textEditingController: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textwidget: "Specialization",
                    textEditingController: _specializationController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textwidget: "Years of Experience",
                    textEditingController: _experienceController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textwidget: "Hospital/Clinic",
                    textEditingController: _hospitalController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textwidget: "Short Bio",
                    textEditingController: _bioController,
                  ),
                  const SizedBox(height: 20),
                  Buttonwidget(
                    textbutton: "Sign Up",
                    paddinghorizontal: 0.35,
                    paddingvertical: 0.02,
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.1,
                    onPressed:() { 
                      authService.signUpWithEmailDoctor(context, _emailController.text, _passwordController.text, _nameController.text, _specializationController.text, int.parse(_experienceController.text) , _hospitalController.text, _bioController.text 
                      ); },
                  ),
                  GestureDetector(
                    onTap: toggleRegisterMethod,
                    child: Text(
                      isUsingEmail
                          ? "Register using phone number"
                          : "Register using email",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
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
                            thickness: 1,
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
