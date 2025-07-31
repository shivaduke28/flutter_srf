import 'package:just_audio/just_audio.dart';
import 'package:flutter_srf/models/srf_container.dart';
import 'package:path/path.dart' as path;

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get player => _audioPlayer;

  Future<void> play(SrfContainer container) async {
    final audioFile = container.audioFiles.firstOrNull;
    if (audioFile == null) {
      throw Exception('No audio file found in container');
    }

    final audioPath = path.join(container.path, audioFile);
    await _audioPlayer.setFilePath(audioPath);
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  double get volume => _audioPlayer.volume;

  void dispose() {
    _audioPlayer.dispose();
  }
}
