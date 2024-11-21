import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';


/// {@template doctor}
/// Doctor widget.
/// {@endtemplate}
class Doctor extends StatefulWidget {
  /// {@macro doctor}
  const Doctor({
    super.key, // ignore: unused_element
  });
  
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _DoctorState? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_DoctorState>();
  
  @override
  State<Doctor> createState() => _DoctorState();
}


/// State for widget Doctor.
class _DoctorState extends State<Doctor> {

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }
  
  @override
  void didUpdateWidget(covariant Doctor oldWidget) {
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
