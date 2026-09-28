import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/bell_schedule.dart';

abstract class BellLocalDataSource {
  Future<List<BellSchedule>> getSchedules();
  Future<void> saveSchedules(List<BellSchedule> schedules);
}

class BellLocalDataSourceImpl implements BellLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cacheKey = 'BELL_SCHEDULES';

  BellLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<BellSchedule>> getSchedules() async {
    try {
      final jsonString = sharedPreferences.getString(cacheKey);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((e) => BellSchedule.fromJson(e)).toList();
      } else {
        // Return default schedules if empty
        return [
          const BellSchedule(id: '1', time: '08:30', audioPath: 'assets/audio/bell.mp3', title: 'Ders Zili'),
          const BellSchedule(id: '2', time: '09:10', audioPath: 'assets/audio/bell.mp3', title: 'Teneffüs Zili'),
        ];
      }
    } catch (e) {
      throw CacheException(message: 'Veriler okunamadı');
    }
  }

  @override
  Future<void> saveSchedules(List<BellSchedule> schedules) async {
    try {
      final jsonList = schedules.map((e) => e.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(cacheKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Veriler kaydedilemedi');
    }
  }
}
