import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_srf/application/artists/artist.dart';
import 'package:flutter_srf/application/artists/artist_query_controller.dart';
import 'package:flutter_srf/application/artists/artists_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'queried_artists_provider.g.dart';

/// フィルタリング・ソート済みのアーティストリストを提供
@riverpod
Future<List<Artist>> queriedArtists(Ref ref) async {
  final queryState = ref.watch(artistQueryControllerProvider);
  final artists = await ref.watch(artistsProvider.future);

  // フィルタリング
  var filteredArtists = artists;
  if (queryState.searchQuery.isNotEmpty) {
    final lowerQuery = queryState.searchQuery.toLowerCase();
    filteredArtists = artists.where((artist) {
      return artist.name.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // ソート
  switch (queryState.sortType) {
    case ArtistSortType.name:
      filteredArtists.sort((a, b) => a.name.compareTo(b.name));
      break;
    case ArtistSortType.albumCount:
      filteredArtists.sort((a, b) => b.albumIds.length.compareTo(a.albumIds.length));
      break;
    case ArtistSortType.trackCount:
      filteredArtists.sort((a, b) => b.trackIds.length.compareTo(a.trackIds.length));
      break;
  }

  return filteredArtists;
}
