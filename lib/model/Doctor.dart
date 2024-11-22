class DoctorModel {
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
  String? specialization; // Chuyên khoa
  int? experience; // Số năm kinh nghiệm
  List<String>? certifications; // Danh sách chứng chỉ
  String? hospital; // Bệnh viện/Phòng khám
  List<String>? availableHours; // Giờ làm việc
  String? bio; // Giới thiệu ngắn
  String? otp; // Mã OTP
  int? otpExpiry; // Thời gian hết hạn OTP

  DoctorModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.location,
    this.image,
    this.role = 2, // Mặc định là vai trò bác sĩ
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.provider,
    this.specialization,
    this.experience,
    this.certifications,
    this.hospital,
    this.availableHours,
    this.bio,
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
      'specialization': specialization,
      'experience': experience,
      'certifications': certifications,
      'hospital': hospital,
      'availableHours': availableHours,
      'bio': bio,
      'otp': otp,
      'otpExpiry': otpExpiry,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      location: map['location'],
      image: map['image'],
      role: map['role'] ?? 2,
      isEmailVerified: map['isEmailVerified'] ?? false,
      isPhoneVerified: map['isPhoneVerified'] ?? false,
      provider: map['provider'],
      specialization: map['specialization'],
      experience: map['experience'],
      certifications: List<String>.from(map['certifications'] ?? []),
      hospital: map['hospital'],
      availableHours: List<String>.from(map['availableHours'] ?? []),
      bio: map['bio'],
      otp: map['otp'],
      otpExpiry: map['otpExpiry'],
    );
  }
}
