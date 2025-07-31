// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioPlayerServiceHash() =>
    r'b7b245a4f0e319a6993406c9e4ae00a0138b652e';

/// See also [audioPlayerService].
@ProviderFor(audioPlayerService)
final audioPlayerServiceProvider = Provider<AudioPlayerService>.internal(
  audioPlayerService,
  name: r'audioPlayerServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioPlayerServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AudioPlayerServiceRef = ProviderRef<AudioPlayerService>;
String _$playerStateHash() => r'fb699cb0705a7fa40a74efc4ff2d6bce00567169';

/// See also [PlayerState].
@ProviderFor(PlayerState)
final playerStateProvider =
    NotifierProvider<PlayerState, app_player.PlayerState>.internal(
      PlayerState.new,
      name: r'playerStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$playerStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PlayerState = Notifier<app_player.PlayerState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
