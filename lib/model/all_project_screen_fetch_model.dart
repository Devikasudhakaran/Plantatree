// To parse this JSON data, do
//
//     final projectScreenFetchModel = projectScreenFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'all_project_screen_fetch_model.g.dart';

ProjectScreenFetchModel projectScreenFetchModelFromJson(String str) =>
    ProjectScreenFetchModel.fromJson(json.decode(str));

String projectScreenFetchModelToJson(ProjectScreenFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProjectScreenFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "dataList")
  List<DataList> dataList;

  ProjectScreenFetchModel({
    required this.status,
    required this.message,
    required this.dataList,
  });

  factory ProjectScreenFetchModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectScreenFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectScreenFetchModelToJson(this);
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
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "temperture")
  String temperture;
  @JsonKey(name: "image")
  String image;

  DataList({
    required this.id,
    required this.name,
    required this.status,
    required this.paymentStatus,
    required this.description,
    required this.temperture,
    required this.image,
  });

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);

  Map<String, dynamic> toJson() => _$DataListToJson(this);
}
