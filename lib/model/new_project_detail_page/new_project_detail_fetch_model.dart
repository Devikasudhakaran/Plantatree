// To parse this JSON data, do
//
//     final newProjectDetailFetchModel = newProjectDetailFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'new_project_detail_fetch_model.g.dart';

NewProjectDetailFetchModel newProjectDetailFetchModelFromJson(String str) =>
    NewProjectDetailFetchModel.fromJson(json.decode(str));

String newProjectDetailFetchModelToJson(NewProjectDetailFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class NewProjectDetailFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "dataList")
  DataList dataList;

  NewProjectDetailFetchModel({
    required this.status,
    required this.message,
    required this.dataList,
  });

  factory NewProjectDetailFetchModel.fromJson(Map<String, dynamic> json) =>
      _$NewProjectDetailFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewProjectDetailFetchModelToJson(this);
}

@JsonSerializable()
class DataList {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "tree_name")
  String treeName;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "latitude")
  String latitude;
  @JsonKey(name: "longitude")
  String longitude;
  @JsonKey(name: "temperture")
  String temperture;
  @JsonKey(name: "soil")
  String soil;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "payment_status")
  String paymentStatus;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "phase1_description")
  List<dynamic> phase1Description;
  @JsonKey(name: "project_images")
  List<ProjectImage> projectImages;
  @JsonKey(name: "project_phase1_images")
  List<ProjectImage> projectPhase1Images;

  DataList({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.treeName,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.temperture,
    required this.soil,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
    required this.phase1Description,
    required this.projectImages,
    required this.projectPhase1Images,
  });

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);

  Map<String, dynamic> toJson() => _$DataListToJson(this);
}

@JsonSerializable()
class ProjectImage {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "image")
  String image;

  ProjectImage({
    required this.id,
    required this.image,
  });

  factory ProjectImage.fromJson(Map<String, dynamic> json) =>
      _$ProjectImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectImageToJson(this);
}
