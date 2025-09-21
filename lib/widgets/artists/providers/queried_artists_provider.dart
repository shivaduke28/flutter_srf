import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/artists_provider.dart';
import 'artist_sort_type_provider.dart';
import 'artist_query_provider.dart';

part 'queried_artists_provider.g.dart';

@riverpod
Future<List<ArtistInfo>> queriedArtists(Ref ref) async {
  final artistsList = await ref.watch(artistsListProvider.future);
  final sortType = ref.watch(artistSortTypeNotifierProvider);
  final query = ref.watch(artistQueryNotifierProvider);

  var filteredArtists = [...artistsList];

  // フィルタリング
  if (query.isNotEmpty) {
    final lowerQuery = query.toLowerCase();
    filteredArtists = filteredArtists.where((artist) {
      return artist.name.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // ソート
  switch (sortType) {
    case ArtistSortType.name:
      filteredArtists.sort((a, b) => a.name.compareTo(b.name));
      break;
    case ArtistSortType.trackCount:
      filteredArtists.sort((a, b) => b.trackCount.compareTo(a.trackCount));
      break;
    case ArtistSortType.albumCount:
      filteredArtists.sort((a, b) => b.albumCount.compareTo(a.albumCount));
      break;
  }

  return filteredArtists;
}
