// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trackRepositoryHash() => r'ed7079a41b12f65b440aa0c210e2b4b010c7d336';

/// Track Repository - Single Source of Truth for tracks
/// This repository manages the in-memory track list
/// Does not handle file I/O operations directly
///
/// Copied from [TrackRepository].
@ProviderFor(TrackRepository)
final trackRepositoryProvider =
    NotifierProvider<TrackRepository, List<Track>>.internal(
      TrackRepository.new,
      name: r'trackRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$trackRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TrackRepository = Notifier<List<Track>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
