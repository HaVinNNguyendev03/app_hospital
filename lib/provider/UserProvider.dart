import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String? _email;
  String? _name;
  int? _role;
  String? get email => _email;
  String? get name => _name;
   int? get role => _role;
  void setUser(String? email, String? name, int? role) {
    _email = email;
    _name = name;
    _role = role;
    notifyListeners(); // Cập nhật trạng thái
  }
}
