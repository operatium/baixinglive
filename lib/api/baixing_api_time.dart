import 'dart:async';

int baixing_getNowTime() {
  return DateTime.now().millisecondsSinceEpoch;
}

const Duration Baixing_dd300ms = Duration(milliseconds: 300);
const Duration Baixing_dd500ms = Duration(milliseconds: 500);
const Duration Baixing_dd1000ms = Duration(seconds: 1);
const Duration Baixing_dd3000ms = Duration(seconds: 3);
const Duration Baixing_dd1mi = Duration(minutes: 1);

void delay300<T>([FutureOr<T> computation()?]) {
  Future.delayed(Baixing_dd300ms, computation);
}

void delay500<T>([FutureOr<T> computation()?]) {
  Future.delayed(Baixing_dd500ms, computation);
}

void delay1000<T>([FutureOr<T> computation()?]) {
  Future.delayed(Baixing_dd1000ms, computation);
}
