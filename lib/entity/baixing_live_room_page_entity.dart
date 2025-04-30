import 'package:json_annotation/json_annotation.dart';

import 'baixing_live_room_entity.dart';

// 生成的代码文件
part 'baixing_live_room_page_entity.g.dart';

// 使用 @JsonSerializable 注解标记类
@JsonSerializable()
class Baixing_LiveRoomPageEntity {
  List<Baixing_LiveRoomEntity> mBaixing_liveRooms = [];
  int mBaixing_page = 0;

  Baixing_LiveRoomPageEntity({required this.mBaixing_liveRooms, this.mBaixing_page= 0});

  // 工厂方法，用于从 JSON 数据创建 Baixing_LiveRoomPageEntity 实例
  factory Baixing_LiveRoomPageEntity.fromJson(Map<String, dynamic> json) => _$Baixing_LiveRoomPageEntityFromJson(json);

  // 将 Baixing_LiveRoomPageEntity 实例转换为 JSON 数据
  Map<String, dynamic> toJson() => _$Baixing_LiveRoomPageEntityToJson(this);
}