import 'dart:async';
import 'package:intl/intl.dart';

class TimerService {
  Timer? _timer;
  final StreamController<DateTime> _timeController = StreamController<DateTime>.broadcast();

  Stream<DateTime> get timeStream => _timeController.stream;

  void startTimer() {
    if (_timer != null && _timer!.isActive) return;
    
    _timeController.add(DateTime.now());
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeController.add(DateTime.now());
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  String getFormattedTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  String getFormattedTimeWithSeconds(DateTime time) {
    return DateFormat('HH:mm:ss').format(time);
  }
}
