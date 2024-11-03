import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';


/// {@template DialogNotification}
/// DialogNotification widget.
/// {@endtemplate}
class DialogNotification extends StatelessWidget {
  /// {@macro DialogNotification}
  const DialogNotification({
    super.key, // ignore: unused_element
    required this.title,
    required this.titleNotification,
    required this.textNotification,
  });
  final String title;
  final String titleNotification;
  final String textNotification;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: EdgeInsets.all(20),
      contentTextStyle: GoogleFonts.rubik(),
      content:
      Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Success
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.thumb_up,
              color: Colors.green,
              size: 50,
            ),
          ),
          const SizedBox(height: 20),
          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle
          Text(
            titleNotification,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          // Details Text
          Text(
            textNotification,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          // Button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              backgroundColor: Colors.green,
            ),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
             
            },
            child: const Text(
              "Edit",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )
          ]
      ),
    );
  }
}
