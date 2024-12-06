// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplashModel _$SplashModelFromJson(Map<String, dynamic> json) => SplashModel(
      deviceType: json['device_type'] as String,
      fcmToken: json['fcm_token'] as String,
    );

Map<String, dynamic> _$SplashModelToJson(SplashModel instance) =>
    <String, dynamic>{
      'device_type': instance.deviceType,
      'fcm_token': instance.fcmToken,
    };
