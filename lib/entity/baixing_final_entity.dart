
import 'dart:async';

const Duration Baixing_300ms = Duration(milliseconds: 300);
const Duration Baixing_500ms = Duration(milliseconds: 500);
const Duration Baixing_1000ms = Duration(seconds: 1);

void delay300<T>([FutureOr<T> computation()?]) {
  Future.delayed(Baixing_300ms, computation);
}

void delay500<T>([FutureOr<T> computation()?]) {
  Future.delayed(Baixing_500ms, computation);
}

void delay1000<T>([FutureOr<T> computation()?]) {
  Future.delayed(Baixing_1000ms, computation);
}