// To parse this JSON data, do
//
//     final forgottenPasswordModel = forgottenPasswordModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'forgotten_password_model.g.dart';

ForgottenPasswordModel forgottenPasswordModelFromJson(String str) =>
    ForgottenPasswordModel.fromJson(json.decode(str));

String forgottenPasswordModelToJson(ForgottenPasswordModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ForgottenPasswordModel {
  @JsonKey(name: "email")
  String email;

  ForgottenPasswordModel({
    required this.email,
  });

  factory ForgottenPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgottenPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgottenPasswordModelToJson(this);
}
