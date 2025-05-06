# 路由模块

## 管理目录路径
`lib/main.dart`中的路由配置部分

## 概述
本项目使用 GoRouter 进行路由管理，实现了页面间的导航和参数传递。路由配置集中在 main.dart 文件中，便于统一管理和维护。

## 路由结构

```
GoRouter
├── /splash - 启动页面
├── /web - Web页面（带url参数）
├── /selectLogin - 选择登录方式页面
├── /login - 登录页面
└── /home - 主页面
```

## 主要组件说明

### GoRouter 配置

```dart
GoRouter router = GoRouter(
  initialLocation: '/splash',  // 初始路由路径
  routes: [                    // 路由列表
    GoRoute(
      path: '/splash',        // 路由路径
      builder: (context, state) => const Baixing_SplashScene(), // 页面构建器
    ),
    GoRoute(
      path: '/web',
      builder: (context, state) {
        final url = state.uri.queryParameters['url'] ?? ""; // 获取查询参数
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

## 使用示例

### 基本导航

```dart
// 导航到主页
context.go('/home');

// 导航到登录页
context.go('/login');

// 导航到Web页面并传递url参数
context.go('/web?url=https://example.com');
```

### 获取路由参数

```dart
// 在页面构建器中获取参数
GoRoute(
  path: '/web',
  builder: (context, state) {
    // 获取查询参数
    final url = state.uri.queryParameters['url'] ?? "";
    return Baixing_WebScene(url: url);
  },
),

// 在页面内获取参数
class Baixing_WebScene extends StatelessWidget {
  final String url;
  
  const Baixing_WebScene({required this.url, super.key});
  
  @override
  Widget build(BuildContext context) {
    // 使用url参数
    return WebView(initialUrl: url);
  }
}
```

### 返回上一页

```dart
// 返回上一页
context.pop();

// 返回并传递结果
context.pop(true); // 可以传递任意类型的结果
```

## 注意事项

1. **路由命名规范**：
   - 路由路径使用小写字母和下划线
   - 路径应简洁明了，反映页面功能

2. **参数传递**：
   - 简单参数优先使用查询参数（如 `?url=xxx`）
   - 复杂参数可考虑使用路径参数（如 `/user/:id`）
   - 非常复杂的数据应通过状态管理（Provider）传递

3. **路由维护**：
   - 所有新增页面必须在路由表中注册
   - 路由变更必须同步更新文档
   - 删除页面时确保没有其他页面仍在引用该路由

4. **错误处理**：
   - 考虑添加错误路由处理（404页面）
   - 处理无效参数的情况

## 未来计划

1. 添加路由守卫功能，控制页面访问权限
2. 实现更复杂的嵌套路由结构
3. 添加路由动画和转场效果
4. 优化路由历史管理
5. 考虑实现深层链接（Deep Linking）支持

## 更新记录

- 2025-05-06：创建路由文档，添加基本使用说明和维护指南