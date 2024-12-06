// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewPasswordModel _$NewPasswordModelFromJson(Map<String, dynamic> json) =>
    NewPasswordModel(
      newPassword: json['new_password'] as String,
      confirmPassword: json['confirm_password'] as String,
    );

Map<String, dynamic> _$NewPasswordModelToJson(NewPasswordModel instance) =>
    <String, dynamic>{
      'new_password': instance.newPassword,
      'confirm_password': instance.confirmPassword,
    };
