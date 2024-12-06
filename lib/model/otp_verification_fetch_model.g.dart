// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerificationFetchModel _$OtpVerificationFetchModelFromJson(
        Map<String, dynamic> json) =>
    OtpVerificationFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      output: Output.fromJson(json['output'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OtpVerificationFetchModelToJson(
        OtpVerificationFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'output': instance.output,
    };

Output _$OutputFromJson(Map<String, dynamic> json) => Output(
      token: json['token'] as String,
    );

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
      'token': instance.token,
    };
