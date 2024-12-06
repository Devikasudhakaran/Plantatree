// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registeration_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterationScreenModel _$RegisterationScreenModelFromJson(
        Map<String, dynamic> json) =>
    RegisterationScreenModel(
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterationScreenModelToJson(
        RegisterationScreenModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'password': instance.password,
    };
