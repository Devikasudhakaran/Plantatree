// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_screen_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileScreenFetchModel _$ProfileScreenFetchModelFromJson(
        Map<String, dynamic> json) =>
    ProfileScreenFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      output: Output.fromJson(json['output'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileScreenFetchModelToJson(
        ProfileScreenFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'output': instance.output,
    };

Output _$OutputFromJson(Map<String, dynamic> json) => Output(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'image': instance.image,
    };
