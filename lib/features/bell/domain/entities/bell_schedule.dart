import 'package:freezed_annotation/freezed_annotation.dart';

part 'bell_schedule.freezed.dart';
part 'bell_schedule.g.dart';

@freezed
abstract class BellSchedule with _$BellSchedule {
  const factory BellSchedule({
    required String id,
    required String time, // Format: "HH:mm"
    required String audioPath,
    required String title, // e.g., "Ders Zili"
    @Default([1, 2, 3, 4, 5]) List<int> days, // 1=Mon, 7=Sun
    @Default(true) bool isEnabled,
  }) = _BellSchedule;

  factory BellSchedule.fromJson(Map<String, dynamic> json) =>
      _$BellScheduleFromJson(json);
}
