// To parse this JSON data, do
//
//     final bankDetailPageModel = bankDetailPageModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'bank_detail_page_model.g.dart';

BankDetailPageModel bankDetailPageModelFromJson(String str) =>
    BankDetailPageModel.fromJson(json.decode(str));

String bankDetailPageModelToJson(BankDetailPageModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class BankDetailPageModel {
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

  BankDetailPageModel({
    required this.accountName,
    required this.accountNo,
    required this.ifsc,
    required this.bankName,
    required this.branch,
  });

  factory BankDetailPageModel.fromJson(Map<String, dynamic> json) =>
      _$BankDetailPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailPageModelToJson(this);
}
