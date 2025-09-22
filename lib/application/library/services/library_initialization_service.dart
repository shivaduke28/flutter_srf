import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../tracks/track_repository.dart';
import '../repositories/library_service.dart';

part 'library_initialization_service.g.dart';

/// Service for initializing and refreshing the library
/// Handles the coordination between LibraryService and TrackRepository
@riverpod
class LibraryInitializationService extends _$LibraryInitializationService {
  @override
  Future<void> build() async {
    // Initialize library on first load
    await initializeLibrary();
  }

  Future<void> initializeLibrary() async {
    try {
      // Wait for library service to be ready
      await ref.read(libraryServiceProvider.future);

      // Load tracks from library
      final libraryService = ref.read(libraryServiceProvider.notifier);
      final tracks = await libraryService.scanLibrary(forceRefresh: false);

      // Initialize track repository
      final repository = ref.read(trackRepositoryProvider.notifier);
      repository.initialize(tracks);
    } catch (e) {
      // Re-throw the error to be handled by the UI
      throw Exception('Failed to initialize library: $e');
    }
  }

  Future<void> refreshLibrary() async {
    try {
      // Rescan library with force refresh
      final libraryService = ref.read(libraryServiceProvider.notifier);
      final tracks = await libraryService.scanLibrary(forceRefresh: true);

      // Update track repository
      final repository = ref.read(trackRepositoryProvider.notifier);
      repository.initialize(tracks);
    } catch (e) {
      throw Exception('Failed to refresh library: $e');
    }
  }
}