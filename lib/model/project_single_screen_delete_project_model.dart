// To parse this JSON data, do
//
//     final projectSingleScreenDeleteProjectModel = projectSingleScreenDeleteProjectModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'project_single_screen_delete_project_model.g.dart';

ProjectSingleScreenDeleteProjectModel projectSingleScreenDeleteProjectModelFromJson(String str) => ProjectSingleScreenDeleteProjectModel.fromJson(json.decode(str));

String projectSingleScreenDeleteProjectModelToJson(ProjectSingleScreenDeleteProjectModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProjectSingleScreenDeleteProjectModel {
    @JsonKey(name: "id")
    String id;

    ProjectSingleScreenDeleteProjectModel({
        required this.id,
    });

    factory ProjectSingleScreenDeleteProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectSingleScreenDeleteProjectModelFromJson(json);

    Map<String, dynamic> toJson() => _$ProjectSingleScreenDeleteProjectModelToJson(this);
}
