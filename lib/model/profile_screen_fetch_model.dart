// To parse this JSON data, do
//
//     final profileScreenFetchModel = profileScreenFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profile_screen_fetch_model.g.dart';

ProfileScreenFetchModel profileScreenFetchModelFromJson(String str) =>
    ProfileScreenFetchModel.fromJson(json.decode(str));

String profileScreenFetchModelToJson(ProfileScreenFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProfileScreenFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "output")
  Output output;

  ProfileScreenFetchModel({
    required this.status,
    required this.message,
    required this.output,
  });

  factory ProfileScreenFetchModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileScreenFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileScreenFetchModelToJson(this);
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
