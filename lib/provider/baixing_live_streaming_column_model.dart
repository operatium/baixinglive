import 'package:baixinglive/business/net/baixing_net_core_work.dart';
import 'package:flutter/foundation.dart';

class Baixing_LiveStraeamingColumnModel extends ChangeNotifier {
  List<String> columnList = [];

  Future<List<String>> baixing_getLiveSteamingColumn() async {
    final result = await Baixing_NetCoreWork.getLiveSteamingColumn();
    columnList.clear();
    columnList.addAll(result);
    notifyListeners();
    return columnList;
  }
}