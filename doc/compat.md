# 管理 `lib/compat` 的文档
## 文件说明
本文档详细维护了 `lib/compat` 目录下的文件，
旨在帮助开发者理解每个文件的用途、特点（如图片内容、颜色值）、关联的业务逻辑、关联的代码、关联的类以及维护时的注意事项。
修改本文档时，文档内描述的文件如果不存在 `lib/compat` 目录下，
请将其从文档中移除。
本文档前8行不可变。

## 目录结构
```
/compat
├── baixing_persistence.dart      # 数据持久化兼容工具
├── baixing_toast.dart           # Toast提示兼容工具
├── baixing_vibrate.dart         # 振动反馈兼容工具
```

## 文件详细说明

### baixing_persistence.dart
- 用途：封装数据持久化相关的兼容性处理，适配不同平台的本地存储方案。
- 主要特点：统一存储接口，支持异步读写，兼容Web/移动端。
- 关联业务：账号信息、用户设置、缓存数据等持久化。
- 关联代码/类：BaixingPersistence 类，常用方法如 setString/getString/setBool/getBool。
- 维护注意事项：如平台存储能力有差异需在实现和文档中注明，变更需同步更新本文件。

### baixing_toast.dart
- 用途：统一Toast提示的调用方式，兼容不同平台的提示实现。
- 主要特点：简化调用、支持多平台、可自定义样式。
- 关联业务：全局消息提示、操作反馈等。
- 关联代码/类：BaixingToast 类，show 方法。
- 维护注意事项：如平台Toast能力有差异需在实现和文档中注明，变更需同步更新本文件。

### baixing_vibrate.dart
- 用途：封装振动反馈功能，兼容不同设备的振动API。
- 主要特点：统一振动接口，支持多种振动模式。
- 关联业务：按钮点击、特殊操作反馈等。
- 关联代码/类：BaixingVibrate 类，vibrate 方法。
- 维护注意事项：如平台振动能力有差异需在实现和文档中注明，变更需同步更新本文件。

## 维护建议
- 文档描述的文件如有新增、删除、重命名，需同步更新本文件。
- 变更涉及平台兼容性时，务必在说明中注明差异和注意事项。
- 关联的业务逻辑、代码、类如有重大调整，需同步补充说明。
