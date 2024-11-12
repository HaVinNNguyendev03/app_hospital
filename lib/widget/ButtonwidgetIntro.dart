import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/// {@template Buttonwidget}
/// Buttonwidget widget.
/// {@endtemplate}
class Buttonwidget extends StatefulWidget {
  /// {@macro Buttonwidget}
  const Buttonwidget({
    super.key, // ignore: unused_element
    required this.textbutton,
    required this.paddinghorizontal,
    required this.paddingvertical,
    required this.onPressed, // ignore: unused_element
  });
  final String textbutton;
  final double paddingvertical;
  final double paddinghorizontal;
  final VoidCallback onPressed;
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _ButtonwidgetState? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_ButtonwidgetState>();
  
  @override
  State<Buttonwidget> createState() => _ButtonwidgetState();
}


/// State for widget Buttonwidget.
class _ButtonwidgetState extends State<Buttonwidget> {

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
    return ElevatedButton(
  onPressed: () {
    widget.onPressed();
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green, // Màu nền cho nút
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Độ bo tròn góc
    ),
    padding: EdgeInsets.symmetric(vertical:widget.paddingvertical, horizontal: widget.paddinghorizontal),
  ),
  
  child: Text(
    widget.textbutton,
    style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white) // Màu chữ
  ),
);
  }
}
