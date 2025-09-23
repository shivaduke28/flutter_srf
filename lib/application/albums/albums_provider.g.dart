// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$albumsHash() => r'698c25bfe8eaca21fbb741eaa999f4724488f742';

/// トラックリストからアルバムを生成する純粋なProvider
///
/// Copied from [albums].
@ProviderFor(albums)
final albumsProvider = AutoDisposeFutureProvider<List<Album>>.internal(
  albums,
  name: r'albumsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$albumsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AlbumsRef = AutoDisposeFutureProviderRef<List<Album>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
