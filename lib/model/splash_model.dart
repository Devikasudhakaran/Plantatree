// To parse this JSON data, do
//
//     final splashModel = splashModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'splash_model.g.dart';

SplashModel splashModelFromJson(String str) =>
    SplashModel.fromJson(json.decode(str));

String splashModelToJson(SplashModel data) => json.encode(data.toJson());

@JsonSerializable()
class SplashModel {
  @JsonKey(name: "device_type")
  String deviceType;
  @JsonKey(name: "fcm_token")
  String fcmToken;

  SplashModel({
    required this.deviceType,
    required this.fcmToken,
  });

  factory SplashModel.fromJson(Map<String, dynamic> json) =>
      _$SplashModelFromJson(json);

  Map<String, dynamic> toJson() => _$SplashModelToJson(this);
}
