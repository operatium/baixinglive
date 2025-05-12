import 'dart:ui';

import '../api/baixing_api_thirdapi.dart';
import '../api/baixing_api_time.dart';

final Debouncer Baixing_debouncer = Debouncer();

VoidCallback baixing_setClick(VoidCallback ontap) {
  return () => Baixing_debouncer.debounce(
    type: BehaviorType.leadingEdge,
    duration: Baixing_dd500ms,
    onDebounce: () {
      ontap.call();
    },
  );
}
