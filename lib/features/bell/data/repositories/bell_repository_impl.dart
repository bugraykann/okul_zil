import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/bell_schedule.dart';
import '../../domain/repositories/bell_repository.dart';
import '../datasources/bell_local_datasource.dart';

class BellRepositoryImpl implements BellRepository {
  final BellLocalDataSource localDataSource;

  BellRepositoryImpl({required this.localDataSource});

  @override
  Future<({List<BellSchedule>? data, Failure? failure})> getSchedules() async {
    try {
      final result = await localDataSource.getSchedules();
      return (data: result, failure: null);
    } on CacheException catch (e) {
      return (data: null, failure: CacheFailure(e.message));
    } catch (e) {
      return (data: null, failure: CacheFailure('Bilinmeyen bir hata oluştu'));
    }
  }

  @override
  Future<({bool? success, Failure? failure})> saveSchedules(List<BellSchedule> schedules) async {
    try {
      await localDataSource.saveSchedules(schedules);
      return (success: true, failure: null);
    } on CacheException catch (e) {
      return (success: null, failure: CacheFailure(e.message));
    } catch (e) {
      return (success: null, failure: CacheFailure('Bilinmeyen bir hata oluştu'));
    }
  }
}
