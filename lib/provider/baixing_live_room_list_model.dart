import 'package:baixinglive/business/net/baixing_net_core_work.dart';
import 'package:baixinglive/entity/baixing_live_room_entity.dart';
import 'package:baixinglive/entity/baixing_live_room_page_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

class Baixing_LiveRoomListModel extends ChangeNotifier {
  final Map<String, Map<int, Baixing_LiveRoomPageEntity>> _liveRoomMap = {};
  final Map<String, int> _liveRoomPageMap = {};

  List<Baixing_LiveRoomEntity> getList(String column) {
    List<Baixing_LiveRoomEntity> list = [];
    if(_liveRoomMap[column] == null) {
      return list;
    } else {
      final map = _liveRoomMap[column];
      for(int i = 0; i < map!.length; i++) {
        if(map[i] != null) {
          list += map[i]!.mBaixing_liveRooms;
        }
      }
      return list;
    }
  }

  Future<Tuple2<bool, List<Baixing_LiveRoomEntity>>> requestFirstLiveRoomList(String column) async {
    _liveRoomPageMap[column] = 0;
    return await _requestLiveRoomList(column, 0);
  }

  Future<Tuple2<bool, List<Baixing_LiveRoomEntity>>> requestNextLiveRoomList(String column) async {
    if(_liveRoomPageMap[column] == null) {
      _liveRoomPageMap[column] = 0;
    }
    final old = _liveRoomPageMap[column]!;
    _liveRoomPageMap[column] = _liveRoomPageMap[column]! + 1;
    var result = await _requestLiveRoomList(column, _liveRoomPageMap[column]!);
    if(!result.item1) {
      _liveRoomPageMap[column] = old;
    }
    return result;
  }

  Future<Tuple2<bool, List<Baixing_LiveRoomEntity>>> _requestLiveRoomList(String column, int page) async {
    final result = await Baixing_NetCoreWork.getLiveRoomList(
      column: column,
      page: page,
    );
    if(result.item1) {
      _addDataCache(column, page, result.item2);
    }
    notifyListeners();
    return result;
  }

  void _addDataCache(String column, int page, List<Baixing_LiveRoomEntity> list) {
    Baixing_LiveRoomPageEntity pageEntity = Baixing_LiveRoomPageEntity(
      mBaixing_page: page,
      mBaixing_liveRooms: list,
    );
    if (_liveRoomMap[column] == null || page == 0) {
      _liveRoomMap[column] = {};
    }
    _liveRoomMap[column]![pageEntity.mBaixing_page] = pageEntity;
  }
}
