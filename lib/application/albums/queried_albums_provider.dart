import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'album.dart';
import 'albums_provider.dart';
import 'album_query_controller.dart';

part 'queried_albums_provider.g.dart';

/// フィルタリング・ソート済みのアルバムリストを提供
@riverpod
Future<List<Album>> queriedAlbums(Ref ref) async {
  final queryState = ref.watch(albumQueryControllerProvider);
  final albums = await ref.watch(albumsProvider.future);

  // フィルタリング
  var filteredAlbums = albums;
  if (queryState.searchQuery.isNotEmpty) {
    final lowerQuery = queryState.searchQuery.toLowerCase();
    filteredAlbums = albums.where((album) {
      return album.name.toLowerCase().contains(lowerQuery) || (album.artist?.toLowerCase() ?? '').contains(lowerQuery);
    }).toList();
  }

  // ソート
  switch (queryState.sortType) {
    case AlbumSortType.name:
      filteredAlbums.sort((a, b) => a.name.compareTo(b.name));
      break;
    case AlbumSortType.artist:
      filteredAlbums.sort((a, b) => (a.artist ?? '').compareTo(b.artist ?? ''));
      break;
    case AlbumSortType.trackCount:
      filteredAlbums.sort((a, b) => b.srfContainerIds.length.compareTo(a.srfContainerIds.length));
      break;
  }

  return filteredAlbums;
}
