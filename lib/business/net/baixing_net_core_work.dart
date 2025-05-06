import 'dart:math';

import 'package:baixinglive/entity/baixing_live_room_entity.dart';
import 'package:tuple/tuple.dart';

class Baixing_NetCoreWork {
  static var _TAG = "Baixing_NetCoreWork";
  static var sBaixing_HttpTimeout = 5000;
  static final random = Random();
  static bool success = true;

  static Future<int> randomDelay({
    int maxMilliseconds = 5000,
    int minMilliseconds = 1000,
  }) async {
    final delayMilliseconds =
        random.nextInt(maxMilliseconds - minMilliseconds) + minMilliseconds;
    await Future.delayed(Duration(milliseconds: delayMilliseconds));
    return delayMilliseconds;
  }

  static Future<String> sendCode({required String phoneNumber}) async {
    await randomDelay();
    return "000000";
  }

  static Future<String> login({required String phoneNumber, required String code,}) async {
    await randomDelay();
    return "user01";
  }

  static Future<List<String>> getLiveSteamingColumn() async {
    await randomDelay();
    return ["推荐","游戏","音乐","舞蹈","美食","旅游","体育","科技","教育","娱乐"];
  }

  static Future<Tuple2<bool, List<Baixing_LiveRoomEntity>>> getLiveRoomList({required String column, required int page}) async {
    await randomDelay();
    success = !success;
    if(page > 6) {
      return Tuple2(success, []);
    }
    final c = 8;
    if(success) {
      print("yyx- 生产Baixing_LiveRoomEntity: $c个");
    }
    return Tuple2(success, _generateRandomLiveRoomList(c));
  }


  static List<Baixing_LiveRoomEntity> _generateRandomLiveRoomList(int count) {
    final random = Random();
    List<Baixing_LiveRoomEntity> liveRooms = [];
    for (int i = 0; i < count; i++) {
      liveRooms.add(Baixing_LiveRoomEntity(
        mBaixing_room_id: "roomId:${random.nextInt(10000)}",
        mBaixing_room_name: "房间名${random.nextInt(100)}",
        mBaixing_girl_name: "主播名${random.nextInt(100)}",
        mBaixing_room_cover: "https://picsum.photos/200/200?random=${random.nextInt(1000)}",
        mBaixing_audience_count: random.nextInt(1000),
      ));
    }
    return liveRooms;
  }
}