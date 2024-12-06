// To parse this JSON data, do
//
//     final otpVerificationModel = otpVerificationModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'otp_verification_model.g.dart';

OtpVerificationModel otpVerificationModelFromJson(String str) =>
    OtpVerificationModel.fromJson(json.decode(str));

String otpVerificationModelToJson(OtpVerificationModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class OtpVerificationModel {
  @JsonKey(name: "otp")
  String otp;

  OtpVerificationModel({
    required this.otp,
  });

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerificationModelToJson(this);
}
