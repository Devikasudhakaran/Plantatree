// To parse this JSON data, do
//
//     final forgottenPasswordFetchModel = forgottenPasswordFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'forgotten_password_fetch_model.g.dart';

ForgottenPasswordFetchModel forgottenPasswordFetchModelFromJson(String str) =>
    ForgottenPasswordFetchModel.fromJson(json.decode(str));

String forgottenPasswordFetchModelToJson(ForgottenPasswordFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ForgottenPasswordFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "output")
  int output;

  ForgottenPasswordFetchModel({
    required this.status,
    required this.message,
    required this.output,
  });

  factory ForgottenPasswordFetchModel.fromJson(Map<String, dynamic> json) =>
      _$ForgottenPasswordFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgottenPasswordFetchModelToJson(this);
}
