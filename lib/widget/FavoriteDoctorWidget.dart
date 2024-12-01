import 'package:flutter/material.dart';

class FavoriteDoctorWidget extends StatefulWidget {
  final String imagePath;
  final String textDoctor;
  final String textSpecialty;
  final Color backgroundColor;
  final Color textColor;
  final double containerWidth;
  final double containerHeight;
  final double topLeft;
  final double topRight;
  final double boderRadiusBox;
  final double boderRadiusAvt;
  final VoidCallback onTap;

  const FavoriteDoctorWidget({
    Key? key,
    required this.imagePath,
    required this.textDoctor,
    required this.textSpecialty,
    required this.backgroundColor,
    required this.textColor,
    required this.containerWidth,
    required this.containerHeight,
    required this.onTap,
    required this.topLeft,
    required this.topRight,
    required this.boderRadiusBox,
    required this.boderRadiusAvt,
  }) : super(key: key);

  @override
  _FavoriteDoctorWidgetState createState() => _FavoriteDoctorWidgetState();
}

class _FavoriteDoctorWidgetState extends State<FavoriteDoctorWidget> {
  Color _iconColor = Colors.grey; // Màu mặc định

  void _toggleFavorite() {
    setState(() {
      // Đổi màu giữa đỏ và xám
      _iconColor = _iconColor == Colors.red ? Colors.grey : Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.containerWidth,
        height: widget.containerHeight,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.boderRadiusBox),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Hình ảnh với icon love
            Stack(
              children: [
                ClipRRect(
                  borderRadius: (widget.topLeft == 0.0 && widget.topRight == 0.0)
                      ? BorderRadius.circular(widget.boderRadiusAvt)
                      : BorderRadius.only(
                          topLeft: Radius.circular(widget.topLeft),
                          topRight: Radius.circular(widget.topRight),
                        ),
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    width: widget.containerWidth,
                    height: widget.containerHeight * 0.7,
                  ),
                ),
                // Icon love
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: _toggleFavorite,
                    child: Icon(
                      Icons.favorite,
                      color: _iconColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            // Thông tin bác sĩ
            Container(
              width: widget.containerWidth,
              height: widget.containerHeight / 4.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.textDoctor,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.textSpecialty,
                    style: TextStyle(
                      color: widget.textColor.withOpacity(0.7),
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
