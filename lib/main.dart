import 'package:app_hospital/page/intro2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_hospital/theme.dart';
import 'package:app_hospital/page/home.dart';
import 'package:app_hospital/page/intro1.dart';
import 'package:app_hospital/page/login.dart';
import 'package:app_hospital/page/Signup.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  try {
    await Firebase.initializeApp();
    print("Kết nối Firebase thành công!");
  } catch (e) {
    print("Kết nối Firebase thất bại: $e");
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       initialRoute: '/', // Đặt trang mặc định là HomePage
       routes: {
        '/intro2': (context) => Intro2(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/homepage': (context) => Home(),
      },
       theme: AppTheme.themeData,
       home: Intro1(),
    );
  }
}
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.backgroundGradient, // Áp dụng gradient từ AppTheme  
      ),
       child: DefaultTextStyle(
        style: TextStyle(
          decoration: TextDecoration.none, // Set decoration mặc định
        ),
        child: child,
      ),
    );
  }
}

