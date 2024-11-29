import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:app_hospital/widget/RatingDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class RatingDoctorWidget extends StatelessWidget {
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
  final double rating;
  final String expyear;
  final VoidCallback onTap; // Tham số hành động khi nhấn vào

  const RatingDoctorWidget({
    Key? key,
    required this.backgroundColor,
    required this.imagePath,
    required this.textDoctor,
    required this.textSpecialty,
    required this.textColor,
    required this.containerWidth,
    required this.containerHeight,
    required this.onTap,
    required this.topLeft,
    required this.topRight,
    required this.boderRadiusBox,
    required this.boderRadiusAvt,
    required this.rating,
    required this.expyear,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //khối thông tin bác sĩ
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              // Hình ảnh bác sĩ
              ClipRRect(
                borderRadius: (topLeft == 0.0 && topRight == 0.0)
                    ? BorderRadius.circular(boderRadiusAvt)
                    : BorderRadius.only(
                        topLeft: Radius.circular(topLeft),
                        topRight: Radius.circular(topRight),
                      ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: containerWidth * 0.3,
                  height: containerHeight * 0.6,
                ),
              ),
              // Thông tin bác sĩ
              Container(
                width: containerWidth * 0.6,
                height: containerHeight * 0.6,
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
                     Text(
                     'Kinh nghiệm: ${expyear}' ,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                     Text(
                     '200 luợt khám' ,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  //rating
                    RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
            ],
          ),
          //khối giờ rảnh và book now
          SizedBox(height: 8),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Giờ rảnh bác sĩ
              Container(
                width: containerWidth * 0.4,
                height: containerHeight * 0.3,
                child: Column(
                  children: [
                    Text(
                      "Giờ rảnh",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "8:00 - 9:00",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Thông tin bác sĩ
              Container(
                width: containerWidth * 0.4,
                height: containerHeight * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Buttonwidget(
                      textbutton: "Đặt Lịch",
                      paddinghorizontal: 0.3,
                      paddingvertical: 0.2,
                      height: containerHeight * 0.2,
                      width: containerWidth * 0.3,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
          ]
        ),
      ),
    );
  }
}
