// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$albumTracksHash() => r'812227323ace9a5bd20bcebe3d5b9901ce4df84b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// アルバムの詳細情報（トラック順序を保持）を提供するプロバイダー
///
/// Copied from [albumTracks].
@ProviderFor(albumTracks)
const albumTracksProvider = AlbumTracksFamily();

/// アルバムの詳細情報（トラック順序を保持）を提供するプロバイダー
///
/// Copied from [albumTracks].
class AlbumTracksFamily extends Family<AsyncValue<List<Track>>> {
  /// アルバムの詳細情報（トラック順序を保持）を提供するプロバイダー
  ///
  /// Copied from [albumTracks].
  const AlbumTracksFamily();

  /// アルバムの詳細情報（トラック順序を保持）を提供するプロバイダー
  ///
  /// Copied from [albumTracks].
  AlbumTracksProvider call(Album album) {
    return AlbumTracksProvider(album);
  }

  @override
  AlbumTracksProvider getProviderOverride(
    covariant AlbumTracksProvider provider,
  ) {
    return call(provider.album);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'albumTracksProvider';
}

/// アルバムの詳細情報（トラック順序を保持）を提供するプロバイダー
///
/// Copied from [albumTracks].
class AlbumTracksProvider extends AutoDisposeFutureProvider<List<Track>> {
  /// アルバムの詳細情報（トラック順序を保持）を提供するプロバイダー
  ///
  /// Copied from [albumTracks].
  AlbumTracksProvider(Album album)
    : this._internal(
        (ref) => albumTracks(ref as AlbumTracksRef, album),
        from: albumTracksProvider,
        name: r'albumTracksProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$albumTracksHash,
        dependencies: AlbumTracksFamily._dependencies,
        allTransitiveDependencies: AlbumTracksFamily._allTransitiveDependencies,
        album: album,
      );

  AlbumTracksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.album,
  }) : super.internal();

  final Album album;

  @override
  Override overrideWith(
    FutureOr<List<Track>> Function(AlbumTracksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AlbumTracksProvider._internal(
        (ref) => create(ref as AlbumTracksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        album: album,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Track>> createElement() {
    return _AlbumTracksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumTracksProvider && other.album == album;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, album.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AlbumTracksRef on AutoDisposeFutureProviderRef<List<Track>> {
  /// The parameter `album` of this provider.
  Album get album;
}

class _AlbumTracksProviderElement
    extends AutoDisposeFutureProviderElement<List<Track>>
    with AlbumTracksRef {
  _AlbumTracksProviderElement(super.provider);

  @override
  Album get album => (origin as AlbumTracksProvider).album;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
