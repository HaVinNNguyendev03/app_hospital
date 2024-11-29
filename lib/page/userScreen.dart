import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:app_hospital/theme.dart';

/// {@template userScreen}
/// UserScreen widget.
/// {@endtemplate}
class UserScreen extends StatefulWidget {
  /// {@macro userScreen}
  const UserScreen({
    super.key, // ignore: unused_element
  });
  
  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static _UserScreenState? maybeOf(BuildContext context) =>
    context.findAncestorStateOfType<_UserScreenState>();
  
  @override
  State<UserScreen> createState() => _UserScreenState();
}


/// State for widget UserScreen.
class _UserScreenState extends State<UserScreen> {

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }
  
  @override
  void didUpdateWidget(covariant UserScreen oldWidget) {
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
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient, // Áp dụng gradient từ AppTheme  
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tiêu đề
              Text(
                "Set up your profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),  
              ),
              SizedBox(height: 8), // Khoảng cách giữa tiêu đề và mô tả
              // Mô tả
              Text(
                "Update your profile to connect your doctor with better impression.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 30), // Khoảng cách đến ảnh đại diện
              // Ảnh đại diện
              Stack(
                alignment: Alignment.bottomRight, // Căn biểu tượng camera ở góc phải
                children: [
                  // Ảnh tròn
                  CircleAvatar(
                    radius: 60, // Kích thước của ảnh đại diện
                    backgroundImage: AssetImage('assets/image/avatabacsi2.png'), // Thay bằng đường dẫn ảnh của bạn
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
              SizedBox(height: 16),
               // Name Field
              buildEditableField(
                context,
                label: "Tên Tài Khoản",
                initialValue: "Nguyen Van Phuc",
                onEditTap: () {
                  print("Sửa Tên");
                },
              ),
               SizedBox(height: 16),
              // Contact Number Field
              buildEditableField(
                context,
                label: "Số điện thoại liên hệ",
                initialValue: "+8801800000000",
                onEditTap: () {
                  print("Sửa Số Điện Thoại");
                },
              ),
              
              SizedBox(height: 16),
              //  Email Field
              buildEditableField(
                context,
                label: "Emmail liên hệ",
                initialValue: "Nguyenvanphucdev03@gmail.com",
                onEditTap: () {
                  print("Sửa Email liên hệ");
                },
              ),
              SizedBox(height: 16),
              // Date of Birth Field
              buildEditableField(
                context,
                label: "Ngày Sinh",
                initialValue: "DD MM YYYY",
                onEditTap: () {
                  print("Sửa Ngày Sinh");
                },
              ),
              SizedBox(height: 16),
              // Location Field
              buildEditableField(
                context,
                label: "Điạ chỉ",
                initialValue: "Add Details",
                onEditTap: () {
                  print("Sửa địa chỉ");
                },
              ),
              SizedBox(height: 16),
              // Contact Number Field
              buildEditableField(
                context,
                label: "Vai Trò",
                initialValue: "Khách Hàng",
                onEditTap: () {
                  print("Edit Contact Number");
                },
              ),
            ]
          ),
        ),
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
          // Label and Value
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
          // Edit Icon
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
