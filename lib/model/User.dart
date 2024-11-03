class User {
  String uid;
  String name;
  String email;
  String password;
  String location;
  String image;
  int role;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.location,
    required this.image,
    this.role = 1, // Mặc định là 1
  });
   Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'location': location,
      'image': image,
      'role': role,
    };
  }
}