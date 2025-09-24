import 'package:flutter_srf/application/artists/artist.dart';
import 'package:flutter_srf/application/tracks/track.dart';
import 'package:flutter_srf/application/tracks/tracks_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artist_detail_provider.g.dart';

/// アーティストのトラックをアルバムごとにグループ化したデータ
class ArtistDetailData {
  final Artist artist;
  final Map<String, List<Track>> albumGroups;
  final List<String> sortedAlbumNames;

  ArtistDetailData({required this.artist, required this.albumGroups, required this.sortedAlbumNames});
}

/// アーティストの詳細情報（トラックをアルバムごとにグループ化）を提供するプロバイダー
@riverpod
Future<ArtistDetailData> artistDetail(Ref ref, Artist artist) async {
  final tracksState = await ref.watch(tracksControllerProvider.future);

  // アーティストのトラックIDに一致するトラックを取得
  final artistTracks = tracksState.allTracks.where((track) {
    return artist.trackIds.contains(track.id);
  }).toList();

  // アルバムごとにグループ化
  final albumGroups = <String, List<Track>>{};
  for (final track in artistTracks) {
    final albumName = track.album;
    albumGroups.putIfAbsent(albumName, () => []).add(track);
  }

  // アルバム名でソート
  final sortedAlbumNames = albumGroups.keys.toList()..sort();

  return ArtistDetailData(artist: artist, albumGroups: albumGroups, sortedAlbumNames: sortedAlbumNames);
}
