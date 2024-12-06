// To parse this JSON data, do
//
//     final splashFetchModel = splashFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'splash_fetch_model.g.dart';

SplashFetchModel splashFetchModelFromJson(String str) =>
    SplashFetchModel.fromJson(json.decode(str));

String splashFetchModelToJson(SplashFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SplashFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "dataList")
  List<DataList> dataList;

  SplashFetchModel({
    required this.status,
    required this.message,
    required this.dataList,
  });

  factory SplashFetchModel.fromJson(Map<String, dynamic> json) =>
      _$SplashFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SplashFetchModelToJson(this);
}

@JsonSerializable()
class DataList {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "payment_status")
  String paymentStatus;
  @JsonKey(name: "image")
  String image;

  DataList({
    required this.id,
    required this.name,
    required this.status,
    required this.paymentStatus,
    required this.image,
  });

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);

  Map<String, dynamic> toJson() => _$DataListToJson(this);
}
