// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_screen_change_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileEditScreenChangePasswordModel
    _$ProfileEditScreenChangePasswordModelFromJson(Map<String, dynamic> json) =>
        ProfileEditScreenChangePasswordModel(
          oldPassword: json['old_password'] as String,
          newPassword: json['new_password'] as String,
          confirmPassword: json['confirm_password'] as String,
        );

Map<String, dynamic> _$ProfileEditScreenChangePasswordModelToJson(
        ProfileEditScreenChangePasswordModel instance) =>
    <String, dynamic>{
      'old_password': instance.oldPassword,
      'new_password': instance.newPassword,
      'confirm_password': instance.confirmPassword,
    };
