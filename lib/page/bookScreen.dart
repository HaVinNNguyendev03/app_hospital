import 'package:app_hospital/widget/ButtonwidgetIntro.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/theme.dart';
import 'package:app_hospital/services/Authservice.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@template bookScreen}
/// BookScreen widget.
/// {@endtemplate}
class BookScreen extends StatefulWidget {
  /// {@macro bookScreen}
  const BookScreen({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _BookScreenState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_BookScreenState>();

  @override
  State<BookScreen> createState() => _BookScreenState();
}

/// State for widget BookScreen.
class _BookScreenState extends State<BookScreen> {
  // fake data
  List<Map<String, dynamic>> _events = [
    {
      'id': 01,
      'day': '27',
      'fullday': '27/11/2024',
      'doctorname': 'Phương',
      'hospital': 'Phúc Hưng',
      'timebooking': '8:00 - 9:00',
    },
    {
      'id': 02,
      'day': '28',
      'fullday': '28/11/2024',
      'doctorname': 'Quang',
      'hospital': 'Phúc Hưng',
      'timebooking': '8:00 - 9:00',
    },
    {
      'id': 03,
      'day': '29',
      'fullday': '29/11/2024',
      'doctorname': 'Quang',
      'hospital': 'Phúc Hưng',
      'timebooking': '8:00 - 9:00',
    }
  ];
  void _showEditDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text('Xác nhận'),
        content: Text('Bạn có muốn thay đổi lịch khám không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: Text('Không'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
              Navigator.pushNamed(context, '/bookcalender'); // Điều hướng
            },
            child: Text('Có'),
          ),
        ],
      );
    },
  );
}

  // void _showEditDialog(int index) {
  //   final event = _events[index];
  //   final TextEditingController timeController =
  //       TextEditingController(text: event['timebooking']);
  //   final TextEditingController doctorController =
  //       TextEditingController(text: event['doctorname']);
  //   final TextEditingController hospitalController =
  //       TextEditingController(text: event['hospital']);

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         title: Text('Chỉnh sửa lịch'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: doctorController,
  //               decoration: InputDecoration(
  //                 labelText: 'Tên bác sĩ',
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             TextField(
  //               controller: hospitalController,
  //               decoration: InputDecoration(
  //                 labelText: 'Tên bệnh viện',
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             TextField(
  //               controller: timeController,
  //               decoration: InputDecoration(
  //                 labelText: 'Giờ đặt lịch',
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Đóng dialog
  //             },
  //             child: Text('Hủy'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               // Cập nhật thông tin mới
  //               setState(() {
  //                 _events[index]['doctorname'] = doctorController.text;
  //                 _events[index]['hospital'] = hospitalController.text;
  //                 _events[index]['timebooking'] = timeController.text;
  //               });
  //               Navigator.of(context).pop(); // Đóng dialog
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(content: Text('Lịch khám đã được cập nhật')),
  //               );
  //             },
  //             child: Text('Lưu'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _showDeleteDialog(int index) {
     showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có chắc chắn muốn hủy đặt lịch này không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: Text('Không'),
          ),
          ElevatedButton(
            onPressed: () {
              // Thực hiện xóa lịch
              setState(() {
                _events.removeAt(index);
              });
              Navigator.of(context).pop(); // Đóng dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã hủy đặt lịch thành công')),
              );
            },
            child: Text('Có'),
          ),
        ],
      );
    },
  );
  }
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant BookScreen oldWidget) {
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

    return GestureDetector(
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppTheme.backgroundGradient,
          ),
          child: _events.isEmpty // Kiểm tra danh sách có rỗng không
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/image/booking.png',
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Đặt Lịch Khám Ngay",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "App Hospital cung cấp diện dụng đặt lịch khám ngay trên mạng. Với nhiều bác sĩ kinh nghiệm đến từ nhiều đơn vị trên địa bàn tỉnh",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Buttonwidget(
                      textbutton: "Đặt Ngay",
                      paddinghorizontal: screenWidth * 0.08,
                      paddingvertical: screenHeight * 0.02,
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.5,
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/intro2'),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Phần hình ngày
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                event['day'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Phần thông tin chi tiết
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bạn có lịch khám ${event['fullday']}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Bác sĩ ${event['doctorname']} tại bệnh viện ${event['hospital']}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Giờ đặt khám : ${event['timebooking']}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Nút 3 chấm (PopupMenuButton)
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'cancel') {
                                // Xử lý khi chọn "Hủy đặt lịch"
                                _showDeleteDialog(index);
                              } else if (value == 'edit') {
                                // Xử lý khi chọn "Chỉnh sửa lịch"
                                _showEditDialog();
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'cancel',
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel, color: Colors.red),
                                    SizedBox(width: 10),
                                    Text('Hủy đặt lịch'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.blue),
                                    SizedBox(width: 10),
                                    Text('Chỉnh sửa lịch'),
                                  ],
                                ),
                              ),
                            ],
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
