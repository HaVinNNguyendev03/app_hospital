import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/theme.dart';
import 'package:provider/provider.dart'; // Import provider để lấy UserProvider
import 'package:app_hospital/provider/UserProvider.dart'; // Import UserProvider

/// {@template userScreen}
/// UserScreen widget.
/// {@endtemplate}
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @internal
  static _UserScreenState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_UserScreenState>();

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); // Lấy UserProvider
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Kiểm tra role người dùng
    if (userProvider.role == 1) {
      // Hiển thị giao diện người dùng nếu role == 1
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Tiêu đề
                      Text(
                        "Cài Đặt Hồ Sơ Người Dùng",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa tiêu đề và mô tả
                      // Mô tả
                      Text(
                        "Cập Nhật Hồ Sơ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30), // Khoảng cách đến ảnh đại diện
                      // Ảnh đại diện
                      Stack(
                        alignment: Alignment
                            .bottomRight, // Căn biểu tượng camera ở góc phải
                        children: [
                          // Ảnh tròn
                          CircleAvatar(
                            radius: 60, // Kích thước của ảnh đại diện
                            backgroundImage: AssetImage(
                                'assets/image/avatabacsi2.png'), // Thay bằng đường dẫn ảnh của bạn
                          ),
                          // Biểu tượng chỉnh sửa
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                print("Edit profile image tapped");
                              },
                              child: CircleAvatar(
                                radius: 18, // Kích thước của nút camera
                                backgroundColor: Colors.grey[300],
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                buildEditableField(
                  context,
                  label: "Tên Tài Khoản",
                  initialValue: userProvider.name ?? "Người dùng",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Số điện thoại liên hệ",
                  initialValue: "1234567890",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Email liên hệ",
                  initialValue: userProvider.email ?? "example@gmail.com",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Email liên hệ",
                  initialValue: userProvider.email ?? "example@gmail.com",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Email liên hệ",
                  initialValue: userProvider.email ?? "example@gmail.com",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Email liên hệ",
                  initialValue: userProvider.email ?? "example@gmail.com",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Email liên hệ",
                  initialValue: userProvider.email ?? "example@gmail.com",
                  onEditTap: () {},
                ),
              ],
            ),
          ),
        ),
      );
    } else if (userProvider.role == 2) {
      // Hiển thị giao diện bác sĩ nếu role == 2
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Doctor Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/image/avatabacsi2.png'),
                ),
                SizedBox(height: 30),
                buildEditableField(
                  context,
                  label: "Tên Bác Sĩ",
                  initialValue: userProvider.name ?? "Bác Sĩ",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Chuyên Khoa",
                  initialValue: "Chuyên khoa X",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Số điện thoại liên hệ",
                  initialValue: "0987654321",
                  onEditTap: () {},
                ),
                buildEditableField(
                  context,
                  label: "Email liên hệ",
                  initialValue: userProvider.email ?? "doctor@example.com",
                  onEditTap: () {},
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Nếu role không phải 1 hay 2, bạn có thể hiển thị màn hình mặc định hoặc thông báo lỗi
      return Scaffold(
        body: Center(
          child: Text("Role không hợp lệ!"),
        ),
      );
    }
  }

  Widget buildEditableField(
    BuildContext context, {
    required String label,
    required String initialValue,
    required VoidCallback onEditTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 4),
              Text(
                initialValue,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onEditTap,
            child: Icon(
              Icons.edit,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
