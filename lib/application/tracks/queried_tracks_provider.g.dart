// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queried_tracks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$queriedTracksHash() => r'19f22f515fa88dd26b9c6118d68766d5829fe877';

/// フィルタリング・ソート済みのトラックリストを提供
///
/// Copied from [queriedTracks].
@ProviderFor(queriedTracks)
final queriedTracksProvider = AutoDisposeFutureProvider<List<Track>>.internal(
  queriedTracks,
  name: r'queriedTracksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$queriedTracksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QueriedTracksRef = AutoDisposeFutureProviderRef<List<Track>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
