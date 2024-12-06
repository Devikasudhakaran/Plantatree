// To parse this JSON data, do
//
//     final projectScreenDeleteModel = projectScreenDeleteModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'all_project_screen_delete_model.g.dart';

ProjectScreenDeleteModel projectScreenDeleteModelFromJson(String str) =>
    ProjectScreenDeleteModel.fromJson(json.decode(str));

String projectScreenDeleteModelToJson(ProjectScreenDeleteModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProjectScreenDeleteModel {
  @JsonKey(name: "id")
  String id;

  ProjectScreenDeleteModel({
    required this.id,
  });

  factory ProjectScreenDeleteModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectScreenDeleteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectScreenDeleteModelToJson(this);
}
