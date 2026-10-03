import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isManualPlaying = false;

  AudioService() {
    _audioPlayer.onPlayerComplete.listen((event) {
      _isPlaying = false;
      _isManualPlaying = false;
    });
  }

  Future<void> playAudio(String path, {bool isManual = false}) async {
    // Manuel bir zil çalıyorken, otomatik bir zil çalmaya çalışırsa yok sayılır.
    if (_isPlaying && _isManualPlaying && !isManual) {
      return;
    }

    // Halihazırda bir şey çalıyorsa durdur (örn: otomatik çalarken manuele basılırsa)
    if (_isPlaying) {
      await stopAudio();
    }

    try {
      _isPlaying = true;
      _isManualPlaying = isManual;

      if (path.startsWith('assets/')) {
        await _audioPlayer.play(AssetSource(path.replaceFirst('assets/', '')));
      } else {
        await _audioPlayer.play(DeviceFileSource(path));
      }
    } catch (e) {
      _isPlaying = false;
      _isManualPlaying = false;
    }
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _isManualPlaying = false;
  }
}
