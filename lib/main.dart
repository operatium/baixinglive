import 'dart:io';

import 'package:baixinglive/provider/baixing_account_model.dart';
import 'package:baixinglive/provider/baixing_live_room_list_model.dart';
import 'package:baixinglive/provider/baixing_live_streaming_column_model.dart';
import 'package:baixinglive/provider/baixing_login_model.dart';
import 'package:baixinglive/scene/baixing_home_scene.dart';
import 'package:baixinglive/scene/baixing_login_scene.dart';
import 'package:baixinglive/scene/baixing_select_login_scene.dart';
import 'package:baixinglive/scene/baixing_web_scene.dart';
import 'package:baixinglive/scene/baixing_teenager_mode_scene.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
        final isInfoPage = state.uri.queryParameters['isInfoPage'] == 'true';
        final isVerifying = state.uri.queryParameters['isVerifying'] == 'true';
        return Baixing_TeenagerModeScene(
          isInfoPage: isInfoPage,
          isVerifying: isVerifying,
        );
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
                titleLarge: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
                titleMedium: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                titleSmall: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                labelLarge: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                labelMedium: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                labelSmall: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff888888),
                ),
                bodySmall: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              )
            ),
          ),
        );
      },
    );
  }
}
