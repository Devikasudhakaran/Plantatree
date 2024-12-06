// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplashFetchModel _$SplashFetchModelFromJson(Map<String, dynamic> json) =>
    SplashFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      dataList: (json['dataList'] as List<dynamic>)
          .map((e) => DataList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SplashFetchModelToJson(SplashFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'dataList': instance.dataList,
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
