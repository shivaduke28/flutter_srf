// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$albumsHash() => r'43b9d3f7299040c80df1cda46ed54e1a0e374ba4';

/// See also [albums].
@ProviderFor(albums)
final albumsProvider =
    AutoDisposeFutureProvider<Map<String, List<SrfContainer>>>.internal(
      albums,
      name: r'albumsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$albumsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlbumsRef =
    AutoDisposeFutureProviderRef<Map<String, List<SrfContainer>>>;
String _$albumsListHash() => r'cdaf1de83cb6b3986fa7e68b739f2fb4f6e98676';

/// See also [albumsList].
@ProviderFor(albumsList)
final albumsListProvider = AutoDisposeFutureProvider<List<AlbumInfo>>.internal(
  albumsList,
  name: r'albumsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$albumsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlbumsListRef = AutoDisposeFutureProviderRef<List<AlbumInfo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
