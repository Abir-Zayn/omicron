// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    String username;
    String password;
    String email;

    SignUpModel({
        required this.username,
        required this.password,
        required this.email,
    });

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        username: json["username"],
        password: json["password"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
    };
}
