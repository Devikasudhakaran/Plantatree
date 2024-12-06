// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_detail_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetailUpdateModel _$BankDetailUpdateModelFromJson(
        Map<String, dynamic> json) =>
    BankDetailUpdateModel(
      id: json['id'] as String,
      accountName: json['account_name'] as String,
      accountNo: json['account_no'] as String,
      ifsc: json['ifsc'] as String,
      bankName: json['bank_name'] as String,
      branch: json['branch'] as String,
    );

Map<String, dynamic> _$BankDetailUpdateModelToJson(
        BankDetailUpdateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_name': instance.accountName,
      'account_no': instance.accountNo,
      'ifsc': instance.ifsc,
      'bank_name': instance.bankName,
      'branch': instance.branch,
    };
