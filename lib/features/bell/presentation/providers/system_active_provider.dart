import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'shared_preferences_provider.dart';

part 'system_active_provider.g.dart';

@Riverpod(keepAlive: true)
class SystemActive extends _$SystemActive {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool('system_active') ?? true;
  }

  Future<void> toggle() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final newValue = !state;
    await prefs.setBool('system_active', newValue);
    state = newValue;
  }
}
