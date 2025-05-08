# 99直播 Android 客户端

## 概述
- 路由配置必须检查，保证与lib/main.dart保持一致和正确。
- 必须检查根据lib下所有目录都对应生成同名的md文件（doc目录下），md文件头部必须写清楚需要管理对应的目录的路径，并且进行讲解和维护。
- 本文件23行以上不可以变。

## 工程设计思路
- 入口函数在lib/main.dart
- 路由表定义在lib/main.dart
- 字体风格定义在lib/main.dart
- Provider类定义在lib/main.dart
- api目录下的代码定义所有的业务入口
- 启动页：
  - Baixing_SplashScene，对应/splash路由
  - 判断是否启用青少年模式，如果启用，跳转到青少年模式入口页，否则跳转到主页
  - 判断是否登录，如果登录，跳转到主页，否则跳转到登录页

- 青少年模式：
  - 入口函数 baixing_showTeenagersHitDialog
  - 入口页 Baixing_EnterTeenagerModeScene
  - 内容页 Baixing_TeenagerContentScene
  - 视频播放页 Baixing_VideoPlayerScene，需传递 Baixing_VideoEntity 实例（通过 extra 参数）
  - 视频实体 Baixing_VideoEntity
  - 逻辑 设置密码 -> 青少年内容页 -> 单次使用不超过40分钟 -> 弹窗输入密码续时间 -> 输入密码退出
  - 注意 启用青少年模式后，杀死应用后再次启动，直接进入青少年模式，需要输入密码才能退出青少年模式


## 技术栈

- Flutter 框架
- Dart 编程语言
- Provider 状态管理
- SharedPreferences 本地存储
- HTTP 网络请求
- GoRouter 路由管理
- JSON采用自动生成
```shell
flutter pub run build_runner build
```


## 字体风格规范

本项目采用主流App常用的字体体系，主字体为“PingFang SC”，适配大部分中文移动端场景。各类型字体风格如下：

- displayLarge: 32.sp，粗体，黑色
- displayMedium: 28.sp，粗体，黑色
- displaySmall: 24.sp，粗体，黑色
- headlineLarge: 22.sp，半粗体，黑色
- headlineMedium: 20.sp，半粗体，黑色
- headlineSmall: 18.sp，中粗体，黑色
- titleLarge: 18.sp，加粗，黑色
- titleMedium: 16.sp，半粗体，黑色
- titleSmall: 14.sp，中粗体，黑色
- bodyLarge: 16.sp，常规，黑色87%
- bodyMedium: 14.sp，常规，黑色87%
- bodySmall: 12.sp，常规，黑色54%
- labelLarge: 14.sp，常规，主题紫色
- labelMedium: 12.sp，常规，灰色
- labelSmall: 10.sp，常规，浅灰色

所有字体均采用fontFamily: 'PingFang SC'，整体风格现代、易读，适配主流移动端UI。

## 开发规范

### 命名规范

- 类的前缀是: Baixing_
- 私有类的前缀是: Baixing_
- 成员变量的前缀是: mBaixing_
- 私有成员变量的前缀是: _mBaixing_
- 函数的前缀是: baixing_
- 私有函数的前缀是: _baixing_
- 数据类的类名都以Entity结尾

### 布局规范

- 使用Flutter的响应式布局，确保在不同尺寸的设备上都能正常显示
- 使用flutter_screenutil进行屏幕适配
- 布局组件优先使用Column、Row、Stack等基础组件
- 页面布局应遵循从上到下、从左到右的顺序

### 代码规范

- 所有类必须在顶部添加标准注释（作者、日期、描述）格式必须是
/**
 * @author yuyuexing
 * @date: 
 * @description: 
 */
- 每一个类都必须创建一个新的文件
- 每一个类都必须定义一个新的类
- 代码缩进使用2个空格
- 使用驼峰命名法
- 避免过长的方法，一个方法最好不超过50行
- 注释应该解释为什么这样做，而不是做了什么
- 持久化采用Baixing_SharedPreferences类

## 项目结构
- [工程索引](./工程索引.md)

## 路由配置

应用使用 GoRouter 进行路由管理，主要路由配置如下：

- /splash：启动页，对应 Baixing_SplashScene
- /web：Web页面，对应 Baixing_WebScene，支持 url 参数
- /selectLogin：选择登录方式页，对应 Baixing_SelectLoginScene
- /login：登录页，对应 Baixing_LoginScene
- /home：首页，对应 Baixing_HomeScene
- /teenager：青少年模式入口页，对应 Baixing_EnterTeenagerModeScene
- /teenagerContent：青少年模式内容页，对应 Baixing_TeenagerContentScene
- /video：视频播放页，对应 Baixing_VideoPlayerScene，需传递 Baixing_VideoEntity 实例（通过 extra 参数）

### 文档目录

项目文档位于`doc`目录下，所有lib下的所有目录都需对应生成同名md文档，详细说明各模块的功能、结构、主要类、关键方法和使用示例。

- [UI组件](./doc/widget.md)：自定义控件、通用UI说明
- [页面模块](./doc/page.md)：页面结构、导航、跳转
- [业务模块](./doc/business.md)：核心业务逻辑、网络请求
- [配置模块](./doc/config.md)：常量、环境、主题配置
- [弹窗模块](./doc/dialog.md)：各类业务弹窗组件
- [条目组件](./doc/item.md)：页面/业务条目组件
- [工具模块](./doc/utils.md)：通用工具类与辅助函数
- [数据实体](./doc/entity.md)：数据结构、序列化
- [Fragment模块](./doc/fragment.md)：页面片段、复用逻辑
- [Provider模块](./doc/provider.md)：状态管理、数据流
- [场景模块](./doc/scene.md)：业务场景、页面组合
- [兼容性工具](./doc/compat.md)：持久化、Toast、振动等
- [路由模块](./doc/router.md)：路由配置、页面导航、参数传递