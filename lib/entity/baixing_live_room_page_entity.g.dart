// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baixing_live_room_page_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Baixing_LiveRoomPageEntity _$Baixing_LiveRoomPageEntityFromJson(
  Map<String, dynamic> json,
) => Baixing_LiveRoomPageEntity(
  mBaixing_liveRooms:
      (json['mBaixing_liveRooms'] as List<dynamic>)
          .map(
            (e) => Baixing_LiveRoomEntity.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  mBaixing_page: (json['mBaixing_page'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$Baixing_LiveRoomPageEntityToJson(
  Baixing_LiveRoomPageEntity instance,
) => <String, dynamic>{
  'mBaixing_liveRooms': instance.mBaixing_liveRooms,
  'mBaixing_page': instance.mBaixing_page,
};
