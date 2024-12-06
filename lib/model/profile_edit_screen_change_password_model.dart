// To parse this JSON data, do
//
//     final profileEditScreenChangePasswordModel = profileEditScreenChangePasswordModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profile_edit_screen_change_password_model.g.dart';

ProfileEditScreenChangePasswordModel
    profileEditScreenChangePasswordModelFromJson(String str) =>
        ProfileEditScreenChangePasswordModel.fromJson(json.decode(str));

String profileEditScreenChangePasswordModelToJson(
        ProfileEditScreenChangePasswordModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProfileEditScreenChangePasswordModel {
  @JsonKey(name: "old_password")
  String oldPassword;
  @JsonKey(name: "new_password")
  String newPassword;
  @JsonKey(name: "confirm_password")
  String confirmPassword;

  ProfileEditScreenChangePasswordModel({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory ProfileEditScreenChangePasswordModel.fromJson(
          Map<String, dynamic> json) =>
      _$ProfileEditScreenChangePasswordModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProfileEditScreenChangePasswordModelToJson(this);
}
