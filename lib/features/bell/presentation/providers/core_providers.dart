import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/services/timer_service.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
AudioService audioService(Ref ref) {
  return AudioService();
}

@Riverpod(keepAlive: true)
TimerService timerService(Ref ref) {
  final service = TimerService();
  service.startTimer();
  ref.onDispose(() => service.stopTimer());
  return service;
}
