# 管理 `lib/scene` 的文档
## 文件说明
本文档详细的维护了 `lib/scene` 目录下的文件，
旨在帮助开发者理解每个文件的用途、特点（特别是图片内容的特点, 颜色值）、关联的业务逻辑、关联的代码、关联的类以及维护时的注意事项。
修改本文档的时候，文档内描述的文件如果不存在 `lib/scene` 目录下，
请将其从文档中移除。
本文档前8行不可变。

## 概述
`scene` 目录用于组织和管理项目中的业务场景页面，每个场景通常对应一个完整的业务流程或页面集合，如首页、登录、选择登录、启动页、Web页等。通过场景划分，提升页面复用性和业务解耦。

## 目录结构
```
scene/
├── baixing_home_scene.dart           # 首页场景
├── baixing_login_scene.dart          # 登录场景
├── baixing_select_login_scene.dart   # 选择登录方式场景
├── baixing_splash_scene.dart         # 启动页场景
├── baixing_web_scene.dart            # Web页面场景
```

## 主要场景说明
### baixing_home_scene.dart
应用主页面，包含主要功能入口和导航。

### baixing_login_scene.dart
用户登录流程页面，支持多种登录方式。

### baixing_select_login_scene.dart
登录方式选择页面，支持手机号、第三方等多种登录入口。

### baixing_splash_scene.dart
应用启动页，负责初始化和引导。

### baixing_web_scene.dart
内嵌WebView页面，支持H5内容展示。

## 使用示例
```dart
// 示例：跳转到首页场景
Navigator.push(context, MaterialPageRoute(
  builder: (context) => BaixingHomeScene(),
));
```

## 注意事项
- 场景页面需与业务模块解耦，避免直接依赖业务实现。
- 页面跳转、参数传递需规范，避免混乱。
- 场景变更需同步更新本文件。

## 未来计划
- 增加更多业务场景页面，如引导页、设置页等。
- 优化场景间的跳转和状态管理。
- 完善场景的单元测试和文档示例。

## 更新记录
- 2025-05-06：完善文档结构，补充主要场景、使用示例和维护要求。