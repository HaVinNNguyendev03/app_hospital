class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? location;
  String? image;
  int? role;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String? provider;
  String? otp; // Mã OTP cho xác thực đăng ký
  int? otpExpiry; // Thời gian hết hạn của OTP

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.location,
    this.image,
    this.role = 1,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.provider,
    this.otp,
    this.otpExpiry,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'location': location,
      'image': image,
      'role': role,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'provider': provider,
      'otp': otp,
      'otpExpiry': otpExpiry,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      location: map['location'],
      image: map['image'],
      role: map['role'] ?? 1,
      isEmailVerified: map['isEmailVerified'] ?? false,
      isPhoneVerified: map['isPhoneVerified'] ?? false,
      provider: map['provider'],
      otp: map['otp'],
      otpExpiry: map['otpExpiry'] 
    );
  }
  
}
