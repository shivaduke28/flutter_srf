import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/albums_provider.dart';
import 'album_sort_type_provider.dart';
import 'album_query_provider.dart';

part 'queried_albums_provider.g.dart';

@riverpod
Future<List<AlbumInfo>> queriedAlbums(Ref ref) async {
  final albumMap = await ref.watch(albumsProvider.future);
  final sortType = ref.watch(albumSortTypeNotifierProvider);
  final query = ref.watch(albumQueryNotifierProvider);

  var albumInfoList = albumMap.entries.map((entry) {
    final albumName = entry.key;
    final tracks = entry.value;
    final firstTrack = tracks.first;

    return AlbumInfo(
      name: albumName,
      artist: firstTrack.metadata.albumArtist ?? firstTrack.metadata.artist,
      year: firstTrack.metadata.year,
      trackCount: tracks.length,
      tracks: tracks,
    );
  }).toList();

  // フィルタリング
  if (query.isNotEmpty) {
    final lowerQuery = query.toLowerCase();
    albumInfoList = albumInfoList.where((album) {
      return album.name.toLowerCase().contains(lowerQuery) ||
          album.artist.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // ソート
  switch (sortType) {
    case AlbumSortType.name:
      albumInfoList.sort((a, b) => a.name.compareTo(b.name));
      break;
    case AlbumSortType.artist:
      albumInfoList.sort((a, b) => a.artist.compareTo(b.artist));
      break;
    case AlbumSortType.year:
      albumInfoList.sort((a, b) {
        final aYear = a.year ?? 9999;
        final bYear = b.year ?? 9999;
        return aYear.compareTo(bYear);
      });
      break;
    case AlbumSortType.trackCount:
      albumInfoList.sort((a, b) => b.trackCount.compareTo(a.trackCount));
      break;
  }

  return albumInfoList;
}
