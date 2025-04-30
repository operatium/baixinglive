// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baixing_live_room_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Baixing_LiveRoomEntity _$Baixing_LiveRoomEntityFromJson(
  Map<String, dynamic> json,
) => Baixing_LiveRoomEntity(
  mBaixing_room_id: json['mBaixing_room_id'] as String? ?? "roomId:0",
  mBaixing_room_name: json['mBaixing_room_name'] as String? ?? "房间名",
  mBaixing_girl_name: json['mBaixing_girl_name'] as String? ?? "主播名",
  mBaixing_room_cover: json['mBaixing_room_cover'] as String,
  mBaixing_audience_count: (json['mBaixing_audience_count'] as num).toInt(),
);

Map<String, dynamic> _$Baixing_LiveRoomEntityToJson(
  Baixing_LiveRoomEntity instance,
) => <String, dynamic>{
  'mBaixing_room_id': instance.mBaixing_room_id,
  'mBaixing_room_name': instance.mBaixing_room_name,
  'mBaixing_girl_name': instance.mBaixing_girl_name,
  'mBaixing_room_cover': instance.mBaixing_room_cover,
  'mBaixing_audience_count': instance.mBaixing_audience_count,
};
