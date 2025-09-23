// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queried_artists_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$queriedArtistsHash() => r'997682068413600572f05620e4ac5fcb4eb6a109';

/// フィルタリング・ソート済みのアーティストリストを提供
///
/// Copied from [queriedArtists].
@ProviderFor(queriedArtists)
final queriedArtistsProvider = AutoDisposeFutureProvider<List<Artist>>.internal(
  queriedArtists,
  name: r'queriedArtistsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$queriedArtistsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QueriedArtistsRef = AutoDisposeFutureProviderRef<List<Artist>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
