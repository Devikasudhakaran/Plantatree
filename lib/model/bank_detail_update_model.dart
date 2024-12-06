// To parse this JSON data, do
//
//     final bankDetailUpdateModel = bankDetailUpdateModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'bank_detail_update_model.g.dart';

BankDetailUpdateModel bankDetailUpdateModelFromJson(String str) =>
    BankDetailUpdateModel.fromJson(json.decode(str));

String bankDetailUpdateModelToJson(BankDetailUpdateModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class BankDetailUpdateModel {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "account_name")
  String accountName;
  @JsonKey(name: "account_no")
  String accountNo;
  @JsonKey(name: "ifsc")
  String ifsc;
  @JsonKey(name: "bank_name")
  String bankName;
  @JsonKey(name: "branch")
  String branch;

  BankDetailUpdateModel({
    required this.id,
    required this.accountName,
    required this.accountNo,
    required this.ifsc,
    required this.bankName,
    required this.branch,
  });

  factory BankDetailUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$BankDetailUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailUpdateModelToJson(this);
}
