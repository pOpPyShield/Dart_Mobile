import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String username;
  String? firstname;
  String? lastname;
  String email;
  String? phonenumber;

  User({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phonenumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phonenumber: json["phonenumber"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phonenumber": phonenumber,
      };
}
