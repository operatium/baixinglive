import '../api/baixing_api_flutter.dart';

class Baixing_ConsumptionEntity {
  String mBaixing_consumer_name;
  IconData mBaixing_icon;
  String mBaixing_info;
  VoidCallback mBaixing_callback;

  Baixing_ConsumptionEntity({
    required this.mBaixing_consumer_name,
    required this.mBaixing_icon,
    required this.mBaixing_info,
    required this.mBaixing_callback,
  });
}