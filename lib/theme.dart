import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
final Alignment customBegin = Alignment(-0.95, -0.95); 
final Alignment customEnd = Alignment(0.95, 0.95);      
class AppTheme {
  // Gradient nền được định nghĩa trong AppTheme
  static LinearGradient backgroundGradient = LinearGradient(
    colors: const [
      Colors.blueAccent,
      Colors.white,
      Colors.greenAccent,
    ],
     stops: [0.0, 0.8, 1.0],
     begin: customBegin,
     end: customEnd,
  );

  // Cấu hình ThemeData với font chữ Rubik và màu nền mặc định
  static ThemeData themeData = ThemeData(
    fontFamily: GoogleFonts.rubik().fontFamily, // Sử dụng font chữ Rubik
    scaffoldBackgroundColor: Colors.transparent, // Đặt nền mặc định trong suốt để thấy gradient
    textTheme: GoogleFonts.rubikTextTheme(), // Áp dụng Rubik cho tất cả các văn bản
  );
}
