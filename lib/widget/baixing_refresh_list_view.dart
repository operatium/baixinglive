import 'dart:math' as math;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


typedef Baixing_onRefreshBuilder = Future<void> Function(IndicatorController controller);

class Baixing_RefreshListView extends StatefulWidget {
  Baixing_onRefreshBuilder mBaixing_onRefresh;
  Widget child;

  Baixing_RefreshListView({
    Key? key,
    required this.child,
    required this.mBaixing_onRefresh,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Baixing_RefreshListViewState();
  }
}

class _Baixing_RefreshListViewState extends State<Baixing_RefreshListView> {
  final _indicatorController = IndicatorController();

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      onRefresh: () => widget.mBaixing_onRefresh(_indicatorController),
      controller: _indicatorController,
      backgroundColor: Colors.white,
      durations: RefreshIndicatorDurations(
        cancelDuration: const Duration(milliseconds: 300),
        settleDuration: const Duration(milliseconds: 300),
        finalizeDuration: const Duration(milliseconds: 300),
        completeDuration: const Duration(milliseconds: 300),
      ),
      child: widget.child,
    );
  }
}
