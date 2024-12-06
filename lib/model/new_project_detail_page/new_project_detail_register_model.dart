// To parse this JSON data, do
//
//     final newProjectDetailRegisterModel = newProjectDetailRegisterModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'new_project_detail_register_model.g.dart';

NewProjectDetailRegisterModel newProjectDetailRegisterModelFromJson(
        String str) =>
    NewProjectDetailRegisterModel.fromJson(json.decode(str));

String newProjectDetailRegisterModelToJson(
        NewProjectDetailRegisterModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class NewProjectDetailRegisterModel {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "tree_name")
  String treeName;
  @JsonKey(name: "longitude")
  String longitude;
  @JsonKey(name: "latitude")
  String latitude;
  @JsonKey(name: "temperture")
  String temperture;
  @JsonKey(name: "soil")
  String soil;

  NewProjectDetailRegisterModel({
    required this.id,
    required this.description,
    required this.treeName,
    required this.longitude,
    required this.latitude,
    required this.temperture,
    required this.soil,
  });

  factory NewProjectDetailRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$NewProjectDetailRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewProjectDetailRegisterModelToJson(this);
}
