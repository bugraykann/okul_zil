import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'core_providers.dart';

part 'clock_provider.g.dart';

@riverpod
Stream<DateTime> clock(Ref ref) {
  final timerService = ref.watch(timerServiceProvider);
  return timerService.timeStream;
}
