// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$artistsHash() => r'1ee965ea88d1333152daa46ebc647de3fcfed455';

/// トラックリストからアーティストを生成する純粋なProvider
///
/// Copied from [artists].
@ProviderFor(artists)
final artistsProvider = AutoDisposeFutureProvider<List<Artist>>.internal(
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
typedef ArtistsRef = AutoDisposeFutureProviderRef<List<Artist>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
