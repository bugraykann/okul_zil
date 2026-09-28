import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/bell_local_datasource.dart';
import '../../data/repositories/bell_repository_impl.dart';
import '../../domain/repositories/bell_repository.dart';
import '../../domain/usecases/get_schedules_usecase.dart';
import 'shared_preferences_provider.dart';

part 'bell_repository_provider.g.dart';

@Riverpod(keepAlive: true)
BellLocalDataSource bellLocalDataSource(Ref ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return BellLocalDataSourceImpl(sharedPreferences: sharedPrefs);
}

@Riverpod(keepAlive: true)
BellRepository bellRepository(Ref ref) {
  final localDataSource = ref.watch(bellLocalDataSourceProvider);
  return BellRepositoryImpl(localDataSource: localDataSource);
}

@Riverpod(keepAlive: true)
GetSchedulesUseCase getSchedulesUseCase(Ref ref) {
  final repository = ref.watch(bellRepositoryProvider);
  return GetSchedulesUseCase(repository);
}
