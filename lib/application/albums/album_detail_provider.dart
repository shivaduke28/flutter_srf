import 'package:flutter_srf/application/albums/album.dart';
import 'package:flutter_srf/application/tracks/track.dart';
import 'package:flutter_srf/application/tracks/tracks_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'album_detail_provider.g.dart';

/// アルバムの詳細情報（トラック順序を保持）を提供するプロバイダー
@riverpod
Future<List<Track>> albumTracks(Ref ref, Album album) async {
  final tracksState = await ref.watch(tracksControllerProvider.future);

  // アルバムのトラックIDに一致するトラックを取得し、順番を保持
  final albumTracks = <Track>[];
  for (final trackId in album.srfContainerIds) {
    final track = tracksState.allTracks.firstWhere(
      (t) => t.id == trackId,
      orElse: () => Track(
        id: trackId,
        filePath: '',
        title: 'Unknown Track',
        artist: 'Unknown Artist',
        album: album.name,
        duration: 0,
      ),
    );
    albumTracks.add(track);
  }

  return albumTracks;
}
