import 'package:app_hospital/widget/Buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:app_hospital/theme.dart';
import 'package:google_fonts/google_fonts.dart';
/// {@template intro1}
/// Intro1 widget.
/// {@endtemplate}
class Intro1 extends StatefulWidget {
  /// {@macro intro1}
  const Intro1({
    super.key, // ignore: unused_element
  });
  
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _Intro1State? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_Intro1State>();
  
  @override
  State<Intro1> createState() => _Intro1State();
}


/// State for widget Intro1.
class _Intro1State extends State<Intro1> {

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
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
            Image.asset('assets/image/doctorintro.png',),
            const SizedBox(height: 20,),
            Text("Find Trusted Doctors", textAlign: TextAlign.center,style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.", textAlign: TextAlign.center,style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal)),
            const SizedBox(height: 30,),
            Buttonwidget(textbutton: "Get Started",paddinghorizontal: screenWidth * 0.08,paddingvertical: screenHeight * 0.02,onPressed: () => Navigator.pushNamed(context, '/intro2'),),
          ],
        ),
      )
    ),);
  }
}
