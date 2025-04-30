import 'package:json_annotation/json_annotation.dart';

// 生成的代码文件
part 'baixing_live_room_entity.g.dart';

// 使用 @JsonSerializable 注解标记类
@JsonSerializable()
class Baixing_LiveRoomEntity {
  String mBaixing_room_id;
  String mBaixing_room_name;
  String mBaixing_girl_name;
  String mBaixing_room_cover;
  int mBaixing_audience_count;

  Baixing_LiveRoomEntity({
    this.mBaixing_room_id = "roomId:0",
    this.mBaixing_room_name = "房间名",
    this.mBaixing_girl_name = "主播名",
    required this.mBaixing_room_cover,
    required this.mBaixing_audience_count,
  });

  // 工厂方法，用于从 JSON 数据创建 Baixing_LiveRoomEntity 实例
  factory Baixing_LiveRoomEntity.fromJson(Map<String, dynamic> json) => _$Baixing_LiveRoomEntityFromJson(json);

  // 将 Baixing_LiveRoomEntity 实例转换为 JSON 数据
  Map<String, dynamic> toJson() => _$Baixing_LiveRoomEntityToJson(this);
}
