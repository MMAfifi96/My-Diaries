import 'dart:convert';

class UserModel {
  // String? user_name;
  // String? userId;
  String? email;
  String? password;

  UserModel(
    // this.user_name,
    this.email,
    // this.userId,
    this.password,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      // 'user_name': user_name,
      // 'userId': userId,
      'email': email,
      'password': password,
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    // user_name = map['user_name'];
    // userId = map['userId'];
    email = map['email'];
    password = map['password'];
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  static String generateUserId() {
    var random = DateTime.now().microsecondsSinceEpoch.toString();
    return random;
  }
}
