# 99直播 Android 客户端

## 概述

- 本项目是99直播的Android客户端应用。应用实现了直播观看、关注主播、搜索内容、账号管理等功能。
- 资源文档很重要，需要及时更新和维护。
是根据lib下所有目录都对应生成同名的md文件（doc目录下），md文件头部必须写清楚需要管理对应的目录的路径，并且进行讲解和维护。
- 本文件9行以上不可以变。


## 技术栈

- Flutter 框架
- Dart 编程语言
- Provider 状态管理
- SharedPreferences 本地存储
- HTTP 网络请求
- GoRouter 路由管理

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

### 其他规范

- 每次修改代码前必须将修改前的代码使用Git提交
- 出现文件的增加和删除都要完善到工程索引.md文件里
- 每次修改后需要更新changelog.txt文件，记录修改内容
- 遵循Flutter的最佳实践和设计模式
- 优先使用StatelessWidget，只在必要时使用StatefulWidget

## 项目结构
- [工程索引](./工程索引.md)

## 路由配置

应用使用 GoRouter 进行路由管理，主要路由配置如下：

```dart
GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const Baixing_SplashScene(),
    ),
    GoRoute(
      path: '/web',
      builder: (context, state) {
        final url = state.uri.queryParameters['url'] ?? "";
        return Baixing_WebScene(url: url);
      },
    ),
    GoRoute(
      path: '/selectLogin',
      builder: (context, state) => const Baixing_SelectLoginScene(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Baixing_LoginScene(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Baixing_HomeScene(),
    ),
  ],
);
```

### 路由维护指南

- 所有新增页面必须在路由表中注册
- 路由路径应使用小写字母和下划线命名
- 参数传递优先使用查询参数（如 url 参数）
- 复杂页面跳转逻辑应封装在专门的导航服务中
- 路由变更必须同步更新文档

## 维护文档

### 文档目录

项目文档位于`doc`目录下，所有lib下的所有目录都需对应生成同名md文档，详细说明各模块的功能、结构、主要类、关键方法和使用示例。

- [UI组件](./doc/widget.md)：自定义控件、通用UI说明
- [页面模块](./doc/page.md)：页面结构、导航、跳转
- [业务模块](./doc/business.md)：核心业务逻辑、网络请求
- [配置模块](./doc/config.md)：常量、环境、主题配置
- [数据实体](./doc/entity.md)：数据结构、序列化
- [Fragment模块](./doc/fragment.md)：页面片段、复用逻辑
- [Provider模块](./doc/provider.md)：状态管理、数据流
- [场景模块](./doc/scene.md)：业务场景、页面组合
- [兼容性工具](./doc/compat.md)：持久化、Toast、振动等
- [路由模块](./doc/router.md)：路由配置、页面导航、参数传递

**每次目录结构或功能变更，必须同步维护上述文档。**

### 文档模板

每个模块文档应包含：
- 管理目录路径
- 概述
- 目录结构（树状图）
- 主要组件说明
- 使用示例（可运行代码）
- 注意事项
- 未来计划
- 更新日期与内容

### 文档维护要求

> **维护要求：**
> - 所有文档需与实际代码、资源保持同步，变更时务必先更新文档再提交代码。
> - 资源文档（如widget.md、page.md等）需详细描述用途、结构、注意事项，便于团队协作和后续维护。
> - 变更文档需在changelog.txt记录时间和文件路径。
> - 路由变更必须同步更新README.md中的路由配置部分，确保路由表与实际代码保持一致。
> - 路由使用示例应包含在相应页面的文档中，便于开发人员理解页面间的跳转关系。
> - 维护文档时，严格遵循各文档开头的"概述"与"维护流程"说明。
> - 每次更新文档时，需在文档底部添加更新日期和更新内容。
> - 重要API或结构变更必须在文档中明确标注。
> - 文档中的示例代码必须可运行并符合项目代码规范。
> - 当模块结构发生变化时，必须更新对应的目录结构图。
