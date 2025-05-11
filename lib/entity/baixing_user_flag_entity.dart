import '../api/baixing_api_flutter.dart';

class Baixing_UserFlagEntity {
  String mBaixing_flagName;
  bool mBaixing_isLock;
  IconData mBaixing_icon;
  String mBaixing_url;

  Baixing_UserFlagEntity({
    required this.mBaixing_flagName,
    required this.mBaixing_isLock,
    required this.mBaixing_icon,
    this.mBaixing_url = "https://www.163.com",
  });
}