// To parse this JSON data, do
//
//     final newProjectModel = newProjectModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'new_project_model.g.dart';

NewProjectModel newProjectModelFromJson(String str) =>
    NewProjectModel.fromJson(json.decode(str));

String newProjectModelToJson(NewProjectModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class NewProjectModel {
  @JsonKey(name: "name")
  String name;

  NewProjectModel({
    required this.name,
  });

  factory NewProjectModel.fromJson(Map<String, dynamic> json) =>
      _$NewProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewProjectModelToJson(this);
}
