import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'home_fetch_model.g.dart';

HomeFetchModel homeFetchModelFromJson(String str) =>
    HomeFetchModel.fromJson(json.decode(str));

String homeFetchModelToJson(HomeFetchModel data) => json.encode(data.toJson());

@JsonSerializable()
class HomeFetchModel {
  @JsonKey(name: "status")
  bool status;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "dataList")
  List<DataList> dataList;

  @JsonKey(name: "banner")
  List<HomeBanner> banner;

  HomeFetchModel({
    required this.status,
    required this.message,
    required this.dataList,
    required this.banner,
  });

  factory HomeFetchModel.fromJson(Map<String, dynamic> json) {
    return HomeFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      dataList: (json['dataList'] as List<dynamic>)
          .map((item) => DataList.fromJson(item as Map<String, dynamic>))
          .toList(),
      banner: (json['banner'] as List<dynamic>)
          .map((item) => HomeBanner.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$HomeFetchModelToJson(this);
}

@JsonSerializable()
class HomeBanner {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "image")
  String image;

  @JsonKey(name: "position")
  String position;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  HomeBanner({
    required this.id,
    required this.image,
    required this.position,
    required this.createdAt,
  });

  factory HomeBanner.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerToJson(this);
}

@JsonSerializable()
class DataList {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "status")
  String status;

  @JsonKey(name: "payment_status")
  String paymentStatus;

  @JsonKey(name: "image")
  String image;

  DataList({
    required this.id,
    required this.name,
    required this.status,
    required this.paymentStatus,
    required this.image,
  });

  factory DataList.fromJson(Map<String, dynamic> json) =>
      _$DataListFromJson(json);

  Map<String, dynamic> toJson() => _$DataListToJson(this);
}
