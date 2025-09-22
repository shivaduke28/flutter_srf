import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'track.dart';
import '../library/repositories/library_service.dart';

part 'tracks_provider.g.dart';

@riverpod
class Tracks extends _$Tracks {
  @override
  Future<List<Track>> build() async {
    // libraryServiceの初期化を待つ
    await ref.watch(libraryServiceProvider.future);
    final libraryService = ref.read(libraryServiceProvider.notifier);
    return await libraryService.scanLibrary(forceRefresh: false);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final libraryService = ref.read(libraryServiceProvider.notifier);
      return await libraryService.scanLibrary(forceRefresh: true);
    });
  }

  Future<void> addTrack(Track track) async {
    final currentContainers = state.value ?? [];
    state = AsyncValue.data([...currentContainers, track]);
  }

  List<Track> searchTracks(String query) {
    final containers = state.value ?? [];
    if (query.isEmpty) return containers;

    final lowercaseQuery = query.toLowerCase();
    return containers.where((container) {
      return container.metadata.title.toLowerCase().contains(lowercaseQuery) ||
          container.metadata.artist.toLowerCase().contains(lowercaseQuery) ||
          (container.metadata.album?.toLowerCase().contains(lowercaseQuery) ??
              false);
    }).toList();
  }

  List<Track> sortTracks(List<Track> tracks, SortType sortType) {
    final sorted = [...tracks];

    switch (sortType) {
      case SortType.title:
        sorted.sort((a, b) => a.metadata.title.compareTo(b.metadata.title));
        break;
      case SortType.artist:
        sorted.sort((a, b) => a.metadata.artist.compareTo(b.metadata.artist));
        break;
      case SortType.dateAdded:
        sorted.sort((a, b) {
          final aDate = a.createdAt ?? DateTime(1970);
          final bDate = b.createdAt ?? DateTime(1970);
          return bDate.compareTo(aDate);
        });
        break;
    }

    return sorted;
  }
}

enum SortType { title, artist, dateAdded }
