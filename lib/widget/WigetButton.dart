import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_hospital/services/Authservice.dart';

AuthService authService = new AuthService();

class WidgetButton extends StatelessWidget {
  const WidgetButton({super.key, required this.funtionReturnString,required this.iconbutton,required this.textbutton,required this.width});
  final String iconbutton;
  final String textbutton;
  final double width;
  final Future<String?> Function(
          BuildContext context, String? email, String? password)
      funtionReturnString;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
        ),
        onPressed: () async {
          // Gọi hàm funtionReturnString với email và password là rỗng, nếu không cần sử dụng email và password.
          String? email = null; // Hoặc lấy giá trị từ input
          String? password = null;
          await funtionReturnString(context, email, password);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconbutton,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 10),
            Text(
              textbutton,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
