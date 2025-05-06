import 'package:baixinglive/business/net/baixing_net_core_work.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

class Baixing_LiveStraeamingColumnModel extends ChangeNotifier {
  List<String> columnList = [];

  Future<Tuple2<bool, List<String>>> baixing_getLiveSteamingColumn() async {
    Tuple2<bool, List<String>> result = await Baixing_NetCoreWork.getLiveSteamingColumn();
    if(result.item1) {
      columnList.clear();
      columnList.addAll(result.item2);
    }
    notifyListeners();
    return result;
  }
}