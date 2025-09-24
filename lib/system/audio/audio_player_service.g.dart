// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioPlayerServiceHash() =>
    r'848c0c2de0c2b56f7ce97e756329a3c1eb3f185a';

/// 音楽再生のための低レベルサービス
/// just_audioへの依存をここで隠蔽
///
/// Copied from [audioPlayerService].
@ProviderFor(audioPlayerService)
final audioPlayerServiceProvider =
    AutoDisposeProvider<AudioPlayerService>.internal(
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
typedef AudioPlayerServiceRef = AutoDisposeProviderRef<AudioPlayerService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
