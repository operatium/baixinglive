import 'dart:io';

import 'package:baixinglive/provider/baixing_account_model.dart';
import 'package:baixinglive/provider/baixing_live_room_list_model.dart';
import 'package:baixinglive/provider/baixing_live_streaming_column_model.dart';
import 'package:baixinglive/provider/baixing_login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'api/baixing_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupWindow();
  runApp(const MyApp());
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
            routerConfig: baixing_createGoRouter(),
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
