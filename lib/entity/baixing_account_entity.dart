import 'package:json_annotation/json_annotation.dart';

// 生成的代码文件
part 'baixing_account_entity.g.dart';

// 使用 @JsonSerializable 注解标记类
@JsonSerializable()
class Baixing_AccountEntity {
  String username;
  String password;
  String phone;
  String token;
  
  Baixing_AccountEntity({this.username = "", this.password = "", required this.phone, this.token = ""});

  // 工厂方法，用于从 JSON 数据创建 Baixing_AccountEntity 实例
  factory Baixing_AccountEntity.fromJson(Map<String, dynamic> json) => _$Baixing_AccountEntityFromJson(json);

  // 将 Baixing_AccountEntity 实例转换为 JSON 数据
  Map<String, dynamic> toJson() => _$Baixing_AccountEntityToJson(this);
}