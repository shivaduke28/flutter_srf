// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$artistDetailHash() => r'05f4ed3862e3f79fd6141e076e6adc297a7fb56b';

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

/// アーティストの詳細情報（トラックをアルバムごとにグループ化）を提供するプロバイダー
///
/// Copied from [artistDetail].
@ProviderFor(artistDetail)
const artistDetailProvider = ArtistDetailFamily();

/// アーティストの詳細情報（トラックをアルバムごとにグループ化）を提供するプロバイダー
///
/// Copied from [artistDetail].
class ArtistDetailFamily extends Family<AsyncValue<ArtistDetailData>> {
  /// アーティストの詳細情報（トラックをアルバムごとにグループ化）を提供するプロバイダー
  ///
  /// Copied from [artistDetail].
  const ArtistDetailFamily();

  /// アーティストの詳細情報（トラックをアルバムごとにグループ化）を提供するプロバイダー
  ///
  /// Copied from [artistDetail].
  ArtistDetailProvider call(Artist artist) {
    return ArtistDetailProvider(artist);
  }

  @override
  ArtistDetailProvider getProviderOverride(
    covariant ArtistDetailProvider provider,
  ) {
    return call(provider.artist);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'artistDetailProvider';
}

/// アーティストの詳細情報（トラックをアルバムごとにグループ化）を提供するプロバイダー
///
/// Copied from [artistDetail].
class ArtistDetailProvider extends AutoDisposeFutureProvider<ArtistDetailData> {
  /// アーティストの詳細情報（トラックをアルバムごとにグループ化）を提供するプロバイダー
  ///
  /// Copied from [artistDetail].
  ArtistDetailProvider(Artist artist)
    : this._internal(
        (ref) => artistDetail(ref as ArtistDetailRef, artist),
        from: artistDetailProvider,
        name: r'artistDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$artistDetailHash,
        dependencies: ArtistDetailFamily._dependencies,
        allTransitiveDependencies:
            ArtistDetailFamily._allTransitiveDependencies,
        artist: artist,
      );

  ArtistDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.artist,
  }) : super.internal();

  final Artist artist;

  @override
  Override overrideWith(
    FutureOr<ArtistDetailData> Function(ArtistDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ArtistDetailProvider._internal(
        (ref) => create(ref as ArtistDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        artist: artist,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ArtistDetailData> createElement() {
    return _ArtistDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArtistDetailProvider && other.artist == artist;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, artist.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ArtistDetailRef on AutoDisposeFutureProviderRef<ArtistDetailData> {
  /// The parameter `artist` of this provider.
  Artist get artist;
}

class _ArtistDetailProviderElement
    extends AutoDisposeFutureProviderElement<ArtistDetailData>
    with ArtistDetailRef {
  _ArtistDetailProviderElement(super.provider);

  @override
  Artist get artist => (origin as ArtistDetailProvider).artist;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
