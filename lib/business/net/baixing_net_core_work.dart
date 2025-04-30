import 'dart:math';

class Baixing_NetCoreWork {
  static var _TAG = "Baixing_NetCoreWork";
  static var sBaixing_HttpTimeout = 5000;

  static Future<int> randomDelay({
    int maxMilliseconds = 2000,
    int minMilliseconds = 500,
  }) async {
    final random = Random();
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

}