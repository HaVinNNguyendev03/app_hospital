import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_hospital/utils/authbase.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_hospital/model/User.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class AuthService implements Authbase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
   final String twilioSid = dotenv.env['TWILIO_SID']!;
  final String twilioAuthToken = dotenv.env['TWILIO_AUTH_TOKEN']!;
  final String twilioPhoneNumber = dotenv.env['TWILIO_PHONE_NUMBER']!;

  String formatPhoneNumber(String phone) {
    if (phone.startsWith('0')) {
      // Thay đầu số 0 bằng mã quốc gia Việt Nam (+84)
      return "+84${phone.substring(1)}";
    }
    if (!phone.startsWith('+')) {
      // Nếu không có dấu +, thêm vào
      return "+$phone";
    }
    return phone;
  }

  @override

  /// Đăng ký bằng Google.
  //
  /// Hiển thị SnackBar thành công hay thất bại.
  ///
  /// Returns a string error if the sign up process fails.
  ///
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

  /// Đăng nhập bằng Google.
  ///
  /// Phương thức này cho phép người dùng đăng nhập vào ứng dụng bằng tài khoản Google của họ.
  ///
  /// [context] là BuildContext hiện tại, được sử dụng để điều hướng và hiển thị thông báo.
  ///
  /// Trả về một thông báo thành công nếu đăng nhập thành công, ngược lại trả về một thông báo lỗi
  /// nếu có lỗi xảy ra hoặc người dùng hủy quá trình đăng nhập.
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

    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Lưu các dữ liệu bổ sung vào Firestore với UID là document ID
      User? firebaseUser = userCredential.user;
      String createotp = (Random().nextInt(900000) + 100000).toString();
      DateTime expiryTime = DateTime.now().add(Duration(minutes: 5));
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
          otp: createotp,
          otpExpiry: expiryTime.millisecondsSinceEpoch,
        );
        await _firestore
            .collection('Users')
            .doc(firebaseUser.uid)
            .set(dataUser.toMap());
        // Xac Thuc Otp
        await sendOtpEmail(email, createotp);
        print("Xác thức OTP 1");
        await Navigator.pushNamed(context, '/verifyOtp', arguments: {
          'uid': firebaseUser.uid,
          'email': email,
          'name': name,
          'phoneNumber': null,
        });
        print("Xác thức OTP 2");
      }
      print("Xác thức OTP 3");
      return "Đăng ký thành công!";
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        // thông báo email đã tồn tại
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email đã được sử dụng"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override

  /// Đăng nhập bằng email.
  ///
  /// [email] là địa chỉ email của người dùng.
  /// [password] là mật khẩu của người dùng.
  ///
  /// Trả về một thông báo thành công nếu đăng nhập thành công, ngược lại trả về
  /// một thông báo lỗi nếu có lỗi xảy ra.
  ///
  /// Ngoài ra, còn trả về một thông báo nếu người dùng chưa xác minh email.
  Future<String?> loginWithEmail(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // Tìm người dùng trong Firestore bằng email
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .limit(1) // Chỉ cần lấy một kết quả
          .get();

      if (userSnapshot.docs.isEmpty) {
        return "Không tìm thấy người dùng với email này.";
      }

      // Lấy tài liệu người dùng từ snapshot
      DocumentSnapshot userDoc = userSnapshot.docs.first;

      // Kiểm tra xem người dùng có xác minh email chưa
      bool isEmailVerified = userDoc.get('isEmailVerified') ?? false;

      if (!isEmailVerified) {
        return "Email chưa được xác minh. Vui lòng xác minh email trước khi đăng nhập.";
      }
      Navigator.pushReplacementNamed(context, '/homepage', arguments: {
        'email': userDoc.get('email'),
        'name': userDoc.get('name'),
      });
      return "Đăng nhập Email thành công!";
    } catch (e) {
      return "Đăng nhập Email thất bại: $e";
    }
  }

  @override
  Future<String?> signUpWithPhone(
      BuildContext context, String phone, String password, String name) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // Định dạng số điện thoại
    //  String formattedPhone = formatPhoneNumber(phone);
    final Uri url = Uri.parse(
        'https://api.twilio.com/2010-04-01/Accounts/$twilioSid/Messages.json');

    // Tạo mã OTP ngẫu nhiên
    String otp = (100000 +
            (999999 - 100000) *
                (new DateTime.now().millisecondsSinceEpoch % 1000) ~/
                1000)
        .toString()
        .padLeft(6, '0');

    // Gửi OTP qua Twilio
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$twilioSid:$twilioAuthToken'))}',
        },
        body: {
          'From': twilioPhoneNumber,
          'To': phone,
          'Body': 'Your verification code is: $otp',
        },
      );

      if (response.statusCode == 201) {
        // Nếu gửi thành công, lưu người dùng vào Firestore
        await _saveUserToDatabase(phone, name, password, otp);

        // Chuyển hướng đến màn hình nhập OTP
        Navigator.pushNamed(context, '/verifyOtp', arguments: {
          'phone': phone,
          'otp': otp,
          'email': 'null',
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to send OTP")));
      }
    } catch (e) {
      print("Error sending OTP: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error sending OTP")));
    }
  }

  Future<void> _saveUserToDatabase(
      String phone, String password, String name, String otp) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Tạo thông tin người dùng
    UserModel dataUser = UserModel(
      uid: '', // sẽ để trống vì Firestore sẽ tự động tạo UID
      name: name,
      email: '', // Vì đây là đăng ký bằng số điện thoại
      phoneNumber: phone,
      password: password,
      location: '',
      image: '',
      role: 1,
      isEmailVerified: false,
      isPhoneVerified: true, // Đánh dấu là đã xác minh số điện thoại
      provider: 'phone',
      otp: null,
      otpExpiry: null,
    );

    try {
      // Tạo tài liệu mới và lấy UID tự động
      DocumentReference docRef =
          await _firestore.collection('Users').add(dataUser.toMap());

      // Lấy UID tự động tạo từ Firestore
      String uid = docRef.id;
      print("Người dùng đã được lưu vào Firestore với UID: $uid");
    } catch (e) {
      print("Lỗi khi lưu người dùng vào Firestore: $e");
    }
  }

  Future<bool> verifyPhoneOtp(String verificationId, String smsCode) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      // Tạo PhoneAuthCredential từ OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Xác thực người dùng
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        print("Xác thực thành công: ${userCredential.user!.phoneNumber}");
        return true;
      } else {
        print("Xác thực thất bại.");
        return false;
      }
    } catch (e) {
      print("Lỗi xác thực: $e");
      return false;
    }
  }

  @override
  Future<String?> loginWithPhone(
      BuildContext context, verificationId, String smsCode) async {
    // try {
    //   final credential = PhoneAuthProvider.credential(
    //     verificationId: verificationId,
    //     smsCode: smsCode,
    //   );
    //   await _firebaseAuth.signInWithCredential(credential);
    //   return "Đăng nhập bằng số điện thoại thành công!";
    // } catch (e) {
    //   return "Đăng nhập số điện thoại thất bại: $e";
    // }
  }

  @override

  /// Gửi mã OTP đến email của người dùng.
  ///
  /// [email] là địa chỉ email của người dùng.
  /// [otp] là mã OTP ngẫu nhiên được tạo ra.
  ///
  /// Trả về một thông báo thành công nếu gửi thành công, ngược lại trả về một
  /// thông báo lỗi nếu có lỗi xảy ra.
  Future<String?> sendOtpEmail(String email, String otp) async {
    String username = 'nguyenvanphucdev03@gmail.com';
    String password = 'ccicbyicrntqzulb';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'App Hospital')
      ..recipients.add(email)
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..html =
          "<h1>Mã OTP của bạn là: $otp</h1>\n<p>Hey! Here's some HTML content</p>";
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
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    UserModel user =
        UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);
    // Kiểm tra OTP và thời gian hết hạn
    if (user.otp == otpInput &&
        user.otpExpiry != null &&
        DateTime.fromMillisecondsSinceEpoch(user.otpExpiry!)
            .isAfter(DateTime.now())) {
      // Xóa OTP sau khi xác minh thành công
      await FirebaseFirestore.instance.collection('Users').doc(uid).update({
        'otp': null,
        'otpExpiry': null,
        'isEmailVerified': true, // Đánh dấu email đã được xác minh
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyOtpPhone(BuildContext context, String verificationId,
      String otp, String phone, String uid) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    // Kiểm tra các tham số không null hoặc rỗng
    if (verificationId.isEmpty || otp.isEmpty || phone.isEmpty || uid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thông tin không hợp lệ, vui lòng thử lại.")),
      );
      return false;
    }

    try {
      // Tạo thông tin xác thực từ OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Xác thực OTP
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Nếu xác thực thành công
      if (userCredential.user != null) {
        // Cập nhật thông tin trong Firestore
        await FirebaseFirestore.instance.collection('Users').doc(uid).update({
          'otp': null,
          'otpExpiry': null,
          'isPhoneVerified': true, // Đánh dấu đã xác minh số điện thoại
        });

        return true; // Thành công
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Không thể xác thực người dùng.")),
        );
        return false;
      }
    } catch (e) {
      print("Lỗi xác minh OTP: $e");

      // Xử lý lỗi FirebaseAuthException cụ thể
      if (e is FirebaseAuthException) {
        String errorMessage;
        switch (e.code) {
          case 'invalid-verification-code':
            errorMessage = "Mã OTP không hợp lệ. Vui lòng thử lại.";
            break;
          case 'session-expired':
            errorMessage = "Mã OTP đã hết hạn. Vui lòng gửi lại mã mới.";
            break;
          default:
            errorMessage = "Đã xảy ra lỗi: ${e.message}";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xác minh thất bại. Vui lòng thử lại.")),
        );
      }

      return false;
    }
  }
  Future<void> logout(BuildContext context) async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    try {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi đăng xuất: $e")),
      );
    } 
  }
}
