import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';


/// {@template RatingStar}
/// RatingStar widget.
/// {@endtemplate}
class RatingStar extends StatefulWidget {
  /// {@macro RatingStar}
  const RatingStar({
    super.key, // ignore: unused_element
  });
  
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _RatingStarState? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_RatingStarState>();
  
  @override
  State<RatingStar> createState() => _RatingStarState();
}


/// State for widget RatingStar.
class _RatingStarState extends State<RatingStar> {

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }
  
  @override
  void didUpdateWidget(covariant RatingStar oldWidget) {
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
  Widget build(BuildContext context) =>
    const Placeholder();
}
