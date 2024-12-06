// To parse this JSON data, do
//
//     final projectDeleteModel = projectDeleteModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'project_delete_model.g.dart';

ProjectDeleteModel projectDeleteModelFromJson(String str) =>
    ProjectDeleteModel.fromJson(json.decode(str));

String projectDeleteModelToJson(ProjectDeleteModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProjectDeleteModel {
  @JsonKey(name: "id")
  String id;

  ProjectDeleteModel({
    required this.id,
  });

  factory ProjectDeleteModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectDeleteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDeleteModelToJson(this);
}
