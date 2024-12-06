// To parse this JSON data, do
//
//     final profileEditScreenUpdate = profileEditScreenUpdateFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profile_edit_screen_update.g.dart';

ProfileEditScreenUpdate profileEditScreenUpdateFromJson(String str) =>
    ProfileEditScreenUpdate.fromJson(json.decode(str));

String profileEditScreenUpdateToJson(ProfileEditScreenUpdate data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProfileEditScreenUpdate {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "mobile")
  String mobile;

  ProfileEditScreenUpdate({
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory ProfileEditScreenUpdate.fromJson(Map<String, dynamic> json) =>
      _$ProfileEditScreenUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEditScreenUpdateToJson(this);
}
