class BaixingResources {
  static const String levelIcon0 = 'images/baixing_level_icon0.png';
  static const String level0 = 'images/baixing_level0.webp';
  static const String levelTag0 = 'images/baixing_level_tag0.webp';
  static const String levelIcon1 = 'images/baixing_level_icon1.png';
  static const String level1 = 'images/baixing_level1.webp';
  static const String levelIcon2 = 'images/baixing_level_icon2.png';
  static const String level2 = 'images/baixing_level2.webp';
  static const String levelIcon3 = 'images/baixing_level_icon3.png';
  static const String level3 = 'images/baixing_level3.webp';
  static const String levelTag3 = 'images/baixing_level_tag3.webp';
  static const String levelIcon4 = 'images/baixing_level_icon4.png';
  static const String level4 = 'images/baixing_level4.webp';
  static const String levelIcon5 = 'images/baixing_level_icon5.png';
  static const String level5 = 'images/baixing_level5.webp';
  static const String levelIcon6 = 'images/baixing_level_icon6.png';
  static const String level6 = 'images/baixing_level6.webp';
  static const String levelIcon7 = 'images/baixing_level_icon7.png';
  static const String level7 = 'images/baixing_level7.webp';
  static const String levelIcon8 = 'images/baixing_level_icon8.png';
  static const String level8 = 'images/baixing_level8.webp';
  static const String levelIcon9 = 'images/baixing_level_icon9.png';
  static const String level9 = 'images/baixing_level9.webp';
}

enum Baixing_Level {
  level0(0, BaixingResources.levelIcon0, BaixingResources.level0, BaixingResources.levelTag0, "黑铁"),
  level1(1, BaixingResources.levelIcon1, BaixingResources.level1, BaixingResources.levelTag0, "青铜"),
  level2(2, BaixingResources.levelIcon2, BaixingResources.level2, BaixingResources.levelTag0, "白银"),
  level3(3, BaixingResources.levelIcon3, BaixingResources.level3, BaixingResources.levelTag3, "黄金"),
  level4(4, BaixingResources.levelIcon4, BaixingResources.level4, BaixingResources.levelTag0, "铂金"),
  level5(5, BaixingResources.levelIcon5, BaixingResources.level5, BaixingResources.levelTag0, "黑金"),
  level6(6, BaixingResources.levelIcon6, BaixingResources.level6, BaixingResources.levelTag0, "钻石1"),
  level7(7, BaixingResources.levelIcon7, BaixingResources.level7, BaixingResources.levelTag0, "钻石2"),
  level8(8, BaixingResources.levelIcon8, BaixingResources.level8, BaixingResources.levelTag0, "钻石3"),
  level9(9, BaixingResources.levelIcon9, BaixingResources.level9, BaixingResources.levelTag0, "钻石4");

  final int mBaixing_level;
  final String mBaixing_imageRes;
  final String mBaixing_iconRes;
  final String mBaixing_tagRes;
  final String mBaixing_name;

  const Baixing_Level(this.mBaixing_level, this.mBaixing_imageRes, this.mBaixing_iconRes, this.mBaixing_tagRes, this.mBaixing_name);

  static Baixing_Level baixing_fromLevel(int level) {
    return Baixing_Level.values.firstWhere((element) => element.mBaixing_level == level, orElse: () => Baixing_Level.level0);
  }

  @override
  String toString() {
    return "Baixing_Level(mBaixing_level=$mBaixing_level, mBaixing_imageRes=$mBaixing_imageRes, mBaixing_iconRes=$mBaixing_iconRes, mBaixing_tagRes=$mBaixing_tagRes, mBaixing_name='$mBaixing_name')";
  }
}