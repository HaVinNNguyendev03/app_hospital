import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String text;
  final Color textColor;

  const CategoryWidget({
    Key? key,
    required this.backgroundColor,
    required this.imagePath,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.25,
      height: screenHeight * 0.13,
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(imagePath),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
