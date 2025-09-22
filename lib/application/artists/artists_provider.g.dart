// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$artistsHash() => r'36c3d16344dccc201db440fc6106caccdf7ed589';

/// See also [artists].
@ProviderFor(artists)
final artistsProvider =
    AutoDisposeFutureProvider<Map<String, List<Track>>>.internal(
      artists,
      name: r'artistsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$artistsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArtistsRef = AutoDisposeFutureProviderRef<Map<String, List<Track>>>;
String _$artistsListHash() => r'71ab4a1828b2733dbdaa6c4d41c8a7c845ddcadc';

/// See also [artistsList].
@ProviderFor(artistsList)
final artistsListProvider =
    AutoDisposeFutureProvider<List<ArtistInfo>>.internal(
      artistsList,
      name: r'artistsListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$artistsListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArtistsListRef = AutoDisposeFutureProviderRef<List<ArtistInfo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
