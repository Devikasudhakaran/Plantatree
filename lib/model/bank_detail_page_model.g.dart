// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_detail_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetailPageModel _$BankDetailPageModelFromJson(Map<String, dynamic> json) =>
    BankDetailPageModel(
      accountName: json['account_name'] as String,
      accountNo: json['account_no'] as String,
      ifsc: json['ifsc'] as String,
      bankName: json['bank_name'] as String,
      branch: json['branch'] as String,
    );

Map<String, dynamic> _$BankDetailPageModelToJson(
        BankDetailPageModel instance) =>
    <String, dynamic>{
      'account_name': instance.accountName,
      'account_no': instance.accountNo,
      'ifsc': instance.ifsc,
      'bank_name': instance.bankName,
      'branch': instance.branch,
    };
