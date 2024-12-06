// To parse this JSON data, do
//
//     final registerationScreenModel = registerationScreenModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'registeration_screen_model.g.dart';

RegisterationScreenModel registerationScreenModelFromJson(String str) =>
    RegisterationScreenModel.fromJson(json.decode(str));

String registerationScreenModelToJson(RegisterationScreenModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RegisterationScreenModel {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "mobile")
  String mobile;
  @JsonKey(name: "password")
  String password;

  RegisterationScreenModel({
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
  });

  factory RegisterationScreenModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterationScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterationScreenModelToJson(this);
}
