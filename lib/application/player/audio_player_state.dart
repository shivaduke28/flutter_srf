import 'package:flutter_srf/application/tracks/track.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_player_state.freezed.dart';

@freezed
sealed class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState({
    Track? currentContainer,
    @Default(PlayerStatus.stopped) PlayerStatus status,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration duration,
    @Default(1.0) double volume,
  }) = _AudioPlayerState;
}

enum PlayerStatus { playing, paused, stopped }
