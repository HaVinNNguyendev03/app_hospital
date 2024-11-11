import 'package:flutter/material.dart';
abstract class Authbase {
  Future<String?> loginWithEmail (BuildContext context,String email, String password);
  Future<String?> signUpWithEmail (BuildContext context,String email, String password,String name);
  Future<String?> loginWithPhone(BuildContext context,String verificationId, String smsCode);
  Future<String?> signUpWithPhone(String phoneNumber, Function(String) codeSent);
  Future<String?> loginWithGoogle(BuildContext context);
  Future<String?> signUpWithGoogle(BuildContext context);
}