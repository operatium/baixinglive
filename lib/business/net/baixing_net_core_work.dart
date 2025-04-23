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
    var delay = await randomDelay();
    if (delay % 2 == 0) {
      return "000000";
    } else {
      return "";
    }
  }

  static Future<String> login({required String phoneNumber, required String code,}) async {
    var delay = await randomDelay();
    if (delay % 2 == 0) {
      return "user01";
    } else {
      return "";
    }
  }
}