// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queried_albums_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$queriedAlbumsHash() => r'01ce67305dcc9423eb600b9b817b34e38fd38b3f';

/// フィルタリング・ソート済みのアルバムリストを提供
///
/// Copied from [queriedAlbums].
@ProviderFor(queriedAlbums)
final queriedAlbumsProvider = AutoDisposeFutureProvider<List<Album>>.internal(
  queriedAlbums,
  name: r'queriedAlbumsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$queriedAlbumsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QueriedAlbumsRef = AutoDisposeFutureProviderRef<List<Album>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
