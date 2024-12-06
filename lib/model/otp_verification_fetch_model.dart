// To parse this JSON data, do
//
//     final otpVerificationFetchModel = otpVerificationFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'otp_verification_fetch_model.g.dart';

OtpVerificationFetchModel otpVerificationFetchModelFromJson(String str) =>
    OtpVerificationFetchModel.fromJson(json.decode(str));

String otpVerificationFetchModelToJson(OtpVerificationFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class OtpVerificationFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "output")
  Output output;

  OtpVerificationFetchModel({
    required this.status,
    required this.message,
    required this.output,
  });

  factory OtpVerificationFetchModel.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerificationFetchModelToJson(this);
}

@JsonSerializable()
class Output {
  @JsonKey(name: "token")
  String token;

  Output({
    required this.token,
  });

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  Map<String, dynamic> toJson() => _$OutputToJson(this);
}
