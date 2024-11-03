import 'package:flutter/material.dart';

class Facebookbutton extends StatelessWidget {
  const Facebookbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
      ),
      onPressed: () {
        // Thêm chức năng đăng nhập Google tại đây
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/image/iconfacebook.png', 
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 10),
          Text(
            "Facebook",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
