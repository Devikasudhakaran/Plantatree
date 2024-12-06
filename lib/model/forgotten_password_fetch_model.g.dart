// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgotten_password_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgottenPasswordFetchModel _$ForgottenPasswordFetchModelFromJson(
        Map<String, dynamic> json) =>
    ForgottenPasswordFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      output: (json['output'] as num).toInt(),
    );

Map<String, dynamic> _$ForgottenPasswordFetchModelToJson(
        ForgottenPasswordFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'output': instance.output,
    };
