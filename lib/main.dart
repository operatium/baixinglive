import 'dart:io';

import 'package:baixinglive/entity/baixing_video_entity.dart';
import 'package:baixinglive/provider/baixing_account_model.dart';
import 'package:baixinglive/provider/baixing_live_room_list_model.dart';
import 'package:baixinglive/provider/baixing_live_streaming_column_model.dart';
import 'package:baixinglive/provider/baixing_login_model.dart';
import 'package:baixinglive/scene/baixing_enter_teenager_mode_scene.dart';
import 'package:baixinglive/scene/baixing_home_scene.dart';
import 'package:baixinglive/scene/baixing_login_scene.dart';
import 'package:baixinglive/scene/baixing_select_login_scene.dart';
import 'package:baixinglive/scene/baixing_teenager_content_scene.dart';
import 'package:baixinglive/scene/baixing_video_player_scene.dart';
import 'package:baixinglive/scene/baixing_web_scene.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:baixinglive/scene/baixing_splash_scene.dart';
import 'package:baixinglive/business/teenager/baixing_teenager_mode_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupWindow();
  
  // 检查是否是新的一天，如果是则重置青少年模式使用时间
  await _baixing_checkAndResetDailyUsage();
  
  runApp(const MyApp());
}

// 检查并重置每日使用时间
Future<void> _baixing_checkAndResetDailyUsage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final lastUsageDate = prefs.getString('teenager_mode_last_usage_date');
  final today = DateTime.now().toString().split(' ')[0]; // 获取当前日期（年-月-日）
  
  if (lastUsageDate != today) {
    // 新的一天，重置使用时间
    await Baixing_TeenagerModeUtil.instance.baixing_resetDailyUsageTime();
    await prefs.setString('teenager_mode_last_usage_date', today);
  }
}

const double windowWidth = 360;
const double windowHeight = 640;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('99直播');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(
        Rect.fromCenter(
          center: screen!.frame.center,
          width: windowWidth,
          height: windowHeight,
        ),
      );
    });
  }
}

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
    GoRoute(
      path: '/teenager',
      builder: (context, state) {
        return Baixing_EnterTeenagerModeScene();
      },
    ),
    GoRoute(
      path: '/teenagerContent',
      builder: (context, state) {
        return Baixing_TeenagerContentScene();
      },
    ),
    GoRoute(
      path: '/video',
      builder: (context, state) {
        Baixing_VideoEntity videoEntity = state.extra as Baixing_VideoEntity;
        return Baixing_VideoPlayerScene(mBaixing_videoEntity: videoEntity);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(windowWidth, windowHeight),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Baixing_LoginModel()),
            ChangeNotifierProvider(create: (context) => Baixing_LiveStraeamingColumnModel()),
            ChangeNotifierProvider(create: (context) => Baixing_AccountModel()),
            ChangeNotifierProvider(create: (context) => Baixing_LiveRoomListModel()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            title: '99直播',
            theme: ThemeData(
              splashFactory: NoSplash.splashFactory,
              scaffoldBackgroundColor: Color(0xfff7f7f7),
              primaryColor: Color(0xff8955F7),
              textTheme: TextTheme(
                displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'PingFang SC'),
                displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'PingFang SC'),
                displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'PingFang SC'),
                headlineLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'PingFang SC'),
                headlineMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'PingFang SC'),
                headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'PingFang SC'),
                titleLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.black, fontFamily: 'PingFang SC'),
                titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'PingFang SC'),
                titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'PingFang SC'),
                bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.black87, fontFamily: 'PingFang SC'),
                bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.black87, fontFamily: 'PingFang SC'),
                bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.black54, fontFamily: 'PingFang SC'),
                labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xff8955F7), fontFamily: 'PingFang SC'),
                labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(0xff888888), fontFamily: 'PingFang SC'),
                labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Color(0xffcccccc), fontFamily: 'PingFang SC'),
              )
            ),
          ),
        );
      },
    );
  }
}
