import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'shared_preferences_provider.dart';

part 'logo_provider.g.dart';

@Riverpod(keepAlive: true)
class LogoController extends _$LogoController {
  @override
  String? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString('school_logo_path');
  }

  Future<void> setLogoPath(String? path) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (path == null) {
      await prefs.remove('school_logo_path');
    } else {
      await prefs.setString('school_logo_path', path);
    }
    state = path;
  }
}
