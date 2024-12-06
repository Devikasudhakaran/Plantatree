import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:plantatree/model/new_project_detail_page/new_project_detail_fetch_model.dart';
part 'project_single_screen_fetch_model.g.dart';

ProjectSingleScreenFetchModel projectSingleScreenFetchModelFromJson(
        String str) =>
    ProjectSingleScreenFetchModel.fromJson(json.decode(str));

String projectSingleScreenFetchModelToJson(
        ProjectSingleScreenFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProjectSingleScreenFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "dataList")
  DataList dataList;

  ProjectSingleScreenFetchModel({
    required this.status,
    required this.message,
    required this.dataList,
  });

  factory ProjectSingleScreenFetchModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectSingleScreenFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectSingleScreenFetchModelToJson(this);
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
  String createdAt; // Keep this as a String if you want to parse it manually
  @JsonKey(name: "phase1_description")
  List<dynamic> phase1Description; // Adjusted to List<dynamic>
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
