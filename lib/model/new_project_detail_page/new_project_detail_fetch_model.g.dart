// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_project_detail_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewProjectDetailFetchModel _$NewProjectDetailFetchModelFromJson(
        Map<String, dynamic> json) =>
    NewProjectDetailFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      dataList: DataList.fromJson(json['dataList'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewProjectDetailFetchModelToJson(
        NewProjectDetailFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'dataList': instance.dataList,
    };

DataList _$DataListFromJson(Map<String, dynamic> json) => DataList(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      treeName: json['tree_name'] as String,
      image: json['image'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      temperture: json['temperture'] as String,
      soil: json['soil'] as String,
      status: json['status'] as String,
      paymentStatus: json['payment_status'] as String,
      createdAt: json['created_at'] as String,
      phase1Description: json['phase1_description'] as List<dynamic>,
      projectImages: (json['project_images'] as List<dynamic>)
          .map((e) => ProjectImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectPhase1Images: (json['project_phase1_images'] as List<dynamic>)
          .map((e) => ProjectImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataListToJson(DataList instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'tree_name': instance.treeName,
      'image': instance.image,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'temperture': instance.temperture,
      'soil': instance.soil,
      'status': instance.status,
      'payment_status': instance.paymentStatus,
      'created_at': instance.createdAt,
      'phase1_description': instance.phase1Description,
      'project_images': instance.projectImages,
      'project_phase1_images': instance.projectPhase1Images,
    };

ProjectImage _$ProjectImageFromJson(Map<String, dynamic> json) => ProjectImage(
      id: json['id'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$ProjectImageToJson(ProjectImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
    };
