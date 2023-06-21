// To parse this JSON data, do
//
//     final userLoginResponseModel = userLoginResponseModelFromJson(jsonString);

import 'dart:convert';

UserLoginResponseModel userLoginResponseModelFromJson(String str) =>
    UserLoginResponseModel.fromJson(json.decode(str));

String userLoginResponseModelToJson(UserLoginResponseModel data) =>
    json.encode(data.toJson());

class UserLoginResponseModel {
  UserLoginResponseModel({
    this.id,
    this.countryCode,
    this.name,
    this.email,
    this.phoneNum,
    this.token,
    this.realName,
    this.countryId,
    this.avatarUrl,
  });

  String? id;
  int? countryCode;
  String? name;
  String? email;
  String? phoneNum;
  String? token;
  String? realName;
  int? countryId;
  String? avatarUrl;

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseModel(
        id: json["id"],
        countryCode: json["countryCode"],
        name: json["name"],
        email: json["email"],
        phoneNum: json["phoneNum"],
        token: json["token"],
        realName: json["realName"],
        countryId: json["countryId"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "countryCode": countryCode,
        "name": name,
        "email": email,
        "phoneNum": phoneNum,
        "token": token,
        "realName": realName,
        "countryId": countryId,
        'avatarUrl': avatarUrl,
      };
}
