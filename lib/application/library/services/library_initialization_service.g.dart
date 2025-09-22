// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_initialization_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryInitializationServiceHash() =>
    r'a2d3683fe1f230b2148ee93f85fba5c894d04edf';

/// Service for initializing and refreshing the library
/// Handles the coordination between LibraryService and TrackRepository
///
/// Copied from [LibraryInitializationService].
@ProviderFor(LibraryInitializationService)
final libraryInitializationServiceProvider =
    AutoDisposeAsyncNotifierProvider<
      LibraryInitializationService,
      void
    >.internal(
      LibraryInitializationService.new,
      name: r'libraryInitializationServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$libraryInitializationServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LibraryInitializationService = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
