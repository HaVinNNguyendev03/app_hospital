import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  // Hàm để xử lý đăng ký bằng Google với các lệnh print để debug
  Future<void> _signUpWithGoogle(BuildContext context) async {
    try {
      print("Bắt đầu quá trình đăng ký bằng Google");
      // Bắt đầu quá trình đăng nhập Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("Người dùng đã hủy quá trình đăng nhập Google.");
        return;
      }
      print("Đã chọn tài khoản Google: ${googleUser.email}");

      // Lấy token từ tài khoản Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print("Lấy thành công Google Authentication Token");

      // Tạo AuthCredential từ token để sử dụng cho Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("Đã tạo Firebase AuthCredential");

      // Đăng ký tài khoản mới với Firebase bằng Google
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      print("Đã đăng ký hoặc đăng nhập thành công với Firebase");

      // Kiểm tra nếu tài khoản là tài khoản mới tạo
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        print("Đăng ký Google thành công! Tài khoản mới đã được tạo.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng ký Google thành công!")),
        );
      } else {
        print("Tài khoản Google đã tồn tại, thực hiện đăng nhập thay vì đăng ký.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tài khoản Google đã tồn tại, chuyển sang đăng nhập.")),
        );
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Lỗi trong quá trình đăng ký Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng ký Google thất bại: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
      ),
      onPressed: () {
        _signUpWithGoogle(context); 
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/image/icongoogle.png', 
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 10),
          Text(
            "Google",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
