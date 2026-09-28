import 'dart:async';

import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/bell_schedule.dart';
import 'bell_schedule_provider.dart';
import 'core_providers.dart';
import 'system_active_provider.dart';
import 'log_provider.dart';

part 'bell_manager_provider.g.dart';

@Riverpod(keepAlive: true)
class BellManager extends _$BellManager {
  StreamSubscription<DateTime>? _timerSubscription;
  String? _lastPlayedTime;

  @override
  BellSchedule? build() {
    _init();
    return null; // Initial state is the next bell
  }

  void _init() {
    final timerService = ref.watch(timerServiceProvider);

    _timerSubscription = timerService.timeStream.listen((currentTime) {
      _checkBells(currentTime);
      _updateNextBell(currentTime);
    });

    ref.onDispose(() {
      _timerSubscription?.cancel();
    });
  }

  void _checkBells(DateTime currentTime) {
    // Eğer sistem kapalıysa (Tatil modundaysa), otomatik zilleri çalma
    final isSystemActive = ref.read(systemActiveProvider);
    if (!isSystemActive) return;

    final schedulesAsync = ref.read(bellScheduleProvider);
    schedulesAsync.whenData((schedules) {
      final formattedTime = DateFormat('HH:mm').format(currentTime);

      if (currentTime.second == 0 && _lastPlayedTime != formattedTime) {
        final activeBells = schedules.where(
          (s) =>
              s.isEnabled &&
              s.time == formattedTime &&
              s.days.contains(currentTime.weekday),
        );
        for (var bell in activeBells) {
          playBell(bell);
        }
        _lastPlayedTime = formattedTime;
      }
    });
  }

  void _updateNextBell(DateTime currentTime) {
    final schedulesAsync = ref.read(bellScheduleProvider);
    schedulesAsync.whenData((schedules) {
      if (schedules.isEmpty) {
        state = null;
        return;
      }

      final currentFormatted = DateFormat('HH:mm').format(currentTime);

      final enabledBells = schedules
          .where((s) => s.isEnabled && s.days.contains(currentTime.weekday))
          .toList();
      enabledBells.sort((a, b) => a.time.compareTo(b.time));

      // Find the first bell that is after the current time
      BellSchedule? next;
      for (var bell in enabledBells) {
        if (bell.time.compareTo(currentFormatted) > 0) {
          next = bell;
          break;
        }
      }

      // If none is found after current time, next is the first one tomorrow
      next ??= enabledBells.isNotEmpty ? enabledBells.first : null;

      if (state != next) {
        state = next;
      }
    });
  }

  Future<void> playBell(BellSchedule bell) async {
    final audioService = ref.read(audioServiceProvider);
    await audioService.playAudio(bell.audioPath);
    ref
        .read(logManagerProvider.notifier)
        .addLog('${bell.time} - ${bell.title}', type: 'auto');
  }

  Future<void> playEmergencyBell() async {
    final audioService = ref.read(audioServiceProvider);
    await audioService.playAudio('assets/audio/emergency.mp3', isManual: true);
    ref
        .read(logManagerProvider.notifier)
        .addLog('ACİL DURUM ZİLİ', type: 'manual');
  }
}
