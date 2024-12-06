// To parse this JSON data, do
//
//     final bankDetailFetchModel = bankDetailFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'bank_detail_fetch_model.g.dart';

BankDetailFetchModel bankDetailFetchModelFromJson(String str) =>
    BankDetailFetchModel.fromJson(json.decode(str));

String bankDetailFetchModelToJson(BankDetailFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class BankDetailFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "dataList")
  List<DataList> dataList;

  BankDetailFetchModel({
    required this.status,
    required this.message,
    required this.dataList,
  });

  factory BankDetailFetchModel.fromJson(Map<String, dynamic> json) =>
      _$BankDetailFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailFetchModelToJson(this);
}

@JsonSerializable()
class DataList {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "user_id")
  String userId;
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
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "created_date")
  DateTime createdDate;

  DataList({
    required this.id,
    required this.userId,
    required this.accountName,
    required this.accountNo,
    required this.ifsc,
    required this.bankName,
    required this.branch,
    required this.status,
    required this.createdDate,
  });

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);

  Map<String, dynamic> toJson() => _$DataListToJson(this);
}
