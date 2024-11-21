// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Đăng ký người dùng mới
//   Future<User?> registerUser(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user; // Trả về UserCredential
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//   // Bổ sung thông tin người dùng
//   Future<bool> addUserInfo(String uid, String name, String location, String image, String phone) async {
//     try {
//       User newUser = User(
//         name: name,
//         email: _auth.currentUser?.email ?? '',
//         location: location,
//         image: image,
//         phone: phone,
//       );

//       await _firestore.collection('users').doc(uid).set(newUser.toMap());
//       return true;
//     } catch (e) {
//       print(e.toString());
//       return false;
//     }
//   }

//   // Xóa người dùng
//   Future<bool> deleteUser() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         // Xóa tài khoản từ Firebase
//         await user.delete();
        
//         // Xóa thông tin từ Firestore
//         await _firestore.collection('users').doc(user.uid).delete();
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print(e.toString());
//       return false;
//     }
//   }
// }
