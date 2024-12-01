import 'package:flutter/material.dart';
class CategoryDoctorWidget extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String textDoctor;
  final String textSpecialty;
  final Color textColor;
  final double containerWidth;
  final double containerHeight;
  final double topLeft;
  final double topRight;
  final double boderRadiusBox;
  final double boderRadiusAvt;
  
  final VoidCallback onTap; // Tham số hành động khi nhấn vào

  const CategoryDoctorWidget({
    Key? key,
    required this.backgroundColor,
    required this.imagePath,
    required this.textDoctor,
    required this.textSpecialty,
    required this.textColor,
    required this.containerWidth,
    required this.containerHeight,
    required this.onTap,
    required this.topLeft ,
    required this.topRight,
    required this.boderRadiusBox,
    required this.boderRadiusAvt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Kích hoạt sự kiện khi nhấn
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(boderRadiusBox),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Hình ảnh
            ClipRRect(
              borderRadius: (topLeft == 0.0 && topRight == 0.0)
    ? BorderRadius.circular(boderRadiusAvt)
    : BorderRadius.only(
        topLeft:  Radius.circular(topLeft) ,
        topRight:  Radius.circular(topRight) ,
      ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: containerWidth,
                height: containerHeight * 0.7,
              ),
            ),
            // Thông tin bác sĩ
            Container(
              width: containerWidth,
              height: containerHeight / 4.2, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textDoctor,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    textSpecialty,
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
