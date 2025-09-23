// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioPlayerControllerHash() =>
    r'9936bc8cc1566be11e445c2d2b7d3d303b13dddc';

/// 音楽再生の状態管理とビジネスロジックを担当
///
/// Copied from [AudioPlayerController].
@ProviderFor(AudioPlayerController)
final audioPlayerControllerProvider =
    NotifierProvider<AudioPlayerController, AudioPlayerState>.internal(
      AudioPlayerController.new,
      name: r'audioPlayerControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$audioPlayerControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AudioPlayerController = Notifier<AudioPlayerState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
