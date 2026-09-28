import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'shared_preferences_provider.dart';

part 'log_provider.g.dart';

class BellLog {
  final DateTime timestamp;
  final String message;
  final String type; // 'auto' or 'manual'

  BellLog({required this.timestamp, required this.message, required this.type});

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'message': message,
    'type': type,
  };

  factory BellLog.fromJson(Map<String, dynamic> json) => BellLog(
    timestamp: DateTime.parse(json['timestamp']),
    message: json['message'],
    type: json['type'],
  );
}

@Riverpod(keepAlive: true)
class LogManager extends _$LogManager {
  static const _logsKey = 'bell_logs';
  static const _maxLogs = 200; // Son 200 kaydı tutalım

  @override
  List<BellLog> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final logsJson = prefs.getStringList(_logsKey) ?? [];
    try {
      return logsJson.map((e) => BellLog.fromJson(jsonDecode(e))).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addLog(String message, {String type = 'auto'}) async {
    final newLog = BellLog(timestamp: DateTime.now(), message: message, type: type);
    final newList = [newLog, ...state];
    
    if (newList.length > _maxLogs) {
      newList.removeRange(_maxLogs, newList.length);
    }
    
    state = newList;
    
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(
      _logsKey, 
      newList.map((e) => jsonEncode(e.toJson())).toList()
    );
  }

  Future<void> clearLogs() async {
    state = [];
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(_logsKey);
  }
}
