import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_hospital/utils/authbase.dart';
import 'package:flutter/material.dart';
class AuthService implements Authbase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<String?> signUpWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return "Người dùng đã hủy quá trình đăng nhập Google.";
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

          
      if (userCredential.additionalUserInfo?.isNewUser == true) {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng ký Google thành công!")),
        );
      }else{
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("tai khoan da ton tai!")),
        );
      }
    } catch (e) {
      return "Đăng ký Google thất bại: $e";
    }
  }
  Future<String?> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if(account == null) {
        return "Người dùng đã hủy quá trình đăng nhập Google.";
      }
       print("Đã chọn tài khoản Google: ${account.email}");
       //lấy token 
        final GoogleSignInAuthentication googleAuth = await account.authentication;
        print("lấy thành công token");
        // tạo authcredential từ token để sử dụng cho firebase 
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        print("Đăng nhập thành công với Firebase");
        Navigator.pushReplacementNamed(context, '/homepage', arguments: {
          'email': userCredential.user?.email,
          'name': userCredential.user?.displayName ?? "No Name",
        });
    } catch (e) {}
  }
  @override
  Future<String?> signUpWithEmail(BuildContext context,String email, String password,String name) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
       Navigator.pushReplacementNamed(context, '/login', arguments: {
         
        });
      return "Đăng ký Email thành công!";
    } catch (e) {
      return "Đăng ký Email thất bại: $e";
    }
  }

  @override
  Future<String?> loginWithEmail(BuildContext context,String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
       Navigator.pushReplacementNamed(context, '/homepage', arguments: {
          'email': userCredential.user?.email,
          'name': userCredential.user?.displayName ?? "No Name",
        });
      return "Đăng nhập Email thành công!";
    } catch (e) {
      return "Đăng nhập Email thất bại: $e";
    }
  }

  @override
  Future<String?> signUpWithPhone(String phoneNumber, Function(String) codeSent) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception("Xác minh số điện thoại thất bại: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          codeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return "Mã xác minh đã được gửi!";
    } catch (e) {
      return "Đăng ký số điện thoại thất bại: $e";
    }
  }

  @override
  Future<String?> loginWithPhone(BuildContext context,verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return "Đăng nhập bằng số điện thoại thành công!";
    } catch (e) {
      return "Đăng nhập số điện thoại thất bại: $e";
    }
  }
}
