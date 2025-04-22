import 'dart:io';

import 'package:baixinglive/provider/baixing_login.dart';
import 'package:baixinglive/scene/baixing_login_scene.dart';
import 'package:baixinglive/scene/baixing_select_login_scene.dart';
import 'package:baixinglive/scene/baixing_web_scene.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:baixinglive/scene/baixing_splash_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double  windowWidth = 360;
const double  windowHeight = 640;

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
        final url = state.uri.queryParameters['url']??"";
        return Baixing_WebScene(url: url);
      },
    ),
    GoRoute(
      path: '/selectLogin',
      builder: (context, state) => const Baixing_SelectLoginScene()
    ),
    GoRoute(
        path: '/login',
        builder: (context, state) => const Baixing_LoginScene()
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
        return MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => Baixing_LoginModel()),
        ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
