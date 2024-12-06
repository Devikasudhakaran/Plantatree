// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_query_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackQueryModel _$FeedbackQueryModelFromJson(Map<String, dynamic> json) =>
    FeedbackQueryModel(
      subject: json['subject'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$FeedbackQueryModelToJson(FeedbackQueryModel instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'description': instance.description,
    };
