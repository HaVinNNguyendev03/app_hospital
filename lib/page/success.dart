import 'package:flutter/material.dart';
import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:app_hospital/theme.dart';
class Success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                  size: 80,
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Thành Công",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Bạn đã xác thực thành công",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 32),
              Buttonwidget(
                textbutton: "Trở Lại Đăng Nhập",
                paddinghorizontal: 0.35,
                paddingvertical: 0.02,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
