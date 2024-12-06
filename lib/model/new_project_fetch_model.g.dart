// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_project_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewProjectFetchModel _$NewProjectFetchModelFromJson(
        Map<String, dynamic> json) =>
    NewProjectFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      output: (json['output'] as num).toInt(),
    );

Map<String, dynamic> _$NewProjectFetchModelToJson(
        NewProjectFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'output': instance.output,
    };
