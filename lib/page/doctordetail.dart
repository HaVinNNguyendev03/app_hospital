import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/theme.dart';
import 'package:app_hospital/services/Authservice.dart';
import 'package:google_fonts/google_fonts.dart';
String formatNumber(int number) {
  if (number >= 1000000000) {
    return '${(number / 1000000000).toStringAsFixed(1)} Tỷ'; // Hàng tỷ
  } else if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)} Tr'; // Hàng triệu
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)} N'; // Hàng nghìn
  } else {
    return number.toString(); // Số nhỏ hơn 1000 giữ nguyên
  }
}
/// {@template DoctorDetail}
/// DoctorDetail widget.
/// {@endtemplate}
class DoctorDetail extends StatefulWidget {
  /// {@macro DoctorDetail}
  const DoctorDetail({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _DoctorDetailState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_DoctorDetailState>();

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

/// State for widget DoctorDetail.
class _DoctorDetailState extends State<DoctorDetail> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant DoctorDetail oldWidget) {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Column(
          children: [
            // Header hoặc tiêu đề
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  // Nút quay lại
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Quay lại màn hình trước đó
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white, // Màu nền của nút
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2), // Bóng đổ
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.grey, // Màu của icon
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Khoảng cách giữa nút và tiêu đề
                  // Tiêu đề
                  Text(
                    "Doctor Details",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // ListView hiển thị danh sách chi tiết
            Expanded(
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Hình ảnh và tên bác sĩ
                        Stack(
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'assets/image/avatabacsi.png',
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Bác Sĩ Phương",
                                  style: GoogleFonts.roboto(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Chuyên khoa Răng Hàm Mặt\nCông tác và làm việc tại bệnh viện Phúc Hưng",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow[700], size: 20),
                                    Icon(Icons.star,
                                        color: Colors.yellow[700], size: 20),
                                    Icon(Icons.star,
                                        color: Colors.yellow[700], size: 20),
                                    Icon(Icons.star_half,
                                        color: Colors.yellow[700], size: 20),
                                    Icon(Icons.star_outline,
                                        color: Colors.grey, size: 20),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$28.00/hr",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 20,
                              child: IconButton(
                                icon: Icon(Icons.favorite, color: Colors.red),
                                onPressed: () {
                                  // Thêm vào danh sách yêu thích
                                  print("Added to favorites");
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Các chỉ số
                        Container(
                          width: screenWidth * 0.8,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // Màu bóng
                                blurRadius: 8, // Độ mờ của bóng
                                spreadRadius:
                                    2, // Độ lan tỏa của bóng (bóng rộng hơn)
                                offset: Offset(0,
                                    0), // Không có offset để bóng trải đều cả 4 hướng
                              ),
                            ],
                          ),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                buildInfoBox("500 Năm", "Kinh Nghiệm"),
                                buildInfoBox(formatNumber(2100000), "Lượt Khám"),
                                buildInfoBox(formatNumber(1110000), "Đánh giá"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Danh sách dịch vụ
                        Column( 
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chuyên khám",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            buildServiceItem(
                                "1. Khám răng thẩm mỹ, xác định cỡ răng"),
                            buildServiceItem(
                                "2. Phát hiện nhanh vấn đề sâu răng và cao răng"),
                            buildServiceItem("3. Nhổ răng hàm, cửa"),
                            buildServiceItem("3. Nhổ răng hàm, cửa"),
                            buildServiceItem("3. Nhổ răng hàm, cửa"),
                            buildServiceItem("3. Nhổ răng hàm, cửa"),
                            buildServiceItem("3. Nhổ răng hàm, cửa"),
                            buildServiceItem("3. Nhổ răng hàm, cửa"),
                            buildServiceItem("3. Nhổ răng hàm, cửa"),
                            buildServiceItem("3. Nhổ răng hàm, cửa"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Nút đặt lịch
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            // Hành động khi nhấn nút
                            print("Đặt lịch ngay");
                          },
                          child: Text(
                            "Đặt Lịch Ngay",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // widget thông tin về chất lượng bác sĩ
  Widget buildInfoBox(String value, String label) {
    
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

// widget danh sách dịch vụ
  Widget buildServiceItem(String service) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.circle, size: 8, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              service,
              style: GoogleFonts.roboto(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
