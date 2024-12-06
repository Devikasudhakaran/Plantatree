// To parse this JSON data, do
//
//     final newProjectFetchModel = newProjectFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'new_project_fetch_model.g.dart';

NewProjectFetchModel newProjectFetchModelFromJson(String str) =>
    NewProjectFetchModel.fromJson(json.decode(str));

String newProjectFetchModelToJson(NewProjectFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class NewProjectFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "output")
  int output;

  NewProjectFetchModel({
    required this.status,
    required this.message,
    required this.output,
  });

  factory NewProjectFetchModel.fromJson(Map<String, dynamic> json) =>
      _$NewProjectFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewProjectFetchModelToJson(this);
}
