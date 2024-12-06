// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_query_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackQueryFetchModel _$FeedbackQueryFetchModelFromJson(
        Map<String, dynamic> json) =>
    FeedbackQueryFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      dataList: (json['dataList'] as List<dynamic>)
          .map((e) => DataList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedbackQueryFetchModelToJson(
        FeedbackQueryFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'dataList': instance.dataList,
    };

DataList _$DataListFromJson(Map<String, dynamic> json) => DataList(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      subject: json['subject'] as String,
      feedbackNote: json['feedback_note'] as String,
      reply: json['reply'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$DataListToJson(DataList instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'subject': instance.subject,
      'feedback_note': instance.feedbackNote,
      'reply': instance.reply,
      'created_at': instance.createdAt.toIso8601String(),
    };
