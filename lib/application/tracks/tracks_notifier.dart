import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'track.dart';
import 'track_repository.dart';

part 'tracks_notifier.freezed.dart';
part 'tracks_notifier.g.dart';

@freezed
sealed class TracksState with _$TracksState {
  const factory TracksState({required List<Track> allTracks}) = _TracksState;
}

@Riverpod(keepAlive: true)
class TracksController extends _$TracksController {
  @override
  Future<TracksState> build() async {
    // TrackRepositoryからトラックを取得
    final repository = ref.watch(trackRepositoryProvider);
    final tracks = await repository.getAllTracks();

    return TracksState(allTracks: tracks);
  }

  /// トラックリストを更新
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(trackRepositoryProvider);
      final tracks = await repository.getAllTracks();
      return TracksState(allTracks: tracks);
    });
  }
}
