// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      output: Output.fromJson(json['output'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'output': instance.output,
    };

Output _$OutputFromJson(Map<String, dynamic> json) => Output(
      token: json['token'] as String,
      userId: json['user_id'] as String,
      status: json['status'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
    );

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
      'token': instance.token,
      'user_id': instance.userId,
      'status': instance.status,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
    };
