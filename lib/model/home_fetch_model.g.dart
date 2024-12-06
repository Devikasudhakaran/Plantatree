// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeFetchModel _$HomeFetchModelFromJson(Map<String, dynamic> json) =>
    HomeFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      dataList: (json['dataList'] as List<dynamic>)
          .map((e) => DataList.fromJson(e as Map<String, dynamic>))
          .toList(),
      banner: (json['banner'] as List<dynamic>)
          .map((e) => HomeBanner.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeFetchModelToJson(HomeFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'dataList': instance.dataList,
      'banner': instance.banner,
    };

HomeBanner _$HomeBannerFromJson(Map<String, dynamic> json) => HomeBanner(
      id: json['id'] as String,
      image: json['image'] as String,
      position: json['position'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$HomeBannerToJson(HomeBanner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'position': instance.position,
      'created_at': instance.createdAt.toIso8601String(),
    };

DataList _$DataListFromJson(Map<String, dynamic> json) => DataList(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      paymentStatus: json['payment_status'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$DataListToJson(DataList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'payment_status': instance.paymentStatus,
      'image': instance.image,
    };
