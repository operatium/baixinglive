// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baixing_account_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Baixing_AccountEntity _$Baixing_AccountEntityFromJson(
  Map<String, dynamic> json,
) => Baixing_AccountEntity(
  username: json['username'] as String? ?? "",
  password: json['password'] as String? ?? "",
  phone: json['phone'] as String,
  token: json['token'] as String? ?? "",
);

Map<String, dynamic> _$Baixing_AccountEntityToJson(
  Baixing_AccountEntity instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'phone': instance.phone,
  'token': instance.token,
};
