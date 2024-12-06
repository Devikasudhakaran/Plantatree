// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_detail_fetch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetailFetchModel _$BankDetailFetchModelFromJson(
        Map<String, dynamic> json) =>
    BankDetailFetchModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      dataList: (json['dataList'] as List<dynamic>)
          .map((e) => DataList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BankDetailFetchModelToJson(
        BankDetailFetchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'dataList': instance.dataList,
    };

DataList _$DataListFromJson(Map<String, dynamic> json) => DataList(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      accountName: json['account_name'] as String,
      accountNo: json['account_no'] as String,
      ifsc: json['ifsc'] as String,
      bankName: json['bank_name'] as String,
      branch: json['branch'] as String,
      status: json['status'] as String,
      createdDate: DateTime.parse(json['created_date'] as String),
    );

Map<String, dynamic> _$DataListToJson(DataList instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'account_name': instance.accountName,
      'account_no': instance.accountNo,
      'ifsc': instance.ifsc,
      'bank_name': instance.bankName,
      'branch': instance.branch,
      'status': instance.status,
      'created_date': instance.createdDate.toIso8601String(),
    };
