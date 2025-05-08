import 'package:go_router/go_router.dart';

import '../entity/baixing_video_entity.dart';
import '../scene/baixing_enter_teenager_mode_scene.dart';
import '../scene/baixing_home_scene.dart';
import '../scene/baixing_login_scene.dart';
import '../scene/baixing_select_login_scene.dart';
import '../scene/baixing_splash_scene.dart';
import '../scene/baixing_teenager_content_scene.dart';
import '../scene/baixing_video_player_scene.dart';
import '../scene/baixing_web_scene.dart';

GoRouter baixing_createGoRouter() {
  return GoRouter(
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
}