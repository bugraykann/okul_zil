import '../../../../core/errors/failures.dart';
import '../entities/bell_schedule.dart';

abstract class BellRepository {
  Future<({List<BellSchedule>? data, Failure? failure})> getSchedules();
  Future<({bool? success, Failure? failure})> saveSchedules(List<BellSchedule> schedules);
}
