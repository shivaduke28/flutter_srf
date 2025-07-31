import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/srf_container.dart';
import '../services/library_service.dart';

part 'srf_containers_provider.g.dart';

@riverpod
class SrfContainers extends _$SrfContainers {
  @override
  Future<List<SrfContainer>> build() async {
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

  Future<void> addContainer(SrfContainer container) async {
    final currentContainers = state.value ?? [];
    state = AsyncValue.data([...currentContainers, container]);
  }

  List<SrfContainer> searchContainers(String query) {
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

  List<SrfContainer> sortContainers(
    List<SrfContainer> containers,
    SortType sortType,
  ) {
    final sorted = [...containers];

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
