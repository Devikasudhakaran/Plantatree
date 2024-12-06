// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_project_detail_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewProjectDetailRegisterModel _$NewProjectDetailRegisterModelFromJson(
        Map<String, dynamic> json) =>
    NewProjectDetailRegisterModel(
      id: json['id'] as String,
      description: json['description'] as String,
      treeName: json['tree_name'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      temperture: json['temperture'] as String,
      soil: json['soil'] as String,
    );

Map<String, dynamic> _$NewProjectDetailRegisterModelToJson(
        NewProjectDetailRegisterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'tree_name': instance.treeName,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'temperture': instance.temperture,
      'soil': instance.soil,
    };
