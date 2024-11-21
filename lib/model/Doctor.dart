class Doctor {
  String id; // ID của bác sĩ
  String name; // Tên bác sĩ
  String specialty; // Chuyên khoa
  String phoneNumber; // Số điện thoại
  String email; // Địa chỉ email
  String hospitalId; // ID bệnh viện hoặc cơ sở khám chữa bệnh
 

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.phoneNumber,
    required this.email,
    required this.hospitalId,
   
  });

  // Phương thức để chuyển đổi từ JSON sang đối tượng Doctor
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      hospitalId: json['hospitalId'],
     
    );
  }

  // Phương thức để chuyển đổi từ đối tượng Doctor sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'phoneNumber': phoneNumber,
      'email': email,
      'hospitalId': hospitalId,
      
    };
  }
}
