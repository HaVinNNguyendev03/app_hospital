import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/theme.dart';
import 'package:app_hospital/services/Authservice.dart';
import 'package:google_fonts/google_fonts.dart';
/// {@template bookScreen}
/// BookScreen widget.
/// {@endtemplate}
class BookScreen extends StatefulWidget {
  /// {@macro bookScreen}
  const BookScreen({
    super.key, // ignore: unused_element
  });
  
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _BookScreenState? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_BookScreenState>();
  
  @override
  State<BookScreen> createState() => _BookScreenState();
}


/// State for widget BookScreen.
class _BookScreenState extends State<BookScreen> {

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }
  
  @override
  void didUpdateWidget(covariant BookScreen oldWidget) {
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
  
  @override
     Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(child: Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image/booking.png',),
            const SizedBox(height: 20,),
            Text("Đặt Lịch Khám Ngay", textAlign: TextAlign.center,style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            Text("App Hospital cung cấp diện dụng đặt lịch khám ngay trên mạng.Với nhiều bác sĩ kinh nghiệm đến từ nhiều đơn vị trên địa bàn tỉnh", textAlign: TextAlign.center,style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal)),
            const SizedBox(height: 30,),
            Buttonwidget(textbutton: "Đặt Ngay",paddinghorizontal: screenWidth * 0.08,paddingvertical: screenHeight * 0.02,height: screenHeight * 0.08,width: screenWidth * 0.5,onPressed: () => Navigator.pushReplacementNamed(context, '/intro2'),),
          ],
        ),
      )
    ),);
  }
  
}
