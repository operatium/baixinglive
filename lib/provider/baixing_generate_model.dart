import 'dart:math';

class Baixing_GenerateModel {
  static final random = Random();

  // 生成随机头像 URL 的函数
  static List<String> baixing_generateRandomAvatarUrls(int count) {
    List<String> urls = [];
    for (int i = 0; i < count; i++) {
      // 随机生成一个介于 0 到 1084 之间的 ID
      int randomId = random.nextInt(1085);
      urls.add('https://picsum.photos/id/$randomId/200/200');
    }
    return urls;
  }
}