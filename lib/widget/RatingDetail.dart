import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:google_fonts/google_fonts.dart';


/// {@template RatingDetail}
/// RatingDetail widget.
/// {@endtemplate}
class RatingDetail extends StatefulWidget {
  /// {@macro RatingDetail}
  const RatingDetail({
    super.key,
    required this.heightscreen,
    required this.widthscreen // ignore: unused_element
  });
  final double heightscreen;
  final double widthscreen;
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _RatingDetailState? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_RatingDetailState>();
  
  @override
  State<RatingDetail> createState() => _RatingDetailState();
}


/// State for widget RatingDetail.
class _RatingDetailState extends State<RatingDetail> {

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }
  
  @override
  void didUpdateWidget(covariant RatingDetail oldWidget) {
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
    return Container(
        height: 200,
        width: 500,
        padding:  EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: widget.heightscreen * 0.2,
                  width: widget.widthscreen * 0.8,
                  child: Column(
                    children: [
                      Text(
                        "4.0",
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 16, decoration: TextDecoration.none,color: Colors.black),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star_half, color: Colors.amber),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "234",
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 16, decoration: TextDecoration.none,color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: List.generate(5, (index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Text("${5 - index}",style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 16, decoration: TextDecoration.none,color: Colors.grey),)),
                          SizedBox(width: 8),
                          Container(
                            height: 20,
                            width: 20,
                            child: LinearProgressIndicator(
                              value: [0.86, 0.47, 0.16, 0.09, 0.07][index],
                              backgroundColor: Colors.grey[300],
                              color: [
                                Colors.green,
                                Colors.greenAccent,
                                Colors.yellow,
                                Colors.orange,
                                Colors.red
                              ][index],
                            ),
                          ),
                          SizedBox(width: 8),
                          SizedBox( width: 20,
                            height: 20,child: Text("${[86, 47, 16, 9, 7][index]}",style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 16, decoration: TextDecoration.none,color: Colors.grey),)),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
