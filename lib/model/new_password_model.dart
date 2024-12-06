// To parse this JSON data, do
//
//     final newPasswordModel = newPasswordModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'new_password_model.g.dart';

NewPasswordModel newPasswordModelFromJson(String str) =>
    NewPasswordModel.fromJson(json.decode(str));

String newPasswordModelToJson(NewPasswordModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class NewPasswordModel {
  @JsonKey(name: "new_password")
  String newPassword;
  @JsonKey(name: "confirm_password")
  String confirmPassword;

  NewPasswordModel({
    required this.newPassword,
    required this.confirmPassword,
  });

  factory NewPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewPasswordModelToJson(this);
}
