// To parse this JSON data, do
//
//     final feedbackQueryModel = feedbackQueryModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'feedback_query_model.g.dart';

FeedbackQueryModel feedbackQueryModelFromJson(String str) =>
    FeedbackQueryModel.fromJson(json.decode(str));

String feedbackQueryModelToJson(FeedbackQueryModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class FeedbackQueryModel {
  @JsonKey(name: "subject")
  String subject;
  @JsonKey(name: "description")
  String description;

  FeedbackQueryModel({
    required this.subject,
    required this.description,
  });

  factory FeedbackQueryModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackQueryModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackQueryModelToJson(this);
}
