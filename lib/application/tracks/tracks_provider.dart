import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'track.dart';
import 'track_repository.dart';

part 'tracks_provider.g.dart';

/// TracksProvider - Provides track list from TrackRepository
/// Simply watches the TrackRepository state
@riverpod
class Tracks extends _$Tracks {
  @override
  Future<List<Track>> build() async {
    // Simply return the current state of TrackRepository
    return ref.watch(trackRepositoryProvider);
  }
}
