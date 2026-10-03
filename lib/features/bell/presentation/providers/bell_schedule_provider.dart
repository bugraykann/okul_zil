import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/bell_schedule.dart';
import 'bell_repository_provider.dart';

part 'bell_schedule_provider.g.dart';

@Riverpod(keepAlive: true)
class BellScheduleNotifier extends _$BellScheduleNotifier {
  @override
  Future<List<BellSchedule>> build() async {
    return _fetchSchedules();
  }

  Future<List<BellSchedule>> _fetchSchedules() async {
    final useCase = ref.read(getSchedulesUseCaseProvider);
    final result = await useCase.execute();
    
    if (result.failure != null) {
      throw Exception(result.failure!.message);
    }
    
    return result.data ?? [];
  }

  Future<void> saveSchedules(List<BellSchedule> schedules) async {
    final repo = ref.read(bellRepositoryProvider);
    final result = await repo.saveSchedules(schedules);
    if (result.success == true) {
      state = AsyncValue.data(schedules);
    } else {
      throw Exception(result.failure?.message ?? 'Kaydetme hatası');
    }
  }

  Future<void> addSchedule(BellSchedule schedule) async {
    final current = state.value ?? [];
    final updated = [...current, schedule];
    updated.sort((a, b) => a.time.compareTo(b.time));
    await saveSchedules(updated);
  }

  Future<void> updateSchedule(BellSchedule schedule) async {
    final current = state.value ?? [];
    final updated = current.map((s) => s.id == schedule.id ? schedule : s).toList();
    updated.sort((a, b) => a.time.compareTo(b.time));
    await saveSchedules(updated);
  }

  Future<void> deleteSchedule(String id) async {
    final current = state.value ?? [];
    final updated = current.where((s) => s.id != id).toList();
    await saveSchedules(updated);
  }

  Future<void> toggleSchedule(String id, bool isEnabled) async {
    final current = state.value ?? [];
    final updated = current.map((s) {
      if (s.id == id) {
        return s.copyWith(isEnabled: isEnabled);
      }
      return s;
    }).toList();
    await saveSchedules(updated);
  }

  Future<void> deleteSchedulesForDay(int day) async {
    final current = state.value ?? [];
    final List<BellSchedule> updated = [];
    
    for (var s in current) {
      if (s.days.contains(day)) {
        final newDays = s.days.where((d) => d != day).toList();
        if (newDays.isNotEmpty) {
          updated.add(s.copyWith(days: newDays));
        }
      } else {
        updated.add(s);
      }
    }
    
    await saveSchedules(updated);
  }

  Future<void> deleteAllSchedules() async {
    await saveSchedules([]);
  }
}
