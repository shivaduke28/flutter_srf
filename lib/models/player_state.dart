import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_srf/models/srf_container.dart';

part 'player_state.freezed.dart';

@freezed
sealed class PlayerState with _$PlayerState {
  const factory PlayerState({
    SrfContainer? currentContainer,
    @Default(PlayerStatus.stopped) PlayerStatus status,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration duration,
  }) = _PlayerState;
}

enum PlayerStatus { playing, paused, stopped }
