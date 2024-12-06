// To parse this JSON data, do
//
//     final feedbackQueryFetchModel = feedbackQueryFetchModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'feedback_query_fetch_model.g.dart';

FeedbackQueryFetchModel feedbackQueryFetchModelFromJson(String str) =>
    FeedbackQueryFetchModel.fromJson(json.decode(str));

String feedbackQueryFetchModelToJson(FeedbackQueryFetchModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class FeedbackQueryFetchModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "dataList")
  List<DataList> dataList;

  FeedbackQueryFetchModel({
    required this.status,
    required this.message,
    required this.dataList,
  });

  factory FeedbackQueryFetchModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackQueryFetchModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackQueryFetchModelToJson(this);
}

@JsonSerializable()
class DataList {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "subject")
  String subject;
  @JsonKey(name: "feedback_note")
  String feedbackNote;
  @JsonKey(name: "reply")
  String reply;
  @JsonKey(name: "created_at")
  DateTime createdAt;

  DataList({
    required this.id,
    required this.userId,
    required this.subject,
    required this.feedbackNote,
    required this.reply,
    required this.createdAt,
  });

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);

  Map<String, dynamic> toJson() => _$DataListToJson(this);
}
