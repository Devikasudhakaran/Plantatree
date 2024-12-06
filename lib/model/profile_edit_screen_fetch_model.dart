// To parse this JSON data, do
//
//     final profileEditScreenFetchModel = profileEditScreenFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profile_edit_screen_fetch_model.g.dart';

ProfileEditScreenFetchModel profileEditScreenFetchModelFromJson(String str) =>
    ProfileEditScreenFetchModel.fromJson(json.decode(str));

String profileEditScreenFetchModelToJson(ProfileEditScreenFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProfileEditScreenFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "output")
  Output output;

  ProfileEditScreenFetchModel({
    required this.status,
    required this.message,
    required this.output,
  });

  factory ProfileEditScreenFetchModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileEditScreenFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEditScreenFetchModelToJson(this);
}

@JsonSerializable()
class Output {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "mobile")
  String mobile;
  @JsonKey(name: "image")
  String image;

  Output({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.image,
  });

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  Map<String, dynamic> toJson() => _$OutputToJson(this);
}
