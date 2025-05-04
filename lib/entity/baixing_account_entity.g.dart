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
  mBaixing_nickName: json['mBaixing_nickName'] as String? ?? "尊贵的客人",
  mBaixing_id: json['mBaixing_id'] as String? ?? "7418964",
  mBaixing_avatarUrl:
      json['mBaixing_avatarUrl'] as String? ??
      "https://picsum.photos/id/700/200/200",
  mBaixing_level: (json['mBaixing_level'] as num?)?.toInt() ?? 0,
  mBaixing_levelTimeoutHit: json['mBaixing_levelTimeoutHit'] as String? ?? "",
  mBaixing_levelUpdateHit: json['mBaixing_levelUpdateHit'] as String? ?? "",
);

Map<String, dynamic> _$Baixing_AccountEntityToJson(
  Baixing_AccountEntity instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'phone': instance.phone,
  'token': instance.token,
  'mBaixing_nickName': instance.mBaixing_nickName,
  'mBaixing_id': instance.mBaixing_id,
  'mBaixing_avatarUrl': instance.mBaixing_avatarUrl,
  'mBaixing_level': instance.mBaixing_level,
  'mBaixing_levelTimeoutHit': instance.mBaixing_levelTimeoutHit,
  'mBaixing_levelUpdateHit': instance.mBaixing_levelUpdateHit,
};
