import 'package:json_annotation/json_annotation.dart';

// 生成的代码文件
part 'person.g.dart';

// 使用 @JsonSerializable 注解标记类
@JsonSerializable()
class Person {
  String name;
  int age;

  Person({required this.name, this.age= 0});

  // 工厂方法，用于从 JSON 数据创建 Person 实例
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  // 将 Person 实例转换为 JSON 数据
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}