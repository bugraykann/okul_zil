import '../../../../core/errors/failures.dart';
import '../entities/bell_schedule.dart';
import '../repositories/bell_repository.dart';

class GetSchedulesUseCase {
  final BellRepository repository;

  GetSchedulesUseCase(this.repository);

  Future<({List<BellSchedule>? data, Failure? failure})> execute() async {
    return await repository.getSchedules();
  }
}
