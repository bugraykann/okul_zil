import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'shared_preferences_provider.dart';
import 'core_providers.dart';

part 'volume_provider.g.dart';

@Riverpod(keepAlive: true)
class VolumeController extends _$VolumeController {
  @override
  double build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedVolume = prefs.getDouble('master_volume') ?? 1.0;
    
    // Initialize audio service volume asynchronously without blocking build
    Future.microtask(() {
      ref.read(audioServiceProvider).setVolume(savedVolume);
    });
    
    return savedVolume;
  }

  Future<void> setVolume(double volume) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setDouble('master_volume', volume);
    await ref.read(audioServiceProvider).setVolume(volume);
    state = volume;
  }
}
