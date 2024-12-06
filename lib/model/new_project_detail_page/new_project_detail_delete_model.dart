// To parse this JSON data, do
//
//     final newProjectDetailDeleteModel = newProjectDetailDeleteModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'new_project_detail_delete_model.g.dart';

NewProjectDetailDeleteModel newProjectDetailDeleteModelFromJson(String str) =>
    NewProjectDetailDeleteModel.fromJson(json.decode(str));

String newProjectDetailDeleteModelToJson(NewProjectDetailDeleteModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class NewProjectDetailDeleteModel {
  @JsonKey(name: "id")
  String id;

  NewProjectDetailDeleteModel({
    required this.id,
  });

  factory NewProjectDetailDeleteModel.fromJson(Map<String, dynamic> json) =>
      _$NewProjectDetailDeleteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewProjectDetailDeleteModelToJson(this);
}
