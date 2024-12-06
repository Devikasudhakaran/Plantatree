import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';


part 'login_model.g.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

@JsonSerializable()
class LoginModel {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "password")
  String password;

  LoginModel({
    required this.name,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
