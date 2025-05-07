import 'package:json_annotation/json_annotation.dart';

// 生成的代码文件
part 'baixing_video_entity.g.dart';

// 使用 @JsonSerializable 注解标记类
@JsonSerializable()
class Baixing_VideoEntity {
  String mBaixing_VideoUrl;
  String mBaixing_VideoName;

  Baixing_VideoEntity({required this.mBaixing_VideoUrl, required this.mBaixing_VideoName});

  // 工厂方法，用于从 JSON 数据创建 Baixing_VideoEntity 实例
  factory Baixing_VideoEntity.fromJson(Map<String, dynamic> json) => _$Baixing_VideoEntityFromJson(json);

  // 将 Baixing_VideoEntity 实例转换为 JSON 数据
  Map<String, dynamic> toJson() => _$Baixing_VideoEntityToJson(this);
}