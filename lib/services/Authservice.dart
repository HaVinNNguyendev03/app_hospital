import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_hospital/utils/authbase.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_hospital/model/User.dart';
import 'dart:math';

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

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo?.isNewUser == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng ký Google thành công!")),
        );
      } else {
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
      if (account == null) {
        return "Người dùng đã hủy quá trình đăng nhập Google.";
      }
      print("Đã chọn tài khoản Google: ${account.email}");
      //lấy token
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      print("lấy thành công token");
      // tạo authcredential từ token để sử dụng cho firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      print("Đăng nhập thành công với Firebase");
      Navigator.pushReplacementNamed(context, '/homepage', arguments: {
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName ?? "No Name",
      });
    } catch (e) {}
  }

  @override
  Future<String?> signUpWithEmail(
      BuildContext context, String email, String password, String name) async {
        //khởi tạo firebase
        final FirebaseFirestore _firestore = FirebaseFirestore.instance;
        // Tạo mã OTP ngẫu nhiên và thời gian hết hạn
  String otp = (Random().nextInt(900000) + 100000).toString();
  DateTime expiryTime = DateTime.now().add(Duration(minutes: 5));
    try {
        UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    
    // Lưu các dữ liệu bổ sung vào Firestore với UID là document ID
    User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      UserModel dataUser = UserModel(
        uid: firebaseUser.uid,
        name: name,
        email: email,
        phoneNumber: '',
        password: password,
        location: '',
        image: '',
        role: 1,
        isEmailVerified: false,
        isPhoneVerified: false,
        provider: '',
        otp: otp, 
        otpExpiry: expiryTime.millisecondsSinceEpoch,
      );
      await _firestore.collection('Users').doc(firebaseUser.uid).set(dataUser.toMap());
      print("Xác thức OTP");
      // Xac Thuc Otp
    await sendOtpEmail(email, otp);
    print("Xác thức OTP 1");
    await verifyOtp(firebaseUser.uid, otp);
    print("Xác thức OTP 2");
    }
    
      Navigator.pushReplacementNamed(context, '/login', arguments: {
        // pass data ...
      });
      return "Đăng ký thành công!";
    } catch (e) {
      return "Đăng ký thất bại: $e";
    }
  }

  @override
  Future<String?> loginWithEmail(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
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
  Future<String?> signUpWithPhone(
      String phoneNumber, Function(String) codeSent) async {
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
  Future<String?> loginWithPhone(
      BuildContext context, verificationId, String smsCode) async {
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

  @override
  Future<String?> sendOtpEmail(String email, String otp) async {
    String username = 'cgpt87043@gmail.com';
    String password = 'havinnguyen2003';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'App Hospital')
      ..recipients.add(email)
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'Ma OTP : $otp'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
  Future<bool> verifyOtp(String uid, String otpInput) async {
  // Lấy thông tin người dùng từ cơ sở dữ liệu
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      UserModel user = UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);

  // Kiểm tra OTP và thời gian hết hạn
  if (user.otp == otpInput && user.otpExpiry != null && DateTime.fromMillisecondsSinceEpoch(user.otpExpiry!).isAfter(DateTime.now())) {
    // Xóa OTP sau khi xác minh thành công
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'otp': null,
      'otpExpiry': null,
      'isEmailVerified': true, // Đánh dấu email đã được xác minh
    });
    return true;
  } else {
    return false;
  }
}
}
