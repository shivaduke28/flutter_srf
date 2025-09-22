// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tracksHash() => r'3a1c076eb243adea47a35c62e3a27edc8f2210df';

/// TracksProvider - Provides track list from LibraryManager
///
/// Copied from [Tracks].
@ProviderFor(Tracks)
final tracksProvider =
    AutoDisposeAsyncNotifierProvider<Tracks, List<Track>>.internal(
      Tracks.new,
      name: r'tracksProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tracksHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Tracks = AutoDisposeAsyncNotifier<List<Track>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
